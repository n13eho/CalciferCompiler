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

// mul, div, mod 为了消除常数新增一条assign语句所需要用到的临时变量的value的名字
string mdm_name = "mdm";
int mdm_cnt = 0;

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
    vertex.push_back(dang);//第n个点的下标是n-1!!!!!!!!
    BasicBlock* db=dang->block;
    for( auto i : db->succBlock){
        //遍历所有后继
        if(!block2dom[i]){
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
    //计算eval可以看作"路径压缩的带权并查集".这里实现压缩部分
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
    //eval: 在并查集中到根路径中semi最小的点
    if(ancestor[v]==0)return v;//如果是根
    else{
        compress(v);//进行路径压缩
        return label[v];//返回label
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
            if(u==0){dbg(vb,vb->BlockName,"zhe ke neng?");}
            if(semi[u]<semi[w])semi[w]=semi[u];
        }
        auto t1 = semi[w];
        auto t2 = vertex[t1-1];
        bucket[t2].push_back(w);
        ancestor[w]=parent[w];
        // if(bucket.count(parent[w])==0)continue;
        if(bucket[parent[w]].size()==0)continue;
        for(auto i=bucket[parent[w]].begin();i<bucket[parent[w]].end();i++){
            auto v=*i;
            i=bucket[parent[w]].erase(i)-1;
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
        //不仅要计算idom还需要给idom的son中加入w;
        w->idom->son.push_back(w);
    }
    vertex[0]->idom=nullptr;
}

void buildDomTree(BasicBlock *s)
{
    //step1 求sdom

    //step1: 初始化semi/vertex/parent
    //首先遍历cfg得到dfs序
    //semi[w]:记录w的semidominaitor,,,(最小的能走回w的比w大的点)
    //vertex:这是一个vector, 里面按dfs序依次push, 下表从0开始
    //parent[w]:dfs生成树中w的父亲.
    tarjan_init();
    block2dom[s->domBlock[0]]=new DomTreenode();
    block2dom[s->domBlock[0]]->block=s->domBlock[0];
    DomTreenode* root=block2dom[s->domBlock[0]];
    root->func=s->FuncV;
    DomRoot.push_back(root);
    dfsLT(root);

    //step2\3: 主要是计算semi
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
                // set<BasicBlock*> tem;
                // if(ssaIR->DF.count(runner)==0)ssaIR->DF.insert(make_pair(runner,tem));
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
        else if(ins->getOpType()==Instruction::Load){
            addAssbyBlock(ins->getResult(),s);
        }
        else if(ins->getOpType()==Instruction::Call){
            addAssbyBlock(ins->getResult(),s);
        }
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
        if(gbval==NULL)continue;
        if(gbval->getType()==1&&gbval->getScope()=="1"){
            IntegerValue* tem =(IntegerValue*)gbval;
            if(tem->isConst)continue;
        }
        if(gbval->var_scope=="1"&&gbval->getType()<=2){
            for(auto b:IR1->Blocks){
                int iffind=0;
                for(auto eb:b->domBlock){
                    for(auto it = eb->InstrList.begin();it!=eb->InstrList.end();it++){
                        Instruction *ins = IR1->InstList[(*it)];
                        int fl=hasUsedGlobal(ins,gbval);
                        if(fl){
                            if(gbval->getType() != 2)
                            { // 如果不是全局数组，是全局变量，就需要ldr进来其值，相反如果是全局数组，则只需要一个首地址即可
                                //由于加载过来的全局变量是个地址，在mov一遍，就是说再加一个assign
                                Instruction *ins_addr2content= new Instruction(-1,Instruction::Assign,1);
                                ins_addr2content->setResult(gbval);
                                ins_addr2content->addOperand(gbval);
                                //加入这条语句
                                IR1->InsertInstr(ins_addr2content);
                                b->domBlock[0]->InstrList.push_front(IR1->InstList.size()-1);
                            }
                            //一条加载全局变量的语句
                            Instruction *insld = new Instruction(-1,Instruction::Load,1);
                            insld->setResult(gbval);
                            insld->addOperand(gbval);
                            //加入这条语句
                            IR1->InsertInstr(insld);
                            b->domBlock[0]->InstrList.push_front(IR1->InstList.size()-1);

                            iffind=1;
                            break;
                        }
                    }
                    if(iffind)break;
                }
            }
        }
    }

    //0.1 处理 mul,div,mod 使得他的源操作数没有常量. 有常量的话,就在这条四元式之前加入一条assign
     for(auto gb:IR1->Blocks){
         for(auto b:gb->domBlock){
             for(auto it = b->InstrList.begin(); it != b->InstrList.end(); it++)
             {
                 Instruction *ins_c = IR1->InstList[(*it)];
                 int antiType = ins_c->getOpType();
                 if(antiType == Instruction::Mul || antiType == Instruction::Div || antiType == Instruction::Mod)
                 {//找到这三种指令
                    for(int i=0; i < ins_c->Operands.size(); i++)
                    {// 对两个操作数都扫一遍
                        auto opVaule = ins_c->Operands[i];
                        if(opVaule->getType() == 1 && ((IntegerValue*)opVaule)->isConst == 1)
                        {// 是常数，则在前面加一条assign语句
                            //这条assign语句
                            Instruction* ins_ass = new Instruction(-1, Instruction::Assign, 1);
                            ins_ass->addOperand(opVaule); // 新指令的操作数应该是这个现成的const
                            IntegerValue* dummyVal = new IntegerValue(mdm_name + to_string(mdm_cnt++), opVaule->lineno, opVaule->var_scope, 0);
                            ins_ass->setResult(dummyVal); // 新指令的result应该是一个新的Value，有一个中间temp变量
                            // 还需要把当前的这个opValue换成新的dummyVal
                            ins_c->Operands[i] = dummyVal;
                            // 在它前面插入这条Instruction
                            IR1->InsertInstr(ins_ass);
                            b->InstrList.insert(it, IR1->InstList.size() - 1);
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
//    dbg("build tree win!");
    //计算df;
    for(auto i : IR1->Blocks){
        if(i->domBlock.size()){
            for(auto j : i->domBlock)calDF(j);
        }
    }
//    dbg("cal df win!");

    for(auto i : IR1->Blocks){
        if(i->domBlock.size()){
            // addAssbyBlock()
            for(auto param:i->FuncV->getParams()){
                addAssbyBlock(param,i->domBlock[0]);
            }
            for(auto j : i->domBlock){
                setAssbyBlock(j);
            }
        }
    }
//    dbg("get all value win!");
    //抄它!  002_SSA比较清楚的说明_Lecture23.4up.pdf
    placePhi();
    dbg("place phi win!");

}
