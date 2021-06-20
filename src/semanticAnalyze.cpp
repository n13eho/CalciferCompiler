#include "semanticAnalyze.h" //语义检查
#include "sysy_node.hpp"
#include"../include/Value.h"

#include <string>
#include <map>

using namespace std;


// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode*> idList;

extern idTable_struct *idTable;

void semanticAnalyzer(GrammaNode* root)
{
#ifdef DEBUG_SCOPE
    cout << "idNameList:" << endl;
    for(auto iter = idNameList.begin(); iter != idNameList.end(); iter++)
    {
        cout << iter->first << " "<< iter->second << endl;
    }
    cout << "idList:" << endl;
    for(auto iter = idList.begin(); iter != idList.end(); iter++)
    {
        cout << iter->first.first << " " << iter->first.second <<" " << iter->second->son.size()<<endl;
    }
#endif
    for(int i=0;i<root->son.size();i++)
    {
        GrammaNode* son=root->son[i];
        if(son->type==FuncDef_int_)value_FuncDef_int_(son);
        else if(son->type == ConstDefs_)semanticConstDefs_(son);
        else if(son->type == VarDefs_)semanticVarDefs_(son);
    }
}
int semanticConstDefs_(GrammaNode* root)
{
    for(int i=0;i<root->son.size();i++)
    {
        GrammaNode* constdef = root->son[i];
        if(constdef->type == ConstDef_single_){}
    }
}
int semanticVarDefs_(GrammaNode* root)
{

}

int semanticBlock(GrammaNode* root)
{
    for(int i=0;i<root->son.size();i++)
    {
        //对于每一个语句进行遍历。
        GrammaNode* son = root->son[i];
        if(son->type == Stmt_Assign_){}
    }
}

int semanticInitVal(GrammaNode* root, bool isConst,Value* result){
    if(root->type == InitVal_EXP){
       ; 
    }
    if(root->type == InitVal_NULL)
    {
        if(isConst == 1)return -1;
        else{ result = NULL;return 0;}
    }
    if(root->type == InitVal_)
    {
        // so complex!!!!!
    }
}

int semanticAddExp(GrammaNode* root, bool isConst, Value* result){
    if(root->type == AddExp_Add_){}
    else if(root->type == AddExp_Sub_){}
    else semanticMulExp(root, isConst, result);
}
int semanticMulExp(GrammaNode* root, bool isConst, Value* result){
    if(root->type == MulExp_Mul_){}
    else if(root->type == MulExp_Div_){}
    else if(root->type == MulExp_Mod_){}
    else semanticUnaryExp(root, isConst, result);
        
}
int semanticUnaryExp(GrammaNode* root, bool isConst, Value* result){
        
}

int value_FuncDef_int_(GrammaNode* root)
{
    // string scope = askscope(root);//TODO:这里要askscope。
    string scope = "1";
    FunctionValue * item = new FunctionValue(root->son[0]->str,root->lineno,scope,0);// build the value table of funcdef_int
    idTable->addItem(root->son[0],item);//add the item into idTable
    semanticBlock(root->son[1]);//去遍历block
}
int value_ConstDef_sigle_(GrammaNode* root){
    string scope = "1";//TODO:askscope;
    int initVal = 0;//TODO: get val
    ConstIntegerValue * item = new ConstIntegerValue(root->son[0]->str,root->son[0]->lineno,scope,initVal);//build one
    idTable->addItem(root->son[0],item);//add the item
}
