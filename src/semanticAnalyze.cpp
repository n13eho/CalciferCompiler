#include "semanticAnalyze.h" //语义检查
#include "sysy_node.hpp"
//TODO：我们的exp还没有考虑左值
#include <string>
#include <map>
#include <stdexcept>

using namespace std;
int cnt=0;
string name="t";

// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode *> idList;

//循环体栈，用于标记continue，break
GrammaNode *cycleStack[10]; // 10 for 十层循环MAX
//该栈顶
int cycleStackTop = -1;

//外部符号表
extern idTable_struct *SymbolTable;
void semanticAnalyzer(GrammaNode *root);

void printIdMap()
{ //这里输出的是作用域检查的结果，打印idNameList和idList的内容
#ifdef DEBUG_SCOPE
    cout << "idNameList:" << endl;
    for (auto iter = idNameList.begin(); iter != idNameList.end(); iter++)
    {
        cout << iter->first << " " << iter->second << endl;
    }
    cout << "idList:" << endl;
    for (auto iter = idList.begin(); iter != idList.end(); iter++)
    {
        cout << iter->first.first << " " << iter->first.second << " " << iter->second->type << endl;
    }
#endif
}

void semantic_FuncDef_int_(GrammaNode *root)
{                                                                                                    //如果他是一个int返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->var_scope, 0, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                        //建立SymbolTable映射
    semanticAnalyzer(root->son[1]);                                                                  //去遍历block
}

void semantic_FuncDef_void_(GrammaNode *root)
{                                                                                                    //如果他是一个void返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->var_scope, 0, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                        //建立SymbolTable映射
    semanticAnalyzer(root->son[1]);                                                                  //去遍历block
}
IntegerValue* semantic_UnaryExp_(GrammaNode* root, bool needConst)
{
    if(root->son.size() == 0)
    {
        int constval = 0 ;
        if(root->type == IntConst_D_)
        {
            constval = stoi(root->str,0,10);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_){
            constval = stoi(root->str,0,8);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_)
        {
            constval = stoi(root->str,0,16);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == Ident_)
        {
            GrammaNode* init = idList[make_pair(root->str,root->var_scope)];
            IntegerValue* temp = (IntegerValue*)SymbolTable->askItem(init);
            if(needConst == 1 && temp->isConst !=1){
                //error
            }
            else{
                SymbolTable->addItem(root,temp);
                return temp;
            }
        }
    }
    else
    {
        if(UnaryExp_func_ == root->type)
        {
            GrammaNode* temp = idList[make_pair(root->son[0]->str,root->son[0]->var_scope)];
            FunctionValue* val =(FunctionValue*)SymbolTable->askItem(temp);
            SymbolTable->addItem(temp,val);
            //检查参数列表
        }
        else
        {
            IntegerValue* sonval = semantic_UnaryExp_(root->son[1],needConst);
            if(needConst == 1 && sonval->isConst == 0){;}//error
            //可能需要判断这里能否取非（语义检查）
            IntegerValue* tem = new IntegerValue(name+to_string(cnt++),root->lineno,root->son[1]->var_scope,sonval->isConst);
            SymbolTable->addItem(root,tem);
        }
    }
}

//------------------------------------------待解决--------------------------------------
IntegerValue* semantic_MulExp_(GrammaNode *root, bool needConst)
{ //这里是MulExp
    if(root->son.size() == 0)
    {
        int constval = 0 ;
        if(root->type == IntConst_D_)
        {
            constval = stoi(root->str,0,10);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_){
            constval = stoi(root->str,0,8);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_)
        {
            constval = stoi(root->str,0,16);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == Ident_)
        {
            GrammaNode* init = idList[make_pair(root->str,root->var_scope)];
            IntegerValue* temp = (IntegerValue*)SymbolTable->askItem(init);
            if(needConst == 1 && temp->isConst !=1){
                //error
            }
            else{
                SymbolTable->addItem(root,temp);
                return temp;
            }
        }
    }
    else
    {
        IntegerValue* mul = semantic_MulExp_(root->son[0],needConst);
        IntegerValue* unary = semantic_UnaryExp_(root->son[1],needConst);
        int thisconst = (mul->isConst>0) && (unary->isConst>0);
        if(thisconst == 0 && needConst == 1)
        {
            //error;
        }
        IntegerValue* temp = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,thisconst);
        SymbolTable->addItem(root,temp);
        return temp;
    }    
}
IntegerValue* semantic_Exp_(GrammaNode *root, bool needConst)
{ //这里可以做语义检查：其值必须是常量，needConst为真的话就表明这里必须都是常量，不能是变量 
// 这里本质是addexp
    if(root->son.size() == 0)
    {
        int constval = 0 ;
        if(root->type == IntConst_D_)
        {
            constval = stoi(root->str,0,10);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_){
            constval = stoi(root->str,0,8);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == IntConst_O_)
        {
            constval = stoi(root->str,0,16);
            IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,constval,1);
            SymbolTable->addItem(root,ret);
            return ret;
        }
        else if(root->type == Ident_)
        {
            GrammaNode* init = idList[make_pair(root->str,root->var_scope)];
            IntegerValue* temp = (IntegerValue*)SymbolTable->askItem(init);
            if(needConst == 1 && temp->isConst !=1){
                //error
            }
            else{
                SymbolTable->addItem(root,temp);
                return temp;
            }
        }
    }
    else
    {
        IntegerValue* add =semantic_Exp_(root->son[0],needConst);
        IntegerValue* mul = semantic_MulExp_(root->son[1],needConst);
        int thisconst = (add->isConst>0) && (mul->isConst>0);
        if(thisconst == 0 && needConst == 1)
        {
            //error;
        }
        IntegerValue* temp = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,thisconst);
        SymbolTable->addItem(root,temp);
        return temp;
    }
}

Value *semantic_Func_FparamSon(GrammaNode *root)
{// 处理三种不同的函数参数声明里面的参数：int、一维度的array、多维度array
    if (root->type == FuncFParam_single_)
    {
        IntegerValue *item = new IntegerValue(root->son[0]->str, root->lineno, root->var_scope,0);
        //建表
        SymbolTable->addItem(root, item);
        SymbolTable->addItem(root->son[0], item);
        return item;
    }
    else if (root->type == FuncFParam_singleArray_)
    {
        ArrayValue *item = new ArrayValue(root->son[0]->str, root->lineno, root->var_scope);
        vector<unsigned> dimen;
        dimen.push_back(-1); // 因为他是1维的，因此直接push一个最大的数字
        item->setDimen(dimen);
        //建表
        SymbolTable->addItem(root, item);
        SymbolTable->addItem(root->son[0], item);
        return item;
    }
    else if (root->type == FuncFParam_array_)
    {
        ArrayValue *item = new ArrayValue(root->son[0]->str, root->lineno, root->var_scope);
        vector<unsigned> dimen;
        dimen.push_back(-1);
        for (int i = 0; i < root->son[3]->son.size(); i++)
        {
            IntegerValue *temp = (IntegerValue *)semantic_Exp_(root->son[3]->son[i], true); //！！这里必须返回常量
            dimen.push_back(temp->getValue());
        }
        // 建立维度信息的vector
        item->setDimen(dimen);
        //建表
        SymbolTable->addItem(root, item);
        SymbolTable->addItem(root->son[0], item);
        return item;
    }
    else return NULL; // 为了让warning闭嘴，严格上不会执行到这一步
}

vector<Value *> semantic_Func_Fparam(GrammaNode *root)
{// 函数声明的参数表
    vector<Value *> ret;
    ret.clear();
    for (int i = 0; i < root->son.size(); i++)
    {
        // 由于参数自己本身是一个节点，所以还要对son进行处理
        Value *ParamSon = semantic_Func_FparamSon(root->son[i]);
        ret.push_back(ParamSon);
    }
    return ret;
}

void semantic_FuncDef_int_para_(GrammaNode *root)
{ //如果他是一个int返回值函数且有形参
    int howManySon = root->son[1]->son.size();
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->var_scope, howManySon, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                 //建立SymbolTable映射
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semanticAnalyzer(root->son[2]); //去遍历block
}

void semantic_FuncDef_void_para_(GrammaNode *root)
{ //如果他是一个void返回值函数且有形参
    int howManySon = root->son[1]->son.size();
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->var_scope, howManySon, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                 //建立SymbolTable映射
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semanticAnalyzer(root->son[2]); //去遍历block
}
Value* semantic_InitVal3_(GrammaNode* root,int dimen=0,vector<int> dimen_std={0})
{
    if(root->type == InitVal_EXP)
    {
        return semantic_Exp_(root->son[0],1);
    }
    else if( root->type == InitVal_NULL)
    {
        int x=1;
        for(int i=dimen;i<dimen_std.size();i++)x*=dimen_std[i];
        vector<int> valzero(x,0);
        ConstArrayValue* ret = new ConstArrayValue(name+to_string(cnt),root->lineno,root->var_scope,dimen_std,valzero);
        SymbolTable->addItem(root,ret);
        return ret;
    }
    else if( root->type == InitVal_)
    {
        if(dimen >= dimen_std.size())
        {//----------语义检查：维度匹配-----
            //error;
            return NULL;
        }

        vector<int> valzero;
        GrammaNode* initnode = root->son[0];
        int tot = 1;
        // for(auto i : )
        // for(int j=0;j<batch;j++)
        // {
        //     for(int i=0;i<initnode->son.size();i++)
        //     {
        //         if(initnode->son[i]->type == InitVal_EXP)
        //         {
        //             IntegerValue* t = (IntegerValue*)semantic_InitVal3_(initnode->son[i]);
        //             valzero.push_back(t->getValue());
        //         }

        //         // else if(initnode->son[i]->type == InitVal_NULL)
        //         // {
        //         //     IntegerValue* t = (IntegerValue*)semantic_InitVal3_(initnode->son[i]);

        //         // }
        //         // else if(initnode->son[i]->type == InitVal_)
        //         // {

        //         // }
        //         // else 
        //         // {
        //         //     ;//error
        //         // }
        //     }
        // }
        
        ConstArrayValue* ret = new ConstArrayValue(name+to_string(cnt),root->lineno,root->var_scope,dimen_std,valzero);
        SymbolTable->addItem(root,ret);
        return ret;
    }
    else
    {
        ;//error
    }
}

void semantic_ConstDefSon(GrammaNode* root)
{
    if(root->type == ConstDef_single_)
    {//const int a = 0;
        if(root->son[1]->type != InitVal_EXP)
        {//error;
            ;
        }
        IntegerValue* initVal = (IntegerValue*)semantic_InitVal3_(root->son[1]);//OOP
        IntegerValue* tem = new IntegerValue(root->son[0]->str,root->lineno,root->var_scope,initVal->getValue(),1);
        SymbolTable->addItem(root,tem);
        SymbolTable->addItem(root->son[0],tem);

    }
    else if(root->type == ConstDef_array_)
    {
        if(root->son[2]->type == InitVal_EXP)
        {
            ;//error
        }

        vector<int> dimen;//计算维度
        dimen.clear();
        for(int i=0;i<root->son[1]->son.size();i++)
        {
            GrammaNode* constexp = root->son[1]->son[i];
            IntegerValue* val = (IntegerValue*)semantic_Exp_(constexp,1);//计算第i维的大小
            dimen.push_back(val->getValue());
        }

        ConstArrayValue* initVal = (ConstArrayValue*)semantic_InitVal3_(root->son[2], 0, dimen);//calc initval
        //TODO:语义检查：维度是否匹配
        // ConstArrayValue* tem = new Const
        
    }
    else
    {
      ;  //error
    }
}

void semantic_ConstDef_(GrammaNode* root)
{
    for(int i=0;i<root->son.size();i++)semantic_ConstDefSon(root->son[i]);
}

void semanticAnalyzer(GrammaNode *root)
{
    //随时记录循环层数，检查break和continue在循环外使用的检查
    if (root->type == Stmt_While_)
        cycleStackTop++;

    // 针对每一个节点的类型进行语义判断和检查
    for (int i = 0; i < root->son.size(); i++)
    {
        GrammaNode *son = root->son[i];
        if (son->type == FuncDef_int_)
            semantic_FuncDef_int_(son); // int 无参数
        else if (son->type == FuncDef_void_)
            semantic_FuncDef_void_(son); // void 无参数
        else if (son->type == FuncDef_int_para_)
            semantic_FuncDef_int_para_(son); // int 有参数
        else if (son->type == FuncDef_void_para_)
            semantic_FuncDef_void_para_(son); // void 有参数
        else if (son->type == ConstDefs_)semantic_ConstDef_(son);
        // else if (son->type == VarDefs_)semanticVarDefs_(son);
        
    }
}

void idTable_struct::addItem(GrammaNode *key, Value *info)
{
    SymbolTable->table[key] = info;
}

Value *idTable_struct::askItem(GrammaNode *key)
{
    return SymbolTable->table[key];
}