#include "../include/CodeGeneration.h"
#include"register.h"
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

// 这里为什么会报链接错误？？-----neho
void transGlobal(BasicBlock* node)
{
    calout<<"\t\t.text\n";
    for(auto i: node->succBlock)
    {
        if(i->bType == BasicBlock::Basic)
        {
            transFuncBlock(i);

        }
    }   
}
void transIns(Instruction* ins)
{
    // if(ins->getOpType() == Instruction::Add)transAdd(ins);
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
    for(auto i : node->succBlock)
    {
        if(!blockid.count(i))transBlock(i);
    }
}

void transFuncBlock(BasicBlock* node)
{
    calout<<"\t\t.global "<<node->FuncV->VName<<"\n\t\t.type "<<node->FuncV->VName<<", \%function\n"<<node->FuncV->VName<<":\n";
    calout<<"\t.fnstart\n";
    calout<<s+to_string(cntlb)<<":\n";
    blockid[node]=s+to_string(cntlb++);
    for(auto i : node->InstrList)
    {
        Instruction* instr = IR1->InstList[i];
        transIns(instr);
    }
    calout<<node->succBlock.size()<<endl;
    for(auto i : node->succBlock)
    {
    calout<<"win"<<endl;
        // if(!blockid.count(i))transBlock(i);
    }
    calout<<"\t.fnend\n";
    for(auto i : node->domBlock)
    {
        // if(!blockid.count(i))transFuncBlock(i);
    }
}

void codegeneration()
{
    // 外部接口
    //1. 遍历符号表, 写全局信息..data段和.bss段;
    //2. transBlock, 写.text段
    calout.open("test.s",std::ifstream::out);
    calout<<"\t\t.data\n";
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
            calout<<":\t.word ";
            calout<<to_string(val->RealValue).data();
            calout<<endl;
        }
    }
    transGlobal(globalBlock);
    calout.close();
}