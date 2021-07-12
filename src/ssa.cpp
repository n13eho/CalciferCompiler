//
// Created by Neho on 2021/7/11.
//

#include "../include/ssa.h"
#include "../include/semanticAnalyze.h"
#include "../include/Instruction.h"
#include "../include/casting.h"
#include "../include/dbg.h"


extern idTable_struct* SymbolTable; // 符号表
extern LinearIR* IR1; // 四元式指令


Decl* Ins2Decl(int id)
{// 没有初值的都当成0（暴民发言；都有一个操作数；
    Instruction* presenIns = IR1->InstList[id];
    Decl *d = new Decl;
    d->name = presenIns->getResult()->VName;
//    cout << isa<IntegerValue>(presenIns->getResult())<<endl;
    d->is_array = isa<ArrayValue>(presenIns->getResult());
    d->is_glob = true;
    if(d->is_array)
    {
        d->dims = ((ArrayValue*)(presenIns->getResult()))->NumOfDimension;
        d->value = ((ArrayValue*)(presenIns->getResult()))->ArrayElement;
    }
    else
    {
        d->value = ((IntegerValue*)(presenIns->getResult()))->RealValue;
    }
    return d;
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
     * -- 若第一个block中的InstrList这个vector的长度为不为0：挨个访问这些指令，放到它的Decl中去
     * 2. 扫一遍符号表，作用域为1的也放进去
     * */
    //第一个block
    if(!bb->InstrList.empty())
    {
        for(auto glob_decl_ins: bb->InstrList)
        {
            Decl *d = Ins2Decl(glob_decl_ins);
            ret_Irp->glob_decls.push_back(d);
        }
    }
    dbg(ret_Irp->glob_decls.size());
    //抓没定义的全局变量，扫一遍
//    for (auto & iter : SymbolTable->table)
//    {
//        if(iter.second->var_scope.compare("1") == 0)
//        {//作用域是1 && 不是functionvalue
//            dbg(iter.second->VName);
//            dbg(&iter.second);
//
//        }
//    }



    return ret_Irp;
}


std::ostream &operator<<(std::ostream &os, const IrProgram &p)
{






    return os;
}