#include <iostream>
#include <stdio.h>
#include "sysy_node.hpp"

void show_node(GrammaNode* root,int layer=0)
{
    for(int i=0;i<layer*3;i++)
        std::cout<<" ";
    std::cout<<"->";
    std::cout<<"node string:"<<root->str<<"\t son numbers:"<<root->son.size()<<std::endl;
    for(int i=0;i<root->son.size();i++)
    {
        show_node(root->son[i],layer+1);
    }
}

void VisitAST(GrammaNode* DRoot,LinearIR *IR)
{
    for(int i=0;i<DRoot->son.size();i++)
    {
        if(ConstDefs_ == DRoot->son[i]->type)
        {
            ConstDefNode(DRoot->son[i],IR);
        }
        else if(VarDefs_ ==  DRoot->son[i]->type)
        {
            VarDefNode(DRoot->son[i],IR);
        }
        else if(FuncDef_int_ ==  DRoot->son[i]->type)
        {
            FuncDef_Int(DRoot->son[i],IR);
        }
        else if(FuncDef_void_ ==  DRoot->son[i]->type)
        {
            FuncDef_Void(DRoot->son[i],IR);
        }
        else if(FuncDef_int_para_ ==  DRoot->son[i]->type)
        {
            FuncDef_IntParams(DRoot->son[i],IR);
        }
        else if(FuncDef_void_para_ ==  DRoot->son[i]->type)
        {
            FuncDef_VoidParams(DRoot->son[i],IR);
        }
    }
}

void ConstDefNode(GrammaNode* node,LinearIR *IR)
{
    //节点先递归得到右值
    for(int i=0;i<node->son.size();i++)
    {
        if(ConstDef_array_ == node->son[i]->type)
        {
            
        }
        else if(ConstDef_single_ == node->son[i]->type)
        {
            //Ident,待修改
            Value* VL=nullptr;
            //右值必为单值
            Value* VR=nullptr;
            //ConstDef:Ident ASSIGN InitVal
            if(node->son[i]->son.size()>=2)
            {
                VR = InitValNode(node->son[i]->son[1],IR);
            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::InsType(8),1);
            ins_new->addOperand(VR);
            ins_new->setResult(VL);
            IR->InsertInstr(ins_new);
        }
    }
}

void VarDefNode(GrammaNode* node,LinearIR *IR)
{
    for(int i=0;i<node->son.size();i++)
    {
        if(VarDef_array_init_ ==  node->son[i]->type)
        {

        }
        else if(VarDef_array_ ==  node->son[i]->type)
        {
            //若已加入符号表，则return
            return;
        }
        else if(VarDef_single_ == node->son[i]->type)
        {
            //若已加入符号表，则return
            return;
        }
        else if(VarDef_single_init_ ==  node->son[i]->type)
        {
            //Ident,待修改
            Value* VL=nullptr;
            //右值必为单值
            Value* VR=nullptr;
            //VarDef:Ident ASSIGN InitVal
            if(node->son[i]->son.size()>=2)
            {
                VR = InitValNode(node->son[i]->son[1],IR);
            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
            ins_new->addOperand(VR);
            ins_new->setResult(VL);
            IR->InsertInstr(ins_new);
        }
    }
}

//Func部分没考虑好
void FuncDef_Int(GrammaNode* node,LinearIR *IR)
{
    
}
void FuncDef_Void(GrammaNode* node,LinearIR *IR)
{

}
void FuncDef_IntParams(GrammaNode* node,LinearIR *IR)
{

}
void FuncDef_VoidParams(GrammaNode* node,LinearIR *IR)
{

}

Value* InitValNode(GrammaNode* node,LinearIR *IR)
{
    Value* ret=nullptr;
    if(InitVal_EXP == node->type)
    {//表达式,son个数为1
        if(node->son.size() == 1)
        {
            ret = ExpNode(node->son[0],IR);
        }
    }
    else if(InitVal_NULL == node->type)
    {//空{}

    }
    else if(InitVal_ == node->type)
    {//多个初值

    }
}

Value* ExpNode(GrammaNode* node,LinearIR *IR)
{
    if(AddExp_Add_ == node->type)
    {

    }
    else if(AddExp_Sub_ == node->type)
    {

    }
    else
    {
        //MulExp
        return MulExpNode(node,IR);
    }
}

Value* MulExpNode(GrammaNode* node,LinearIR *IR)
{
    if(MulExp_Mul_ == node->type)
    {

    }
    else if(MulExp_Div_ == node->type)
    {

    }
    else if(MulExp_Mod_ == node->type)
    {
        
    }
    else
    {//UnaryExp
        return UnaryExpNode(node,IR);
    }
}

Value* UnaryExpNode(GrammaNode* node,LinearIR *IR)
{
    if(UnaryExp_func_ == node->type)
    {

    }
    else if(UnaryExp_func_ == node->type)
    {

    }
    else if(UnaryExp_ == node->type)
    {

    }
    else
    {//PrimaryExp

    }
}

Value* PrimaryExpNode(GrammaNode* node,LinearIR *IR)
{}