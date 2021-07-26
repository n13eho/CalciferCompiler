#include "ssa.h"
#include "decl.h"
#include "semanticAnalyze.h"
#include "Instruction.h"
#include"BuildIR.h"
#include "dbg.h"
#include<bits/stdc++.h>
using namespace std;

ssa* ssaIR=new ssa();

/*
    生成支配树
*/
vector<DomTreenode*> DomRoot;
map<BasicBlock*,DomTreenode*> block2dom;

//temperate define
map<DomTreenode*, int> semi;
map<DomTreenode*,DomTreenode*> parent;
map<DomTreenode*, vector<DomTreenode*> > bucket;
vector<DomTreenode*> vertex;
map<DomTreenode*,DomTreenode*> ancestor;
map<DomTreenode*,DomTreenode*> label;
int dfscnt=0; 

void tarjan_init()
{
    dfscnt=0;
    semi.clear();
    parent.clear();
    bucket.clear();
    vertex.clear();
}
void dfsLT(DomTreenode* dang)
{
    semi[dang]=++dfscnt;
    vertex.push_back(dang);
    BasicBlock* db=dang->block;
    for( auto i : db->succBlock){
        if(!block2dom.count(i)){
            block2dom[i]=new DomTreenode();
            block2dom[i]->block=i;
        }
        DomTreenode* nx = block2dom[i];
        if(!semi[nx]){
            parent[nx]=dang;
            dfsLT(nx);
        }
    }
}
void compress(DomTreenode* v)
{
    if(ancestor[ancestor[v]]!=0){
        compress(ancestor[v]);
        if(semi[label[ancestor[v]]]<semi[label[v]]){
            label[v]=label[ancestor[v]];
        }
        ancestor[v]=ancestor[ancestor[v]];   
    }
}
DomTreenode* eval(DomTreenode* v)
{
    if(ancestor[v]==0)return v;
    else{
        compress(v);
        return label[v];
    }
}

void step23()
{
    for(int i=vertex.size()-1;i>0;i--){
        auto w=vertex[i];
        BasicBlock* wb = w->block;
        for(auto vb: wb->pioneerBlock){
            DomTreenode* v=block2dom[vb];
            DomTreenode* u=eval(v);
            if(semi[u]<semi[w])semi[w]=semi[u];
        }
        // if(bucket.count(vertex[semi[w]-1])==0){
        //     vector<DomTreenode*> tem;
        //     bucket[vertex[semi[w]-1]]=tem;
        // }
        bucket[vertex[semi[w]-1]].push_back(w);
        ancestor[w]=parent[w];
        if(bucket.count(parent[w])==0)continue;
        for(auto i=bucket[parent[w]].begin();i<bucket[parent[w]].end();i++){
            auto v=*i;
            bucket[parent[w]].erase(i);
            --i;
            DomTreenode* u=eval(v);
            if(semi[u]<semi[v])v->idom=u;
            else v->idom=parent[w];
        }
    }
}

void step4()
{
    for(auto w : vertex){
        if(w==vertex.front())continue;
        if(w->idom!=vertex[semi[w]-1]){
            w->idom=w->idom->idom;
        }
        w->idom->son.push_back(w);
    }
    vertex[0]->idom=nullptr;
}

void buildDomTree(BasicBlock *s)
{
    //step1 求sdom
    tarjan_init();
    block2dom[s->domBlock[0]]=new DomTreenode();
    block2dom[s->domBlock[0]]->block=s->domBlock[0];
    DomTreenode* root=block2dom[s->domBlock[0]];
    root->func=s->FuncV;
    DomRoot.push_back(root);
    dfsLT(root);

    //step2\3
    ancestor[root]==0;
    for(auto i: vertex)label[i]=i;
    step23();

    step4();
}

void calDF(BasicBlock *b)
{
    /* 好家伙, 还是抄着快(出处:https://blog.csdn.net/qq_29674357/article/details/78731713)
        1 for each node b
        2   if the number of immediate predecessors of b ≥ 2
        3     for each p in immediate predecessors of b
        4       runner := p
        5       while runner ≠ idom(b)
        6         add b to runner’s dominance frontier set
        7         runner := idom(runner)
    */
    if(b->pioneerBlock.size()>=2){
        for(auto i : b->pioneerBlock){
            auto runner=i;
            while(runner!=block2dom[b]->idom->block){
                set<BasicBlock*> tem;
                if(ssaIR->DF.count(runner)==0)ssaIR->DF.insert(make_pair(runner,tem));
                ssaIR->DF[runner].insert(b);
                runner=block2dom[runner]->idom->block;
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
set<BasicBlock*> phiPos;

void addAssbyBlock(Value* val, BasicBlock* b)
{
    //块b多了一处对val的赋值
    // if(ssaIR->AssbyBlock.count(val)){
    //     vector<BasicBlock*> tem;
    //     ssaIR->AssbyBlock[val]=tem;
    // }
    ssaIR->AssbyBlock[val].push_back(b);
}

void setAssbyBlock(BasicBlock* s)
{
    for(auto i:s->InstrList)
    {
        Instruction *ins = IR1->InstList[i];
        if(ins->getOpType()>=Instruction::Add&&ins->getOpType()<=Instruction::LogicOr)
            addAssbyBlock(ins->getResult(),s);
        // else if(ins->getOpType()==)
        //还没想好load和store怎么处理
    }
}

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
        
        while(blist.size()){
            BasicBlock* nowb=blist.front();
            blist.pop();
            for(auto d : ssaIR->DF[nowb])
            {
                if(!phiIns[d]){
                    //add d one phi about val;
                    Instruction* ins=new Instruction(-1,Instruction::Phi,1);
                    ins->addOperand(val);
                    IR1->InsertInstr(ins);
                    d->InstrList.insert(d->InstrList.begin(),IR1->InstList.size()-1);
                    phiPos.insert(d);

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

int hasUsedGlobal(Instruction* ins,Value* stval)
{
    if(ins->getResult()==stval)return 1;
    for(auto val:ins->getOp()){
        if(val==stval)return 1;
    }
    return 0;
}

void getssa()
{
    getAllValue();//这里计算每一个块被赋值的变量有哪些,为placePhi做准备;

    //0.0 处理全局变量, 在每一个块中, 第一次出现全局变量的地方添加一个ldr指令
    for( auto gbval: allValue){
        if(gbval->var_scope=="1"&&gbval->getType()==1){
            for(auto b:IR1->Blocks){
                for(auto eb:b->domBlock){
                    for(auto it = eb->InstrList.begin();it!=eb->InstrList.end();it++){
                        Instruction *ins = IR1->InstList[(*it)];
                        int fl=hasUsedGlobal(ins,gbval);
                        if(fl){
                            //一条加载全局变量的语句
                            Instruction *insld = new Instruction(-1,Instruction::Load,1);
                            insld->setResult(gbval);
                            insld->addOperand(gbval);
                            //加入这条语句
                            IR1->InsertInstr(insld);
                            eb->InstrList.insert(it,IR1->InstList.size()-1);
                            break;
                        }
                    }
                }
            }
        }
        if(gbval->isPara>4){
            for(auto b:IR1->Blocks){
                for(auto eb:b->domBlock){
                    for(auto it = eb->InstrList.begin();it!=eb->InstrList.end();it++){
                        Instruction *ins = IR1->InstList[(*it)];
                        int fl=hasUsedGlobal(ins,gbval);
                        if(fl){
                            //一条加载形参的语句
                            Instruction *insld = new Instruction(-1,Instruction::Load,1);
                            insld->setResult(gbval);
                            insld->addOperand(gbval);
                            //加入这条语句
                            IR1->InsertInstr(insld);
                            eb->InstrList.insert(it,IR1->InstList.size()-1);
                            break;
                        }
                    }
                }
            }
        }
    } 

    //计算控制树
    //Lenguar-Tarjan 稍改...
    for(auto i: IR1->Blocks){
        if(i->domBlock.size())buildDomTree(i);
    }
    dbg("build tree win!");
    //计算df;
    for(auto i : IR1->Blocks){
        if(i->domBlock.size()){
            for(auto j : i->domBlock)calDF(j);
        }
    }
    dbg("cal df win!");

    for(auto i : IR1->Blocks){
        if(i->domBlock.size()){
            for(auto j : i->domBlock)setAssbyBlock(j);
        }
    }
    dbg("get all value win!");
    //抄它!  002_SSA比较清楚的说明_Lecture23.4up.pdf
    placePhi();
    dbg("place phi win!");

}
