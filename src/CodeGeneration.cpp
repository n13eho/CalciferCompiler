#include "../include/CodeGeneration.h"
#include"register.h"
#include"BuildIR.h"
#include"semanticAnalyze.h"
#include"dbg.h"

using namespace std;

ofstream calout;
extern LinearIR* IR1;
// string s="func";
// int cntfunc=0;
string s = ".lb";
int cntlb=0;
map<Value*,bool> visval;
map<BasicBlock*,string> blockid;    //防止重复输出

int memshift;
map<Value*, int> loc2mem;//ldr r0 [sp,#-4]

Value* reg2val[13];//寄存器i中存了什么value
map<Value*, int> val2reg;//value_i的值目前存在哪个寄存器。
extern BasicBlock* globalBlock;

int lastusedRn=-1;
int lastLogicUsedRn=-1;

void transGlobal();
void transFuncBlock(BasicBlock* node);
//翻译每个四元式
void transAdd(Instruction* instr);//√
void transSub(Instruction* instr);
void transMul(Instruction* instr);
void transDiv(Instruction* instr);
void transMod(Instruction* instr);
void transUnaryNeg(Instruction* instr);
void transUnaryNot(Instruction* instr);
void transAssign(Instruction* instr);
void transLogicAnd(Instruction* instr);
void transLogicOr(Instruction* instr);
void transLogic(Instruction* instr);
void transJmp(Instruction* instr);
void transConBr(Instruction* instr);
void transCall(Instruction* instr);
void transRet(Instruction* instr);
void transLoad(Instruction* instr);
void transStore(Instruction* instr);

void transAlloc(Instruction* instr);
void integerfreeRn(int rn);
int integergetRn(Value* val,int needAddr=0);


void transAlloc(Instruction* instr)
{
    Value* r0=instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    loc2mem[r0]=memshift;
    memshift+=r1->RealValue;
}

void transAssign(Instruction* instr)
{
    IntegerValue* res=(IntegerValue* )instr->getResult();
    IntegerValue* r0 = (IntegerValue* )instr->getOp()[0];
    //获取左值
    int R_res=integergetRn(res);
    lastusedRn=R_res;
    if(r0->isConst==1)
    {
        calout<<"\tmov r"+to_string(R_res)<<", #"<<r0->RealValue<<endl;
    }
    else
    {
        int R_0 = integergetRn(r0);
        calout<<"\tmov r"+to_string(R_res)<<", r"<<to_string(R_0)<<endl;
        integerfreeRn(R_0);
    }
}


void integerfreeRn(int rn)
{
    Value* val=reg2val[rn];
    if(val==NULL)return ;
    //把寄存器中在内存有映射的值存回去.
    if(val->getScope()=="1")
    {
        int glb=integergetRn(val,1);
        calout<<"\tstr r"+to_string(rn)<<", [r"<<to_string(glb)<<", #0]"<<endl;
        //free掉free产生的额外寄存器
        reg2val[glb]=NULL;
    }
    else if(loc2mem.count(val))
    {
        calout<<"\tstr r"+to_string(rn)<<", [sp, #-"<<loc2mem[val] * 4<<"]"<<endl;
    }
    reg2val[rn]=NULL;
    auto it =val2reg.find(val);
    val2reg.erase(it);
}

int integergetRn(Value* val,int needAddr)
{
    if(needAddr==0&&val2reg.count(val))return val2reg[val];
    for(int i=0;i<12;i++)
    {
        if(reg2val[i]==NULL)
        {
            reg2val[i]=val;
            val2reg[val]=i;
            //加载内存中的值
            if(val->getScope()=="1")
            {
                calout<<"\tldr "<<"r"<<to_string(i)<<", ="<<val->getName()<<endl;
                if(!needAddr)calout<<"\tldr r"<<to_string(i)<<", [r"+to_string(i)<<"]"<<endl;
            }
            else if(loc2mem.count(val))
            {
                int shift = loc2mem[val];
                calout<<"\tldr "<<"r"<<to_string(i)<<", [sp, #-"<<shift*4<<"]"<<endl;
                // if(!needAddr)calout<<"\tldr r"<<to_string(i)<<", [r"+to_string(i)<<"]"<<endl;
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

void transSub(Instruction* instr)
{// sub res, r0, r1 or rsb r0, #imm
    // load value of res, r0, r1
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    // if r0 is an imm
    int R_res = integergetRn(res);
    if(r0->isConst == 1)
    {
        swap(r0, r1);
        int R_r0 = integergetRn(r0);
        // res = r0 - r1 --> rsb r1, #imm(r0)
        calout << "\trsb r" << R_res << ", r" << R_r0 << ", #" << r1->RealValue <<endl;
        integerfreeRn(R_r0);
    }
    else
    {// noraml sub
        int R_r0 = integergetRn(r0);
        int R_r1 = integergetRn(r1);
        // normal
        calout << "\tsub r" << R_res << ", r" << R_r0 << ", r" << R_r1 << endl;
        integerfreeRn(R_r0);
        integerfreeRn(R_r1);
    }
    integerfreeRn(R_res);
}

void transMul(Instruction* instr)
{
    // load value of res, r0, r1
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    // register numbers are needed anyway
    int R_res = integergetRn(res);
    int R_r0 = integergetRn(r0);
    int R_r1 = integergetRn(r1);
    // if any of r0 and r1 is CONST, mov it into their register
    if(r0->isConst == 1)
    {
        calout << "\tmov r" << R_r0 << ", #" << r0->RealValue<<endl;
    }
    if(r1->isConst == 1)
    {
        calout << "\tmov r" << R_r1 << ", #" << r1->RealValue<<endl;
    }

    // the final mul
    calout << "\tsmul r" << R_res << ", r" << R_r0 << ", r" << R_r1 << endl;
    // free
    integerfreeRn(R_res);
    integerfreeRn(R_r0);
    integerfreeRn(R_r1);
}

void transDiv(Instruction* instr)
{
    // load value of res, r0, r1
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    // register numbers are needed anyway
    int R_res = integergetRn(res);
    int R_r0 = integergetRn(r0);
    int R_r1 = integergetRn(r1);
    // if any of r0 and r1 is CONST, mov it into their register
    if(r0->isConst == 1)
    {
        calout << "\tmov r" << R_r0 << ", #" << r0->RealValue<<endl;
    }
    if(r1->isConst == 1)
    {
        calout << "\tmov r" << R_r1 << ", #" << r1->RealValue<<endl;
    }

    // the final sub
    calout << "\tsdiv r" << R_res << ", r" << R_r0 << ", r" << R_r1 << endl;

    // free
    integerfreeRn(R_res);
    integerfreeRn(R_r0);
    integerfreeRn(R_r1);

}

void transUnaryNeg(Instruction* instr)
{
    // get res and r0, ro is not a CONST
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    // ask integer number
    int R_res = integergetRn(res);
    int R_r0 = integergetRn(r0);
    // use rsb
    calout << "\trsb r" << R_res << ", r" << R_r0 << ", #0";
    // free Rnum
    integerfreeRn(R_res);
    integerfreeRn(R_r0);
}

void transGlobal()
{
    calout<<"\t.text\n";
    int f=0; // 跳过第一个全局的block，它已经被翻译过了
    for(auto func : IR1->Blocks)
    {
        if(f==0){f=1;continue;}
        transFuncBlock(func); // 依次翻译顶层bb（fcuntion）
    }
}

void transLogicOr(Instruction* instr)
{
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    if(r0->isConst == 1)swap(r0, r1);
    int R_r0 = integergetRn(r0);
    int R_res = integergetRn(res);
    if(r1->isConst==1)
    {
        calout<<"\torr r"+to_string(R_res)+", r"+to_string(R_r0)+", #"<<r1->RealValue<<endl;
    }
    else
    {
        int R_1 = integergetRn(r1);
        calout<<"\torr r"+to_string(R_res)+", r"+to_string(R_r0)+", r"<<to_string(R_1)<<endl;
        integerfreeRn(R_1);
    }
    integerfreeRn(R_r0);
    calout<<"\tcmp r"<<R_res<<", #0"<<endl;
    calout<<"\tmoveq r"<<R_res<<", #0" << endl;
    calout<<"\tmovne r"<<R_res<<", #1" << endl;
    lastLogicUsedRn = R_res;
}

void transLogicAnd(Instruction* instr)
{
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    if(r0->isConst == 1)swap(r0, r1);
    int R_r0 = integergetRn(r0);
    int R_res = integergetRn(res);
    if(r1->isConst==1)
    {
        calout<<"\tand r"+to_string(R_res)+", r"+to_string(R_r0)+", #"<<r1->RealValue<<endl;
    }
    else
    {
        int R_1 = integergetRn(r1);
        calout<<"\tand r"+to_string(R_res)+", r"+to_string(R_r0)+", r"<<to_string(R_1)<<endl;
        integerfreeRn(R_1);
    }
    integerfreeRn(R_r0);
    calout<<"\tcmp r"<<R_res<<", #0"<<endl;
    calout<<"\tmoveq r"<<R_res<<", #0" << endl;
    calout<<"\tmovne r"<<R_res<<", #1" << endl;
    lastLogicUsedRn = R_res;
}

void transLogic(Instruction* instr)
{
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    IntegerValue* r1=(IntegerValue*)instr->getOp()[1];
    if(r0->isConst == 1)swap(r0, r1);
    int R_r0 = integergetRn(r0);
    int R_res = integergetRn(res);
    if(r1->isConst == 1)
    {
        calout<<"\tcmp r"<<R_r0<<", #"<<r1->RealValue << endl;
    }
    else
    {
        int R_r1 = integergetRn(r1);
        calout<<"\tcmp r"<<R_r0<<", r"<<R_r1 << endl;
        integerfreeRn(R_r1);
    }
    integerfreeRn(R_r0);
    if(instr->getOpType()==Instruction::ArithNeq)
    {
        calout<<"\tmovne r"<<R_res<<", #1" << endl;
        calout<<"\tmoveq r"<<R_res<<", #0" << endl;
    }
    else if(instr->getOpType()==Instruction::ArithEq)
    {
        calout<<"\tmoveq r"<<R_res<<", #1" << endl;
        calout<<"\tmovne r"<<R_res<<", #0" << endl;
    }
    else if(instr->getOpType()==Instruction::ArithLQ)
    {
        calout<<"\tmovle r"<<R_res<<", #1" << endl;
        calout<<"\tmovgt r"<<R_res<<", #0" << endl;
    }
    else if(instr->getOpType()==Instruction::ArithLT)
    {
        calout<<"\tmovlt r"<<R_res<<", #1" << endl;
        calout<<"\tmovge r"<<R_res<<", #0" << endl;
    }
    else if(instr->getOpType()==Instruction::ArithBG)
    {
        calout<<"\tmovbt r"<<R_res<<", #1" << endl;
        calout<<"\tmovle r"<<R_res<<", #0" << endl;
    }
    else if(instr->getOpType()==Instruction::ArithGQ)
    {
        calout<<"\tmovge r"<<R_res<<", #1" << endl;
        calout<<"\tmovlt r"<<R_res<<", #0" << endl;
    }
    lastLogicUsedRn = R_res;
}


void transConBr(Instruction* instr)
{
    BasicBlock* bbjump = instr->jmpDestBlock;

    calout<<"\tcmp r"<<lastLogicUsedRn<<", #1" << endl;
    calout<<"\tbeq " << blockid[bbjump] << endl;
}

void transJmp(Instruction* instr)
{
    BasicBlock* bbjump = instr->jmpDestBlock;
    calout << "\tb "<< blockid[bbjump] << endl;
}

void transIns(Instruction* ins)
{//依照不同类型的指令，进行翻译
    if(ins->getOpType() == Instruction::Add)
    {
        calout<<"@add " << ins->getId() << endl;
        transAdd(ins);
    }
    else if(ins->getOpType() == Instruction::Sub)
    {
        calout<<"@sub " << ins->getId() << endl;
        transSub(ins);
    }
    else if(ins->getOpType() == Instruction::Mul)
    {
        calout<<"@mul " << ins->getId() << endl;
        transMul(ins);
    }
    else if(ins->getOpType() == Instruction::Div)
    {
        calout<<"@div " << ins->getId() << endl;
        transDiv(ins);
    }
    else if(ins->getOpType() == Instruction::UnaryNeg)
    {
        calout<<"@neg " << ins->getId() << endl;
        transUnaryNeg(ins);
    }
    else if(ins->getOpType() == Instruction::Assign)
    {
        calout<<"@ass " << ins->getId() << endl;
        transAssign(ins);
    }
    else if(ins->getOpType() == Instruction::Alloc)
    {
        calout<<"@alloc " << ins->getId() << endl;
        transAlloc(ins);
    }
    else if(ins->getOpType() >= Instruction::ArithEq && ins->getOpType()<=Instruction::ArithGQ)
    {
        calout<<"@logic " << ins->getId() << endl;
        transLogic(ins);
    }
    else if(ins->getOpType() == Instruction::LogicAnd)
    {
        calout<<"@and " << ins->getId() << endl;
        transLogicAnd(ins);
    }
    else if(ins->getOpType() == Instruction::LogicOr)
    {
        calout<<"@or " << ins->getId() << endl;
        transLogicOr(ins);
    }
    else if(ins->getOpType() == Instruction::ConBr)
    {
        calout<<"@br " << ins->getId() << endl;
        transConBr(ins);
    }
    else if(ins->getOpType() == Instruction::Jmp)
    {
        calout<<"@jmp " << ins->getId() << endl;
        transJmp(ins);
    }
}
void transBlock(BasicBlock* node)
{
    // 1.先输出这个block的编号
    calout<<blockid[node]<<":\n";
    for(auto i: node->InstrList)
    {// 2.逐条访问block中的每条指令进行翻译
        Instruction* instr = IR1->InstList[i];
        transIns(instr);
    }
}

void transFuncBlock(BasicBlock* node)
{
    calout<<"\t.global "<<node->FuncV->VName<<"\n\t.type "<<node->FuncV->VName<<", \%function\n"<<node->FuncV->VName<<":\n";
    calout<<"\t.fnstart\n";
    memshift=0; // 在每个函数的开头，将memshift置为0
    for(auto i: node->domBlock)
    { // 1.先对它控制的每个block进行编号，建立起来映射
        blockid[i]=s+to_string(cntlb++);
    }
    for(auto i : node->domBlock)
    { // 2.再翻译每一个函数体
        transBlock(i);
    }
    if(node->FuncV->VName=="main")
    { // 如果是main，这个在main函数结尾固定输出（没有翻译return，暂且这样处理）
        calout<<"\tmov r0, r"+to_string(lastusedRn)<<endl;
    }
    calout<<"\tbx lr\n\t.fnend\n";
}

void codegeneration()
{
    // 外部接口
    //1. 遍历符号表, 写全局信息.data段;
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
    // 依次便利IR中的顶层BB
    transGlobal();
    calout.close();
}