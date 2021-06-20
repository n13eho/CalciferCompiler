#include "Instruction.h"
#include "sysy_node.hpp"

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

    int getInstCnt(){return InstCnt;}
    Instruction* getIns(int index){return InstList[index];}
    std::vector<Instruction*> InstList;
    int InstCnt=0;
};

void VisitAST(GrammaNode* DRoot,LinearIR *IR);

void ConstDefNode(GrammaNode* node,LinearIR *IR);
void VarDefNode(GrammaNode* node,LinearIR *IR);
void FuncDefNode(GrammaNode* node,LinearIR *IR);
void BlockNode(GrammaNode* node,LinearIR *IR);
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


