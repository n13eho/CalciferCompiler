#include "../include/CodeGeneration.h"

using namespace std;

extern FILE* yyout; // why?
extern LinearIR* IR1;
string s="func";
int cntfunc=0;

// 这里为什么会报链接错误？？-----neho
// void transGlobal(BasicBlock* node)
// {
//     for(auto i: node->succBlock)
//     {
//         if(i->bType == BasicBlock::Basic)
//         {
//             transBlock(i);
//         }
//     }   
// }

void transFuncBlock(BasicBlock* node)
{
    //写入基本信息
    for(auto i : node->InstrList)
    {
        Instruction* instr = IR1->InstList[i];
        // 这里分类讨论
    }
    for(auto i : node->succBlock)
    {
        //还没想好
    }
}

void codegeneration()
{
    // 外部接口
    //1. 遍历符号表, 写全局信息..data段和.bss段;
    //2. transBlock, 写.text段
}