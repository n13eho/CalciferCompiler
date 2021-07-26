#pragma once
#include "Instruction.h"
#include "../include/sysy_node.hpp"
#include<bits/stdc++.h>
using namespace std;

//线性IR，存储所有四元式
class LinearIR
{
    public:
    LinearIR(){}

    void InsertInstr(Instruction* InsNew)
    {
        InstList.push_back(InsNew);
        InsNew->setId(InstCnt);
        InstCnt++;
    }

    void AddBlock(BasicBlock* bloc){Blocks.push_back(bloc);}

    BasicBlock* getLastBlock(){return Blocks.back();}

    int getInstCnt(){return InstCnt;}

    Instruction* getIns(int index){return InstList[index];}

    std::vector<Instruction*> InstList;
    int InstCnt=0;
    //记录所有的顶层的block
    std::vector<BasicBlock*> Blocks;
    //将函数的value与对应的basicblock对应
    map<Value*,BasicBlock*> FuncMap;
};

void VisitAST(GrammaNode* DRoot,LinearIR *IR);

void ConstDefNode(GrammaNode* node,LinearIR *IR);
void VarDefNode(GrammaNode* node,LinearIR *IR);
void FuncDefNode(GrammaNode* node,LinearIR *IR);
void BlockNode(GrammaNode* node,LinearIR *IR);
void StmtNode(GrammaNode* node,LinearIR *IR);
void AssignNode(GrammaNode* node,LinearIR *IR);
void IfNode(GrammaNode* node,LinearIR *IR);
void IfElseNode(GrammaNode* node,LinearIR *IR);
void WhileNode(GrammaNode* node,LinearIR *IR);
void ReturnNode(GrammaNode* node,LinearIR *IR);
void BreakNode(GrammaNode* node,LinearIR *IR);
void ContinueNode(GrammaNode* node,LinearIR *IR);
void ReturnValueNode(GrammaNode* node,LinearIR *IR);
void CondNode(GrammaNode* node,LinearIR *IR);
Value* InitValNode(GrammaNode* node,LinearIR *IR);
Value* AddExpNode(GrammaNode* node,LinearIR *IR);
Value* UnaryExpNode(GrammaNode* node,LinearIR *IR);
Value* MulExpNode(GrammaNode* node,LinearIR *IR);
Value* PrimaryExpNode(GrammaNode* node,LinearIR *IR);
Value* LValArrayNode(GrammaNode* node,LinearIR *IR);

void CondNode(GrammaNode* node,LinearIR *IR);
void LOrExpNode(GrammaNode* node,LinearIR *IR);
Value* LAndExpNode(GrammaNode* node,LinearIR *IR);
Value* EqExpNode(GrammaNode* node,LinearIR *IR);
Value* RelExpNode(GrammaNode* node,LinearIR *IR);

BasicBlock* GetPresentBlock(BasicBlock* funcP,BasicBlock::BlockType t);

BasicBlock* CreateBlock(BasicBlock::BlockType t);

bool linkNext(BasicBlock* node,LinearIR *IR);
void AllocCreate(GrammaNode* node,LinearIR *IR,Value* VL,int space_size);
void CreateIns(GrammaNode* node,LinearIR *IR,Instruction::InsType ins_type,unsigned oprands_num,std::vector<Value*>op,Value* res);

//error
class BuildIRError : public std::exception {
public:
	BuildIRError(int ln, std::string& name, const std::string& msg)
    {  
        msg_ ="\n\033[31m[BuildIRError]\033[0m line " + std::to_string(ln) + ": " + name + " " + msg;
    }
	const char* what() const throw() override { return msg_.c_str(); }
private:
	std::string msg_;
};

// 打印当前IR中的所有指令
void show_IR_ins(LinearIR *IR);
void fixIfNext(LinearIR *IR,BasicBlock* node,int dep);
extern LinearIR *IR1;