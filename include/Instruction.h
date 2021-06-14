#include "BasicBlock.h"
#include "Value.h"

//四元式的具体指令
class Instruction
{
    public:
    enum InsType{
        Add,
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
        ArithNe,
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
        //分支,不确定使用与否
        Branch,
        //子过程/函数 调用
        Call,
        //return
        Ret,
    };

    Instruction(int id,Instruction::InsType ins_type,unsigned oprands_num);
    void setId(int id){InstrId=id;}
    void addOperand(Value* opd){Operands.push_back(opd);}
    void setResult(Value* res){Result = res;}
    private:
    //instruction id
    int InstrId;
    //（OP，arg1，arg2，result）
    //操作符
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
class AddIns:Instruction{};

class SubIns:Instruction{};

class MulIns:Instruction{};

class DivIns:Instruction{};

class ModIns:Instruction{};

class UnaryIns:Instruction
{
        // //单目运算符+
        // UnaryPos,
        // //单目运算符-
        // UnaryNeg,
        // //单目运算符！
        // UnaryNot,
};

class AssginIns:Instruction{};

class LogicAndIns:Instruction{};

class LogicAOrIns:Instruction{};

class ArithEqIns:Instruction{};

class ArithNeIns:Instruction{};

class ArithLTIns:Instruction{};

class ArithBGIns:Instruction{};

class ArithLQIns:Instruction{};

class ArithGQIns:Instruction{};

class JmpIns:Instruction{};

class BranchIns:Instruction{};

class CallIns:Instruction{};

class RetIns:Instruction{};

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

