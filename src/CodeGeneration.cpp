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

int memshift;
map<Value*, int> loc2mem;//ldr r0 [sp,#-4]

Value* reg2val[13];//寄存器i中存了什么value
map<Value*, int> val2reg;//value_i的值目前存在哪个寄存器。
extern BasicBlock* globalBlock;

int lastusedRn=-1;

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
    
    
}

void stk2reg(Value* val)
{
    IntegerValue* intval=(IntegerValue*)val;
    if(intval->isConst==0)
    {
        calout<<"\tldr ";
    }
}

void integerfreeRn(int rn)
{
    Value* val=reg2val[rn];
    if(val==NULL)return ;
    reg2val[rn]=NULL;
    // val2reg[val]=-1;
    auto it =val2reg.find(val);
    val2reg.erase(it);
}

int integergetRn(Value* val)
{
    if(val2reg.count(val))return val2reg[val];
    for(int i=0;i<12;i++)
    {
        if(reg2val[i]==NULL)
        {
            reg2val[i]=val;
            val2reg[val]=i;
            if(val->getScope()=="1")
            {
                calout<<"\tldr "<<"r"<<to_string(i)<<", ="<<val->getName()<<endl;
                calout<<"\tldr r"<<to_string(i)<<", [r"+to_string(i)<<"]"<<endl;
            }
            // else if(val->get)
            else if(val->getScope().size())
            {
                int shift = loc2mem[val];
                calout<<"\tldr "<<"r"<<to_string(i)<<", [sp, #"<<shift<<"]"<<endl;
                calout<<"\tldr r"<<to_string(i)<<"[r"+to_string(i)<<"]"<<endl;
            }
            return i;
        }
    }
    return -1;
    //TODO: 启发式的把一个寄存器里存的值移入内存，记得更新reg2val,val2reg,loc2mem,memshift
}

void transAdd(Instruction* instr)
{//add rs r0 r1
//能不能保证 r0 和 r1 至少有一个不是立即数？  TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    if(r0->isConst==1)swap(r0,r1);
    int R_res = integergetRn(res); 
    lastusedRn=R_res;   
    int R_r0 = integergetRn(r0);  
    if(r1->isConst==1)
    {
        calout<<"\tadd r"+to_string(R_res)+", r"+to_string(R_r0)+", #"<<r1->RealValue<<endl;
    }
    else
    {
        int R_1 = integergetRn(r1);
        calout<<"\tadd r"+to_string(R_res)+", r"+to_string(R_r0)+", r"<<to_string(R_1)<<endl;
        integerfreeRn(R_1);
    }
    integerfreeRn(R_r0);

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
    if(node->FuncV->VName=="main")
    {
        calout<<"\tmov r0, r"+to_string(lastusedRn)<<endl;
    }
    calout<<"\tbx lr\n\t.fnend\n";
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