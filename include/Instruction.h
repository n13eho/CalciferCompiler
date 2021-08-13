#pragma once
#include "BasicBlock.h"
#include "Value.h"
#include <iostream>
#include <string>
#include <map>

extern std::map<int, std::string> DEBUG_insOP;

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
        Result = nullptr;
        AddressHead = 0;
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

    void setJmpDestBlock(BasicBlock* t)
    {
        this->jmpDestBlock = t;
        if(this->ParentBasicblock != nullptr)
        {
            this->getParent()->Link(t);
        }
        else
        {
            std::cout<<"link error"<<std::endl;
        }
    }
    
    BasicBlock* jmpDestBlock=nullptr;

    //操作数列表  neho于7.27将它从private中移了出来，由于需要改动原来的op
    std::vector<Value *> Operands;

    void setAddressHead(int v){this->AddressHead = 1;}

    int getAddressHead(){return this->AddressHead;}

    friend void operator <<(std::ostream& os, Instruction * presenIns)
    {
        // 当前指令
        os << presenIns->getId() << "\t";
        os << DEBUG_insOP[presenIns->getOpType()] << "\t";

        if(presenIns->getOpType() == Instruction::Jmp|| presenIns->getOpType() == Instruction::ConBr)
        {
            if(nullptr != presenIns->jmpDestBlock)
            {
                os << presenIns->jmpDestBlock->BlockName<< presenIns->jmpDestBlock->getFirstIns();
            }
        } else if(presenIns->getOpType() == Instruction::Alloc)
        {
            os << presenIns->getOp()[0]->VName<<" space size:"<<((IntegerValue*)(presenIns->getOp()[1]))->getValue();
        } else if(presenIns->getOpType() == Instruction::Store)
        {
            os << presenIns->getOp()[0]->VName<<" ["<<((IntegerValue*)presenIns->getOp()[1])->getValue()<<"]: "<<(presenIns->getOp()[2])->getName();
        } else {

            for(Value * opValue : presenIns->getOp())
            {
                int type = opValue->getType();

                if(type == VType::VImm) {
                    ImmValue * imm = (ImmValue *)opValue;
                    os << imm->getValue() <<  "\t";
                } if(type == VType::VInteger) {
                    IntegerValue * intValue = (IntegerValue *)opValue;
                    if(intValue->isConst) {
                        os << intValue->getValue() <<  "\t";
                    } else {
                        os << opValue->VName << "\t";
                    }
                }
                else {
                    os << opValue->VName << "\t";
                }

            }

            if(presenIns->getOp().size() == 1) os << "\t";

            if(presenIns->getOpType() != Instruction::InsType::Ret) {
                if(presenIns->getResult()!=nullptr) {
                    os << presenIns->getResult()->VName;
                }
            }
        }

        os << std::endl;
    }


private:
    //instruction id
    int InstrId = -2;
    //（OP，arg1，arg2，result）
    //操作符 ins_type
    InsType OpType = InsType::Break;
    //结果
    Value* Result = nullptr;
    //操作数个数
    unsigned OpNums = 0;
    //本条指令属于的基本块
    BasicBlock* ParentBasicblock = nullptr;
    //用于判断加法指令中操作数是否是数组首地址
    int AddressHead = 0;
};