#include<bits/stdc++.h>
#include"decl.h"
#include"ssa.h"

map<BasicBlock*, string> block2lb;
int Bcnt;
string lb=".LB";
int Rcnt;
///////////////
ostream& operator<<(ostream&out,const armInstr& a){
    return a.output(out);
}
ostream& operator<<(ostream&out,const Decl& a){
    return a.output(out);
}
///////////////
void addAssign(Value* val, BasicBlock* node, Decl* dc)
{
    auto key=make_pair(val,node);
    if(ssaIR->Assign_rec.count(key)){
        vector<Decl*> tem;
        ssaIR->Assign_rec[key]=tem;
    }
    ssaIR->Assign_rec[key].push_back(dc);
}

Decl* getDecl(Value* val, BasicBlock* node)
{
    //获得这个变量到达这里的定义
    auto key = make_pair(val,node);
    if(!ssaIR->Assign_rec.count(key)){
        //由于已经计算过phi,因此,前驱中如果有多个对val不同的decl,一定会转换成一个
        for(auto pred: node->pioneerBlock){
            getDecl(val,pred);
        }
    }
    else{
        return ssaIR->Assign_rec[key].back();
    }
}

void assignMov(Instruction* instr, BasicBlock* node)
{
    armMov *ins=new armMov();
    IntegerValue* rd=(IntegerValue*)instr->getResult();
    IntegerValue* rs = (IntegerValue*)instr->getOp()[0];

    varDecl *rdd = new varDecl(rd,node,(armInstr*)ins,Rcnt++);
    ins->rd=rdd;
    addAssign(rd,node,rdd);

    if(rs->isConst ==1){
        constDecl *rsd = new constDecl((Value*)rs,node,(armInstr*)ins,rs->RealValue);
        ins->rs = rsd;
    }
    else {
        varDecl *rsd = (varDecl*)ssaIR->Assign_rec[make_pair(rs,node)].back();
        rsd->usesd.push_back((armInstr*)ins);
        ins->rs=rsd;
    }
    cout<<*(armInstr*)ins<<endl;
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
    ins->rd = resd;

    addAssign(res,node,resd);
    //第一个操作数转换为赋值
    varDecl *r0d = (varDecl *)ssaIR->Assign_rec[make_pair(r0,node)].back();
    r0d->usesd.push_back(ins);//这个decl用了一次
    ins->r0 = r0d;
    if (r1->isConst)
    {//如果是常量,也搞成一个赋值,不过没什么意义
        constDecl *r1d = new constDecl((Value*)r1,node,(armInstr*)ins,r1->RealValue);
        ins->r1 = r1d;
    }
    else
    {//第二个操作数转换为赋值
        varDecl *r1d = (varDecl *)ssaIR->Assign_rec[make_pair(r1,node)].back();
        r1d->usesd.push_back(ins);//这个decl用了一次
        ins->r1 = r1d;
    }
    cout<<*(armInstr*)ins<<endl;
}

void assignPhi(Instruction* instr,BasicBlock*node)
{
    Value* val=instr->getOp()[0];
    
    varDecl* rd = new varDecl(val, node, nullptr, Rcnt++);
    addAssign(val, node, rd);

    for(auto pred : node->pioneerBlock){
        Decl* rs = ssaIR->Assign_rec[make_pair(val,pred)].back();
        
        armMov* ins = new armMov();
        ins->rd=rd;
        ins->rs=rs;

        addAssign(val,pred,rd);
    }
}

void assignLogic(Instruction* instr, BasicBlock* node)
{
    // 一个cmp指令
    armCmp* ins = new armCmp();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];

    if(r0->isConst == 1)swap(r0, r1);
    Decl* r0d = ssaIR->Assign_rec[make_pair(r0,node)].back();

    // 一个条件赋值(这里直接用一个decl)

}

void assignBr(Instruction* instr, BasicBlock* node)
{
    
}

void assignLogicCond(Instruction *instr, BasicBlock* node)
{
    // 只要zyh加了短路我就可以不写啦~~~
}

void assignIns(Instruction* ins,BasicBlock* node)
{//依照不同类型的指令，进行转换IR
    if(ins->getOpType() == Instruction::Add)
    {
        assignAdd(ins,node);
    }
    else if(ins->getOpType() == Instruction::Assign)
    {
        assignMov(ins,node);
    }
    else if(ins->getOpType() == Instruction::Phi)
    {
        assignPhi(ins,node);
    }
    
}

void setDecl(BasicBlock *s)
{
    for(auto i: s->InstrList)assignIns(IR1->InstList[i],s);
    DomTreenode* node=block2dom[s];
    for(auto son:node->son){
        setDecl(son->block);
    }    
}

void liveSets()
{
    //
    for(auto rt:DomRoot){
        setDecl(rt->block);
    }

}