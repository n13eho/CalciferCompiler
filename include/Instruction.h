#pragma once
#include "BasicBlock.h"
#include "Value.h"
#include <iostream>


//四元式的具体指令
/*
 * return 类语句都没有result
 * Call 参数存放在操作数当中，返回值存放在value当中
 *
 * */
class Instruction
{
public:
    enum InsType{
        Add,// add
        Sub,
        Mul,
        Div,
        Mod,
        //单目运算符+
        UnaryPos,
        //单目运算符-
        UnaryNeg,
        //单目运算符！
        UnaryNot,
        //赋值
        Assign,
        //逻辑与
        LogicAnd,
        //逻辑或
        LogicOr,
        //算术等于
        ArithEq,
        //算术不等于，是否存在冗余？
        ArithNeq,
        //算术小于
        ArithLT,
        //算术大于
        ArithBG,
        //算术小于等于
        ArithLQ,
        //算术大于等于
        ArithGQ,
        //跳转
        Jmp,
        //条件跳转
        ConBr,
        //子过程/函数 调用
        Call,
        //return
        Ret,
        //访问数组
        Load,
        //存入数组
        Store,
        Break,
        //变量空间申请
        Alloc,
        Phi
    };

    Instruction(int id,Instruction::InsType ins_type,unsigned oprands_num):InstrId(id),OpType(ins_type),OpNums(oprands_num)
    {
//        std::cout<<"InsID:"<<id<<" type:"<<ins_type<<" Operator nums:"<<oprands_num<<std::endl;
    }
    void setId(int id){InstrId=id;}
    void addOperand(Value* opd){Operands.push_back(opd);}
    void setResult(Value* res){Result = res;}
    void setParent(BasicBlock* p){ParentBasicblock = p;}
    int getId(){return InstrId;}
    int getOpType(){return OpType;}
    std::vector<Value *> getOp(){return Operands;}
    Value* getResult(){return Result;}
    BasicBlock* getParent(){return ParentBasicblock;}
    
    BasicBlock* jmpDestBlock=nullptr;
private:
    //instruction id
    int InstrId;
    //（OP，arg1，arg2，result）
    //操作符 ins_type
    InsType OpType;
    //操作数列表
    std::vector<Value *> Operands;
    //结果
    Value* Result;
    //操作数个数
    unsigned OpNums;
    //本条指令属于的基本块
    BasicBlock* ParentBasicblock;
};



//指令是否需要细化成子类，还需确认
class AddIns:public Instruction{};

class SubIns:public Instruction{};

class MulIns:public Instruction{};

class DivIns:public Instruction{};

class ModIns:public Instruction{};

class UnaryIns:public Instruction
{
        // //单目运算符+
        // UnaryPos,
        // //单目运算符-
        // UnaryNeg,
        // //单目运算符！
        // UnaryNot,
};

class AssginIns:public Instruction{};

class LogicAndIns:public Instruction{};

class LogicAOrIns:public Instruction{};

class ArithEqIns:public Instruction{};

class ArithNeqIns:public Instruction{};

class ArithLTIns:public Instruction{};

class ArithBGIns:public Instruction{};

class ArithLQIns:public Instruction{};

class ArithGQIns:public Instruction{};

class JmpIns:public Instruction{};

class BranchIns:public Instruction{};

class CallIns:public Instruction{};

class RetIns:public Instruction{};

/*
add : +,-
mul : *,/,%
unary : +,-,!
call : Ident();
load : Ident,Ident[?]
store : const int x= 1;
arith_cmp:<,>,<=,>=,==,!=
logic_cmp:&&,||
jmp
其他跳转语句
ret
*/

