#include"../include/liveSet.h"
#include"dbg.h"

/*
input: IR1 with phi
output: newIR
*/

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

map<BasicBlock*, vector<armInstr*>> newBlock;
map<armInstr*,Instruction*> trance;

void assignMov(Instruction* instr, BasicBlock* node)
{
    armMov *ins=new armMov();
    IntegerValue* rd=(IntegerValue*)instr->getResult();
    varDecl *rdd = new varDecl(rd,node,Rcnt++);
    ins->rd=rdd;
    newBlock[node].push_back(ins);
    trance[ins]=instr;
}

void assignAdd(Instruction* instr,BasicBlock *node)
{
    armAdd *ins=new armAdd();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    //这里只关心赋值.
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;
    //newblock多了一条指令
    newBlock[node].push_back(ins);
    trance[ins]=instr;
}

void assignPhi(Instruction* instr,BasicBlock*node)
{
    Value* val=instr->getOp()[0];    
    varDecl* rd = new varDecl(val, node, Rcnt++);
    for(auto pred : node->pioneerBlock){
        armMov* ins = new armMov();
        ins->rd=rd;
        auto pos = newBlock[pred].end();
        while((*(--pos))->getType()>=14&&(*(--pos))->getType()<=21);
        newBlock[pred].insert(++pos,ins);
        trance[ins]=instr;
    }
}

void assignLogic(Instruction* instr, BasicBlock* node, BasicBlock* nex)
{
    // 一个cmp指令
    armCmp* ins = new armCmp();
    newBlock[node].push_back(ins);
    trance[ins]=instr;

    // 只要zyh加了短路就可以不赋值了,直接生成跳转指令
    if(instr->getOpType()==Instruction::ArithNeq)
    {
        armBne * insb = new armBne();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithEq)
    {
        armBeq * insb = new armBeq();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithLQ)
    {
        armBle * insb = new armBle();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithLT)
    {
        armBlt * insb = new armBlt();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithBG)
    {
        armBgt * insb = new armBgt();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithGQ)
    {
        armBge * insb = new armBge();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
}

void assignjmp(Instruction* instr, BasicBlock* node)
{
    armB* ins = new armB();
    newBlock[node].push_back(ins);
    ins->lb = block2lb[instr->jmpDestBlock];
}

void assignCall(Instruction* instr, BasicBlock* node)
{
    // 高难度的函数跳转, 还没想好>_<
}

void assignLogicCond(Instruction *instr, BasicBlock* node)
{
    // 只要zyh加了短路就可以不写啦~~~
}

void assignIns(Instruction* ins,BasicBlock* node)
{//依照不同类型的指令，计算赋值,同时填newblock, 分支指令除外
    if(ins->getOpType() == Instruction::Add)
    {
        assignAdd(ins,node);
    }
    else if(ins->getOpType() == Instruction::Assign)
    {
        assignMov(ins,node);
    }
    else if(ins->getOpType() == Instruction::Jmp)
    {
        assignjmp(ins,node);
    }
}

void setDecl(BasicBlock *s)
{
    for(auto id=s->InstrList.begin();id!=s->InstrList.end();++id){
        int i = *id;
        auto ins =IR1->InstList[i];
        if(ins->getOpType() >= Instruction::ArithEq && ins->getOpType()<=Instruction::ArithGQ){
            auto insbT=IR1->InstList[i+1];
            assignLogic(ins,s,insbT->jmpDestBlock);
        }
        else assignIns(IR1->InstList[i],s);
    }
    DomTreenode* node=block2dom[s];
    for(auto son:node->son){
        setDecl(son->block);
    }    
}

map<BasicBlock*, set<Decl*>> reachin,reachout;
map<BasicBlock*, bool> visReach;
map< pair<Value*,BasicBlock*>, vector<Decl*> > Assign_rec;

void calReach(BasicBlock* s)
{
    visReach[s]=1;
    reachout[s]=reachin[s];
    for(auto ins:newBlock[s]){
        //减去这个语句定义的decl对应的val的decl
        Decl* dc=ins->rd;
        if(dc == nullptr)continue;
        Value* val=dc->rawValue;
        for(auto dead=reachout[s].begin();dead!=reachout[s].end();dead++){
            Decl* deadDc=*dead;
            if(deadDc->rawValue==val){
                dead=reachout[s].erase(dead);
                dead--;
            }
        }
        //加上这个语句定义的decl
        reachout[s].insert(dc);
    }
    for(auto suc:s->succBlock){
        for(auto i : reachout[s]){
            reachin[suc].insert(i);
        }
        if(!visReach[suc])calReach(suc);
    }
}

void addAssign(Value* val, BasicBlock* node, Decl* dc)
{
    auto key=make_pair(val,node);
    if(Assign_rec.count(key)){
        vector<Decl*> tem;
        Assign_rec[key]=tem;
    }
    Assign_rec[key].push_back(dc);
}

Decl* getDecl(IntegerValue* val, BasicBlock* node)
{
    if(val->isConst){
        //常数的话,直接新建一个返回
        constDecl* ret=new constDecl(val,node,val->RealValue);
        return ret;
    }
    else{
        //其他就返回上一次赋值
        return Assign_rec[make_pair(val,node)].back();
    }
}

void usedAdd(armAdd* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];

    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    if(r0->isConst)swap(r0,r1);
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);

}

void usedMov(armMov* ins, BasicBlock* node)
{
    Instruction* raw = trance[ins];
    dbg(raw->getOp().size());
    IntegerValue* rs ;
    if(raw->getOp().size())rs= (IntegerValue*)raw->getOp()[0];
    else rs= new IntegerValue("tt",-1,"",1);
    ins->rs = getDecl(rs,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}

void usedCmp(armCmp* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0=(IntegerValue*)raw->getOp()[0];
    IntegerValue* r1=(IntegerValue*)raw->getOp()[1];
    if(r0->isConst)swap(r0,r1);
    ins->r1 = getDecl(r1,node);
    ins->r0 = getDecl(r0,node);
}

void usedIns(armInstr* ins,BasicBlock* node)
{
    if(ins->getType()==armInstr::mov){
        usedMov((armMov*)ins,node);
    }
    else if(ins->getType() == armInstr::add){
        usedAdd((armAdd*)ins,node);
    }
    else if(ins->getType() == armInstr::cmp){
        usedCmp((armCmp*)ins,node);
    }
}

void setUsed(BasicBlock* s)
{
    //init:把reachin里的定义建立好
    for(auto dc : reachin[s]){
        addAssign(dc->rawValue,s,dc);
    } 
    //对于每一条语句填used
    for(auto ins : newBlock[s]){
        dbg(ins->getType());
        usedIns(ins,s);
    }
}

void showDecl(DomTreenode* sd)
{
    BasicBlock* s=sd->block;
    cout<<block2lb[s]<<endl;
    for(auto ins:newBlock[s]){
        cout<<*ins<<endl;
    }
    for(auto nx:sd->son){
        showDecl(nx);
    }
}

void liveSets()
{
    //0. 添加label
    for(auto b:IR1->Blocks){
        for(auto eb: b->domBlock){
            block2lb[eb]=lb+to_string(Bcnt++);
        }
    }
    dbg("add label win!");
    // 1. 转换Decl
    for(auto rt:DomRoot){
        setDecl(rt->block);
    }
    dbg("set Decl win!");
    //1.1 最后才能考虑phi
    for(auto b:phiPos){
        for(auto i:b->InstrList){
            if(IR1->InstList[i]->getOpType()==Instruction::Phi){
                assignPhi(IR1->InstList[i],b);
            }
        }
    }
    dbg("work phi win!");
    //2. 计算reachin和reachout,这里先迭代5次
    int MAXiter=5;
    while(MAXiter--){
        for(auto rt:DomRoot){
            set<Decl*> tem;
            reachin[rt->block]=tem;
            visReach.clear();
            calReach(rt->block);
        }
    }
    dbg("reach sets win!");
    //3. 填每条语句的used和计算<value,block>到decl的映射...(也不知道有什么用,先算出来吧...)
    for(auto gb:IR1->Blocks){
        for(auto blk : gb->domBlock){
            setUsed(blk);
        }
    }
    dbg("add used win!");
    //4. 输出用
    cout << "\n\n";
    for(auto rt:DomRoot){
        showDecl(rt);
    }
    dbg("show super arm win!");
}