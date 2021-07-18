/*
input: CFG with lowIR
output: CFG with newIR

note:
    1. What is newIR?
    ----将之前四元式中的指令替换为汇编指令，暂不处理寄存器，使用decel（每一个变量被赋值都会多一个decel，在多个变量合并的时候，需要插入phi节点）
*/

#include "ssa.h"
#include "decl.h"
#include "armInstruciton.h"
#include "semanticAnalyze.h"
#include "Instruction.h"
#include"BuildIR.h"
#include "dbg.h"
#include<bits/stdc++.h>
using namespace std;

map<BasicBlock*, int>ssa_vis;
ssa* ssaIR=new ssa();
int Rcnt;

///
ostream & operator << (ostream &out,const Decl *A)
{
    out<<"@ NULL";
    return out;
}
ostream & operator << (ostream &out,const constDecl *A)
{
    out<<"#"<<A->value;
    return out;
}
ostream & operator << (ostream &out,const varDecl *A)
{
    out<<"r"<<A->Vreg;
    return out;
}


////

void assignMov(Instruction* instr, BasicBlock* node)
{
    
}

void assignAdd(Instruction* instr,BasicBlock *node)
{
    armAdd *ins=new armAdd();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];

    if(r0->isConst==1)swap(r1,r0);
    //目的value多了一次赋值记录
    varDecl *resd = new varDecl(res,node,(armInstr*)ins,Rcnt++);
    ins->rd = (Decl*)resd;

    ssaIR->Assign_rec[res].push_back((Decl*)resd);
    //第一个操作数转换为赋值
    varDecl *r0d = (varDecl *)ssaIR->Assign_rec[r0].back();
    r0d->usesd.push_back(ins);//这个decl用了一次
    ins->r0 = (Decl*)r0d;
    if (r1->isConst)
    {//如果是常量,也搞成一个赋值,不过没什么意义
        constDecl *r1d = new constDecl((Value*)r1,node,(armInstr*)ins,r1->RealValue);
        ins->r1 = (Decl*)r1d;
    }
    else
    {//第二个操作数转换为赋值
        varDecl *r1d = (varDecl *)ssaIR->Assign_rec[r1].back();
        r1d->usesd.push_back(ins);
        ins->r1 = (Decl*)r1d;
    }
    cout<<ins<<endl;
}

void assignIns(Instruction* ins,BasicBlock* node)
{//依照不同类型的指令，进行转换IR
    if(ins->getOpType() == Instruction::Add)
    {
        assignAdd(ins,node);
    }
    
}

void DeclBlock(BasicBlock *node)
{
    if(ssa_vis[node])ssa_vis[node]++;
    else ssa_vis[node]=1;
    if(ssa_vis[node]<node->pioneerBlock.size())return;
    for(auto i : node->InstrList)
    {
        //转换IR
        //修改Assign_rec
        assignIns(IR1->InstList[i],node);
    }
}
void setDecl()
{
    for(auto i : IR1->Blocks)
    {
        if(i->domBlock.size())DeclBlock(i->domBlock[0]);
        else{dbg("error");}
    }
}

struct DomTreenode
{
    set<DomTreenode*> son;
    BasicBlock* block;
    DomTreenode *fa;
};
vector<DomTreenode*> DomRoot;
map<BasicBlock*,bool>visDomTree;
set<BasicBlock*>DomSon;
map<BasicBlock*,DomTreenode*> block2dom;

void dfsinit(BasicBlock *s)
{
    DomSon.insert(s);
    for(auto i : s->succBlock)
    {
        if(DomSon.count(i))continue;
        dfsinit(s);
    }
}

void dfsbuild(BasicBlock *s)
{
    if(visDomTree[s])return ;
    DomSon.erase(DomSon.find(s));
    visDomTree[s]=1;
    for(auto i:s->succBlock)dfsbuild(i);
}

void del(DomTreenode *root)
{
    set<DomTreenode*> tem;
    tem.clear();
    for(auto i : root->son)
        set_difference(root->son.begin(),root->son.end(),i->son.begin(),i->son.end(),tem,tem.end());
    root->son=tem;
    for(auto i : root->son){i->fa=root;del(i);}
}

void buildDomTree(BasicBlock *s)
{
    for(int i=0;i<s->domBlock.size();i++)
    {
        //init
        dfsinit(s->domBlock[0]);//假设控制点为全局
        visDomTree.clear();//vis清空
        visDomTree[s->domBlock[i]]=1;//这个点不可达
        DomSon.erase(DomSon.find(s->domBlock[i]));
        dfsbuild(s->domBlock[0]);//去掉可达点
        DomTreenode* sub=new DomTreenode();//子树的根
        block2dom[s->domBlock[i]]=sub;
        sub->block=s->domBlock[i];
        for( auto son : DomSon)
        {//建立子树
            DomTreenode *soni = new DomTreenode();
            soni->block=son;
            sub->son.insert(soni);
        }
        if(i==0)DomRoot.push_back(sub);//要记住每一棵控制树的根
    }
    del(DomRoot.back());//删除多余边
    return ;
}

void calDF(BasicBlock *b)
{
    
    if(b->pioneerBlock.size()>=2){
        for(auto i : b->pioneerBlock){
            auto runner=i;
            while(runner!=block2dom[b]->fa->block){
                set<BasicBlock*> tem;
                if(ssaIR->DF.count(i)==0)ssaIR->DF.insert(make_pair(i,tem));
                ssaIR->DF[i].insert(b);
                runner=block2dom[i]->fa->block;
            }
        }
    }
}


set<Value*> allValue;

void getAllValue()
{
    for(auto i : SymbolTable->table)
    {
        Value *tem = i.second;
        if(allValue.count(tem))continue;
        else allValue.insert(tem);
    }
}


map<BasicBlock*,bool> phiIns;
map<BasicBlock*,bool> Added;
queue<BasicBlock*> blist;

void placePhi()
{
    for(auto val : allValue){
        phiIns.clear();
        Added.clear();
        //这里是计算blist, 里面存的是对val赋过值的block
        for(auto b : ssaIR->AssbyBlock[val]){
            Added[b]=1;
            blist.push(b);
        }
        
        while(blist.size())
        {
            BasicBlock* nowb=blist.front();
            blist.pop();
            for(auto d : ssaIR->DF[nowb])
            {
                if(!phiIns[d]){
                    //add d one phi about val;
                    phiIns[d]=1;
                    if(!Added[d]){
                        Added[d]=1;
                        blist.push(d);
                    }
                }
            }

        }
    }
}

void getssa()
{
    //计算控制树
    //纯用定义算的, 目测O(n^3)
    for(auto i: IR1->Blocks){
        if(i->domBlock.size())buildDomTree(i);
    }
    //计算df;
    /* 好家伙, 还是抄着快(出处:https://blog.csdn.net/qq_29674357/article/details/78731713)
        1 for each node b
        2   if the number of immediate predecessors of b ≥ 2
        3     for each p in immediate predecessors of b
        4       runner := p
        5       while runner ≠ idom(b)
        6         add b to runner’s dominance frontier set
        7         runner := idom(runner)
    */
    for(auto i : IR1->Blocks){
        if(i->domBlock.size()){
            for(auto j : i->domBlock)calDF(j);
        }
    }
    // set decl
    setDecl();
    //继续抄!  002_SSA比较清楚的说明_Lecture23.4up.pdf
    placePhi();
}
