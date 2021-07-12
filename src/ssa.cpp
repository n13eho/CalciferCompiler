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
     * - 如果没有声明全局变量，那么第一个block中的InstrList这个vector的长度为0，因此第一个block可以放心处理
     * -- 若第一个block中的InstrList这个vector的长度为不为0：挨个访问这些指令，放到它的Decl中去
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




    return ret_Irp;
}

void arrayDim2llvmIr(std::ostream &os, const vector<unsigned>& dim, unsigned dep, int num)
{
    if(dep == dim.size())
    {//stop
        os << "i32";
        for(int i=0; i<num; i++)os<<"]";
        os << " ";
    }
    else
    {
        os << "[" << dim[dep] << " x ";
        arrayDim2llvmIr(os, dim, dep + 1, num);
    }
}

void arrayValue2llvmIr(std::ostream &os, const vector<unsigned>& dim, const vector<int>& value, unsigned dep, unsigned& vaIn)
{
    if(dep == dim.size())
    {// stop
        os << "i32 " << value[vaIn];
        vaIn++;
    }
    else
    {
        os << "[";
        for(int i=0; i<dim[dep]; i++)
        {
            if(dep != dim.size() - 1)arrayDim2llvmIr(os, dim, dep+1, dim.size() - dep - 1);
            arrayValue2llvmIr(os, dim, value, dep+1, vaIn);
            if(i < dim[dep] - 1) os << ", ";
        }
        os << "]";
    }
}

// 打印IR
std::ostream &operator<<(std::ostream &os, const IrProgram &p)
{


    //内置函数
    os << "declare i32 @getint()" << endl;
    os << "declare void @putint(i32)" << endl;

    //全局变量
    for(auto &d: p.glob_decls)
    {
        os << "@" << d->name << " = global ";
        if(d->is_array)
        {
            unsigned valueIndex = 0;
            //需要特殊处理一下来迎合llvm ir 的语法
            arrayDim2llvmIr(os, d->dims, 0, d->dims.size());
            arrayValue2llvmIr(os, d->dims, std::get<1>(d->value), 0, valueIndex);
        }
        else
        {
            os << "i32 "<< std::get<int>(d->value);
        }
        os << std::endl;
    }
    os << std::endl << std::endl;






    return os;
}