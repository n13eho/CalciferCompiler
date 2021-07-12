//
// Created by Neho on 2021/7/11.
//

#ifndef CALCIFER_SSA_H
#define CALCIFER_SSA_H

#endif //CALCIFER_SSA_H


#include "ilist.h"
#include "util.h"
#include "Value.h"
#include <string>
#include <map>

#include "BuildIR.h" // for LinearIR
#include "BasicBlock.h" // for BasicBlock


struct Decl {
    bool is_array; // ?
    bool is_const; // 是否是常量
    bool is_glob; // 是否是全局变量
    std::string name;

    // their value, can be decided by is_array
    std::variant<int, std::vector<int>> value;

    // int array special
    std::vector<unsigned> dims; // store the dimension of array
};


struct IrFunc {
    DEFINE_ILIST(IrFunc) // 声明其前驱后继指针， 相当于对应IrProgram里的ir_func
//    Func *func; // 该函数体
//    ilist<BasicBlock> bbs; // （多个）bbs包含这个函数体内的多个基本块，像什么while, basic, return这些

    // mapping from decl to its value in this function
    std::map<Decl *, Value *> decls;
};

struct IrProgram {
    std::vector<Decl *> glob_decls; // （多个）全局声明declaration
    ilist<IrFunc> ir_funcs; // （多个）ir_funcs包含所有函数及其内容，从头到尾

    // 通过原来的Func找到现在它所对应的IrFunc
//    IrFunc *findFunc(Func *func);

    // 用于打印整个IrProgram，重载至ostream，最后输入到ir_file
    friend std::ostream& operator<<(std::ostream& os, const IrProgram& p);
};

std::ostream& operator<<(std::ostream& os, const IrProgram& p);


IrProgram *convert_ssa(LinearIR*, BasicBlock*);