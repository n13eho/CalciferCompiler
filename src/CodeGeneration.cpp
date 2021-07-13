#include "../include/CodeGeneration.h"
#include"register.h"
#include"BuildIR.h"
#include"semanticAnalyze.h"

using namespace std;

ofstream calout;
extern LinearIR* IR1;
// string s="func";
// int cntfunc=0;
string s = "lb";
int cntlb=0;
map<Value*,bool> visval;
map<BasicBlock*,string> blockid;    //防止重复输出
extern BasicBlock* globalBlock;

void transGlobal(BasicBlock* node);
void transFuncBlock(BasicBlock* node);
//翻译每个四元式
void transAdd(Instruction* instr);
void transSub(Instruction* instr);
void transMul(Instruction* instr);
void transDiv(Instruction* instr);
void transMod(Instruction* instr);
void transUnaryPos(Instruction* instr);
void transUnaryNeg(Instruction* instr);
void transUnaryNot(Instruction* instr);
void transAssign(Instruction* instr);
void transLogicAnd(Instruction* instr);
void transLogicOr(Instruction* instr);
void transLogicEq(Instruction* instr);
void transLogicNeq(Instruction* instr);
void transLogicLT(Instruction* instr);
void transLogicBG(Instruction* instr);
void transLogicLQ(Instruction* instr);
void transLogicGQ(Instruction* instr);
void transLogicJmp(Instruction* instr);
void transConBr(Instruction* instr);
void transCall(Instruction* instr);
void transRet(Instruction* instr);
void transLoad(Instruction* instr);
void transStore(Instruction* instr);
void transBreak(Instruction* instr);

void transAssign(Instruction* instr)
{
    calout<<"\tmov ";
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    
}

void stk2reg(Value* val)
{
    IntegerValue* intval=(IntegerValue*)val;
    if(intval->isConst==0)
    {
        calout<<"\tldr ";
    }
}

void transAdd(Instruction* instr)
{//add rs r0 r1
//能不能保证 r0 和 r1 至少有一个不是立即数？  TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    
}


void transGlobal(BasicBlock* node)
{
    calout<<"\t.text\n";
    int f=0;
    for(auto func : IR1->Blocks)
    {
        if(f==0){f=1;continue;}
        transFuncBlock(func);
    }
}
void transIns(Instruction* ins)
{
    if(ins->getOpType() == Instruction::Add)transAdd(ins);
    // else if(ins->getOpType() == Instruction::Sub)transSub(ins);
    // else if(ins->getOpType() == Instruction::LogicAnd)transLogicAnd(ins);
}
void transBlock(BasicBlock* node)
{
    //我想把每一个block都加一个标签，这样简单不过可能有些冗余
    calout<<s+to_string(cntlb)<<":\n";
    blockid[node]=s+to_string(cntlb++);
    for(auto i: node->InstrList)
    {
        Instruction* instr = IR1->InstList[i];
        transIns(instr);
    }
}

void transFuncBlock(BasicBlock* node)
{
    calout<<"\t.global "<<node->FuncV->VName<<"\n\t.type "<<node->FuncV->VName<<", \%function\n"<<node->FuncV->VName<<":\n";
    calout<<"\t.fnstart\n";
    for(auto i : node->domBlock)
    {
        if(!blockid.count(i))transBlock(i);
    }
    calout<<"bx lr\n\t.fnend\n";
}

void codegeneration()
{
    // 外部接口
    //1. 遍历符号表, 写全局信息..data段和.bss段;
    //2. transBlock, 写.text段
    calout.open("test.s",std::ifstream::out);
    calout<<"\t.data\n";
    for(auto fuhao : SymbolTable->table)
    {
        //这里写.data
        if(visval[fuhao.second]==1)continue;
        if(fuhao.second->getType()==1)
        {
            visval[fuhao.second]=1;
            IntegerValue* val=(IntegerValue*)fuhao.second;
            if(val->var_scope!="1"||val->isConst==1)continue;
            calout<<val->VName.data();
            calout<<":\n\t.word ";
            calout<<to_string(val->RealValue).data();
            calout<<endl;
        }
    }
    transGlobal(globalBlock);
    calout.close();
}