//
// Created by Neho on 2021/7/11.
//

#include "../include/ssa.h"
#include "../include/semanticAnalyze.h"
#include "../include/Instruction.h"


extern idTable_struct* SymbolTable; // 符号表
extern LinearIR* IR1; // 四元式指令


Decl* Ins2Decl(int id)
{// 没有初值的都当成0（暴民发言
    Instruction* presenIns = IR1->InstList[id];
}

IrProgram *convert_ssa(LinearIR* ir1, BasicBlock* bb)
{
    auto *ret_Irp = new IrProgram;
    /*
     * 先来处理全局变量
     * - 全局变量声明这里都在第一个block里面（整个结构都只有两个大的block，第一个是可能为空的全局变量块，第二个是）
     * - 因此先把第一个block里面的instruction翻进行处理，放入成员glob_decl中
     * - 不过另一个小问题：中途声明的全局变量如果没有初值的话，是不会出现在第一个block里面的，所以这里还得扫一遍符号表。
     * - 如果没有声明全局变量，那么第一个block中的InstrList这个vector的长度为0，因此第一个block可以放心处理
     * 1. 若第一个block部不为空：挨个访问这些指令，放到它的Decl中去
     * 2. 扫一遍符号表，作用域为1的也放进去
     * */
    if(bb != NULL)
    {
        for(auto glob_decl_ins: bb->InstrList)
        {
            Decl *d = Ins2Decl(glob_decl_ins);
            ret_Irp->glob_decls.push_back(d);
        }
    }




    return ret_Irp;
}


std::ostream &operator<<(std::ostream &os, const IrProgram &p)
{






    return os;
}