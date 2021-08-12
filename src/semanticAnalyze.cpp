#include "../include/semanticAnalyze.h" //语义检查
#include "../include/sysy_node.hpp"
#include "../include/dbg.h"
#include <string>
#include <map>
#include <stdexcept>

using namespace std;
int cnt = 0;
string name = "t";

// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode *> idList;
// 循环栈顶
int cycleStackTop = 0;
// 函数类型type
int funcType = -1; // -1：初始值  0：返回值为int  1：返回值为void

//外部符号表
extern idTable_struct *SymbolTable;
void semanticAnalyzer(GrammaNode *root);
IntegerValue *semantic_Exp_(GrammaNode *root, int needConst, int needCond);
IntegerValue *semantic_LVal_Array_(GrammaNode *root, int needConst, int needCod);
IntegerValue *semantic_PrimaryExp_(GrammaNode *root, int needConst, int needCod);
IntegerValue *semantic_EqExp_(GrammaNode *root);
void semantic_ConstDef_(GrammaNode *root);
void semantic_VarDefs_(GrammaNode *root);
Value *semantic_InitVal3_(GrammaNode *root, int isConst, int dimen = 0, vector<unsigned> dimen_std = {0});
void semantic_Block(GrammaNode *root);

void printIdMap()
{ //这里输出的是作用域检查的结果，打印idNameList和idList的内容
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
}

IntegerValue *semantic_LVal_(GrammaNode *root)
{
    if (root->type == LVal_Array_)
        return semantic_LVal_Array_(root, -1, 0); //-1表示必须不是常量！！！√error
    else
    {
        return semantic_PrimaryExp_(root, -1, 0); //√error,必须不是常量
    }
}

IntegerValue *semantic_RelExp_(GrammaNode *root)
{
    if (root->type == RelExp_BG_ || root->type == RelExp_BQ_ || root->type == RelExp_LQ_ || root->type == RelExp_LT_)
    {
        IntegerValue *rel = semantic_EqExp_(root->son[0]);
        IntegerValue *add = semantic_RelExp_(root->son[1]);
        IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, 0);
        ret->isTemp = 1;
        if (root->type == RelExp_BG_)
            ret->RealValue = (rel->RealValue > add->RealValue);
        else if (root->type == RelExp_BQ_)
            ret->RealValue = (rel->RealValue >= add->RealValue);
        else if (root->type == RelExp_LQ_)
            ret->RealValue = (rel->RealValue <= add->RealValue);
        else if (root->type == RelExp_LT_)
            ret->RealValue = (rel->RealValue < add->RealValue);
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else
    {
        return semantic_Exp_(root, 0, 1);
    }
}

IntegerValue *semantic_EqExp_(GrammaNode *root)
{
    if (root->type == EqExp_EQ_ || root->type == EqExp_NEQ_)
    {
        IntegerValue *eq = semantic_EqExp_(root->son[0]);
        IntegerValue *rel = semantic_RelExp_(root->son[1]);
        IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, 0);
        ret->isTemp = 1;
        if (root->type == EqExp_NEQ_)
            ret->RealValue = (eq->RealValue != rel->RealValue);
        else if (root->type == EqExp_EQ_)
            ret->RealValue = (eq->RealValue == rel->RealValue);
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else
    {
        return semantic_RelExp_(root);
    }
}

IntegerValue *semantic_AndExp_(GrammaNode *root)
{
    IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, 0);
    ret->isTemp = 1;
    ret->RealValue = 1;
    for (int i = 0; i < root->son.size(); i++)
    {
        IntegerValue *tem = semantic_EqExp_(root->son[i]);
        ret->RealValue = ret->RealValue && tem->RealValue;
    }
    SymbolTable->addItem(root, ret);
    return ret;
}

IntegerValue *semantic_LOrExp_(GrammaNode *root)
{
    IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, 0);
    ret->isTemp = 1;
    ret->RealValue = 1;
    for (int i = 0; i < root->son.size(); i++)
    {
        IntegerValue *tem = semantic_AndExp_(root->son[i]);
        ret->RealValue = ret->RealValue || tem->RealValue;
    }
    SymbolTable->addItem(root, ret);
    return ret;
}

void semantic_cond_(GrammaNode *root)
{
    IntegerValue *temp = semantic_LOrExp_(root->son[0]);
    SymbolTable->addItem(root->son[0], temp);
}

void semantic_stmt_(GrammaNode *root)
{
    if (root->type == Stmt_Assign_)
    {
        IntegerValue *zuo = semantic_LVal_(root->son[0]);
        IntegerValue *you = semantic_Exp_(root->son[1], 0, 0);
        zuo->RealValue = you->RealValue;
        IntegerValue *tem = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, you->RealValue, 0);
        tem->isTemp = 1;
        SymbolTable->addItem(root->son[0], zuo);
        SymbolTable->addItem(root, tem);
    }
    else if (root->type == Stmt_Exp_)
    {
//        cout<<"at stmt_exp\n";
        semantic_Exp_(root->son[0], 0, 0);
    }
    else if (root->type == Stmt_If_)
    {
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
    }
    else if (root->type == Stmt_IfElse_)
    {
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
        semantic_stmt_(root->son[2]);
    }
    else if (root->type == Stmt_While_)
    {
        cycleStackTop++;
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
        cycleStackTop--;
    }
    else if (root->type == Stmt_Return_)
    {// 到了这一步，肯定是int返回类型的
        if(funcType != 0)
        {// √error
            //----------------语义检查【4.2】----------------
            throw SemanticError(root->lineno, root->str, "函数返回类型不一致");
        }
        semantic_Exp_(root->son[0], 0, 0);
    }
    else if (root->type == Block_)
    {
        semantic_Block(root);
    }
    else
    {   
        //break,return,continue;
        //这里需要循环语义检查！
        // break and continue here first
        if(root->str.compare("break") == 0 || root->str.compare("continue") == 0)
        {
            if(cycleStackTop == 0)
            {// 0 层循环
                //----------------语义检查【4.1】----------------
                throw SemanticError(root->lineno, root->str, "不在循环内");
            }
        }

        // what to do with return xerror
        if(root->str.compare("return") == 0 && funcType != 1)
        {// 到了这一步必须是void，因此若当前是int返回类型则报错
            //----------------语义检查【4.2】----------------
            throw SemanticError(root->lineno, root->str, "函数返回类型不一致");
        }
    }
}

void semantic_Block(GrammaNode *root)
{
    for (int i = 0; i < root->son.size(); i++)
    {
        if (root->son[i]->type == ConstDefs_)
            semantic_ConstDef_(root->son[i]);
        else if (root->son[i]->type == VarDefs_)
            semantic_VarDefs_(root->son[i]);
        else{
            semantic_stmt_(root->son[i]);
        }
    }
}

void semantic_FuncDef_int_(GrammaNode *root)
{                                                                                                            //如果他是一个int返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                //建立SymbolTable映射
    SymbolTable->addItem(root, item);                                                                        // 他自己也要，不然找不到
    semantic_Block(root->son[1]);                                                                            //去遍历block
}

void semantic_FuncDef_void_(GrammaNode *root)
{                                                                                                            //如果他是一个void返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    semantic_Block(root->son[1]); //去遍历block
}

IntegerValue *semantic_LVal_Array_(GrammaNode *root, int needConst, int needCond)
{ // 注意这里其实在树中打印出来是LVal_，ypp中造结点的时候用的这个串儿
    // 找到声明地方的原数组
    GrammaNode *temp = idList[make_pair(root->son[0]->str, root->son[0]->var_scope)]; // 从idList找原来的书上的结点
    // 检查一下是不是arrayvlaue
    ArrayValue *val = (ArrayValue *)SymbolTable->askItem(temp);
     if(val->isConst == 1 && needConst == -1) //左值出现了一个常量数组
        throw SemanticError(root->lineno,root->str,"左值应该是个变量");
    // 建立映射
    SymbolTable->addItem(root, val);
    // SymbolTable->addItem(root->son[0], val);
    // 求索引
    vector<int> indexVector;
    int dimensionSize = 1, index = 0;
    indexVector.clear();
    int eachIndex = 0; // 获取每一个维度信息

    // 维度个数检查
    if (root->son[1]->son.size() > val->NumOfDimension.size())
    { // √error 多了肯定是不行的
        // 数组访问越界：超出维度了
        //----------------语义检查【2.2】----------------
        throw SemanticError(root->lineno, val->VName, "数组访问越界：维度超了");
    }
    // 这里这个【2.3】存疑，对函数调用是否有影响，函数调用可以这么用
    // 0801补充 确实对函数调用有印象
//    if (root->son[1]->son.size() < val->NumOfDimension.size())
//    { // √error 少了未必不对
        // 数组访问越界：超出维度了
        //----------------语义检查【2.3】----------------
//        throw SemanticError(root->lineno, val->VName, "数组访问越界：维度不够");
//    }

    for (int i = 0; i < root->son[1]->son.size(); i++)
    {
        IntegerValue* indexValue = semantic_Exp_(root->son[1]->son[i], 0, 0);
        if(indexValue->isConst == 0)continue; // 不是常数就不判

        // 获取访问的维度 eachIndex
        eachIndex = indexValue->RealValue;
        // 判断访问维度是否越界
//        cout << "********** " << eachIndex << endl;
        if (eachIndex >= val->NumOfDimension[i] || eachIndex < 0)
        { // √error 超额或者索引是负数
            // 数组访问越界
            //----------------语义检查【2.1】----------------
            throw SemanticError(root->lineno, val->VName, "数组访问越界：数值与原维度不匹配");
        }
        // 未越界，则继续push_back
        indexVector.push_back(eachIndex);
        dimensionSize *= val->NumOfDimension[i];
    }
    for (int i = 0; i < indexVector.size(); i++)
    {
        dimensionSize /= val->NumOfDimension[i];
        index += indexVector[i] * dimensionSize;
    }
    //根据索引求值
    //probbbbbbbbbbbbbbbbblemhere
    //zyh 给 neho 的问题
    //暂时的解决方案, 能算出来就算, 算不出来就不算了 ---hsyy04
    int indexVal;
    if(index>=val->ArrayElement.size())indexVal = 0;
    else indexVal = val->ArrayElement[index];

    IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, indexVal, val->isConst);
    ret->isTemp = 1;
    // 建立映射
    SymbolTable->addItem(root, ret);

    return ret;
}

IntegerValue *semantic_PrimaryExp_(GrammaNode *root, int needConst, int needCond)
{
    // 情况3：IntConst
    int constval = 0;
    if (root->type == IntConst_D_&& needConst!=-1)
    {
        constval = stoi(root->str, 0, 10);
        IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, constval, 1);
        ret->isTemp = 1;
        SymbolTable->addItem(root,ret); // 这样的纯数字就不需要映射了
        return ret;
    }
    else if (root->type == IntConst_O_&& needConst!=-1)
    {
        constval = stoi(root->str, 0, 8);
        IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, constval, 1);
        ret->isTemp = 1;
        SymbolTable->addItem(root,ret); // 这样的纯数字就不需要映射了
        return ret;
    }
    else if (root->type == IntConst_H_&& needConst!=-1)
    {
        constval = stoi(root->str, 0, 16);
        IntegerValue *ret = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, constval, 1);
        ret->isTemp = 1;
        SymbolTable->addItem(root,ret); // 这样的纯数字就不需要映射了
        return ret;
    }
    // 情况2.2 Ident
    else if (root->type == Ident_)
    {
        
        GrammaNode *init = idList[make_pair(root->str, root->var_scope)];
        IntegerValue *temp = (IntegerValue *)SymbolTable->askItem(init);

        if (needConst == 1 && temp->isConst != 1)
        {
            //√error
            // 该左值->Ident：如果传入参数needConst为1的话，这个Ident也必须为常量，否则报错
            //----------------语义检查【1.2】----------------
            throw SemanticError(temp->lineno, temp->VName, "不是常量");
        }
        else if(needConst == -1 && temp->isConst == 1)
        {
            throw SemanticError(temp->lineno, temp->VName, "左值应该是一个变量");
        }
        else
        {
            SymbolTable->addItem(root, temp);
            return temp;
        }
    }
    else if (root->type == LVal_Array_)
    {
        return semantic_LVal_Array_(root, needConst, needCond);
    }
    else
    {
        if(needConst == -1)
            throw SemanticError(root->lineno, root->str, "左值不能是表达式");
        return semantic_Exp_(root, needConst, needCond);
    }
}

IntegerValue *semantic_UnaryExp_(GrammaNode *root, int needConst, int needCond)
{
    if (UnaryExp_func_ == root->type)
    {
        GrammaNode *tempGn = idList[make_pair(root->son[0]->str, root->son[0]->var_scope)]; // 从idList找原来的树上的结点

        FunctionValue *val = (FunctionValue *)SymbolTable->askItem(tempGn);
        if(val == NULL)
        { // 他是运行时库
            int sysyparamcnt = 0, sysyretType = 0;

            if(root->son[0]->str == "getint")
            {
                sysyparamcnt = 0;
                sysyretType = 1;
            }
            else if(root->son[0]->str == "getch")
            {
                sysyparamcnt = 0;
                sysyretType = 1;
            }
            else if(root->son[0]->str == "getarray")
            {
                sysyparamcnt = 1;
                sysyretType = 1;
            }
            else if(root->son[0]->str == "putint")
            {
                sysyparamcnt = 1;
                sysyretType = 0;
            }
            else if(root->son[0]->str == "putch")
            {
                sysyparamcnt = 1;
                sysyretType = 0;
            }
            else if(root->son[0]->str == "putarray")
            {
                sysyparamcnt = 1;
                sysyretType = 0;
            }
            else if(root->son[0]->str == "putf")
            {
                sysyparamcnt = 999;
                sysyretType = 0;
            }
            else if(root->son[0]->str == "starttime")
            {
                sysyparamcnt = 1;
                sysyretType = 0;
            }
            else if(root->son[0]->str == "stoptime")
            {
                sysyparamcnt = 1;
                sysyretType = 0;
            }

            FunctionValue* runtime_fv = new FunctionValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, sysyparamcnt, sysyretType);
            val = runtime_fv;

        }

        // 函数调用语义检查 √error：这里先只检查参数个数；这里需要绕过putf运行时库
        int call_param_number = 0;
        if(root->son.size() > 1)
        {// 有参数
            call_param_number = root->son[1]->son.size();
        }
        // 有参数的运行时库：后门全开
        if(root->son[0]->str != "getarray" && root->son[0]->str != "putint" && root->son[0]->str != "putch" && root->son[0]->str != "putarray" && root->son[0]->str != "putf")
        {
            if(call_param_number != val->getParams().size())
            {// 个数不匹配
                //----------------语义检查【3.1】----------------
                throw SemanticError(root->lineno, root->son[0]->str, "函数参数个数不匹配");
            }
        }

        //语义检查没问题就映射函数名字
        SymbolTable->addItem(root->son[0], val);

        //映射参数
        for(int i=0; i<call_param_number; i++)
        {
            IntegerValue *param_i = semantic_Exp_(root->son[1]->son[i], needConst, needCond);
            SymbolTable->addItem(root->son[1]->son[i], param_i);
        }

        // 这里好像不能return一个IntegerValue了，还是会warning，先warning住吧。随便返回一个临时变量，初始值为0
        IntegerValue *lsbl = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, 0);
        lsbl->isTemp = 1;
        SymbolTable->addItem(root, lsbl);
        return lsbl;
    }
    else if (UnaryExp_ == root->type)
    {
        IntegerValue *sonval = semantic_UnaryExp_(root->son[1], needConst, needCond);
        if (needConst == 1 && sonval->isConst == 0)
        { // √error
            //----------------语义检查【1.2】----------------
            throw SemanticError(sonval->lineno, sonval->VName, "不是常量");
        }

        IntegerValue *tem = new IntegerValue(name + to_string(cnt++), root->lineno, root->son[1]->var_scope, sonval->isConst);
        tem->isTemp = 1;
        if (root->son[0]->str == "+")
            tem->RealValue = sonval->RealValue;
        else if (root->son[0]->str == "-")
            tem->RealValue = -sonval->RealValue;
        else if (root->son[0]->str == "!" && needCond == 1) //可能需要判断这里能否取非（语义检查）
            tem->RealValue = !sonval->RealValue;
        else
        {
            throw SemanticError(sonval->lineno,sonval->VName,"不是条件语句");//√error
        }

        SymbolTable->addItem(root, tem);
        return tem;
    }
    else
    {
        return semantic_PrimaryExp_(root, needConst, needCond);
    }
}

IntegerValue *semantic_MulExp_(GrammaNode *root, int needConst, int needCond)
{ //这里是MulExp
    if (root->type != MulExp_Mul_ && root->type != MulExp_Div_ && root->type != MulExp_Mod_)
    {
        return semantic_UnaryExp_(root, needConst, needCond);
    }
    else
    {
        IntegerValue *mul = semantic_MulExp_(root->son[0], needConst, needCond);
        IntegerValue *unary = semantic_UnaryExp_(root->son[1], needConst, needCond);
        int thisconst = (mul->isConst > 0) && (unary->isConst > 0);
        if (thisconst == 0 && needConst == 1)
        { // √error;
            //----------------语义检查【1.2】----------------
            throw SemanticError(root->lineno, "不是常量");
        }
        IntegerValue *temp = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, thisconst);
        temp->isTemp = 1;
        //这里同样需要赋初始值
        if (root->type == MulExp_Mul_)
            temp->RealValue = mul->RealValue * unary->RealValue;
        else if (root->type == MulExp_Div_)
            temp->RealValue = unary->RealValue == 0 ? 0 : mul->RealValue / unary->RealValue;
        else if (root->type == MulExp_Mod_)
            temp->RealValue = unary->RealValue == 0 ? 0 : mul->RealValue % unary->RealValue;


        SymbolTable->addItem(root, temp);
        return temp;
    }
}

IntegerValue *semantic_Exp_(GrammaNode *root, int needConst, int needCond)
{   //这里可以做语义检查：其值必须是常量，needConst为真的话就表明这里必须都是常量，不能是变量
    // 这里本质是addexp
    // 来源可以是 InitVal_Exp->son[i] ConstExps->son[i]
    if (root->type != AddExp_Add_ && root->type != AddExp_Sub_)
    { // 对应没有一个孩子的
        return semantic_MulExp_(root, needConst, needCond);
    }
    else
    {
        IntegerValue *add = semantic_Exp_(root->son[0], needConst, needCond);
        IntegerValue *mul = semantic_MulExp_(root->son[1], needConst, needCond);
        int thisconst = (add->isConst > 0) && (mul->isConst > 0); // 必须确保两个两的常量状态相与 和 当前needConst一致 否则报错
        if (thisconst == 0 && needConst == 1)
        { // √error;
            //----------------语义检查【1.2】----------------
            throw SemanticError(root->lineno, "不是常量");
        }
        IntegerValue *temp = new IntegerValue(name + to_string(cnt++), root->lineno, root->var_scope, thisconst);
        temp->isTemp = 1;
        // 把两个儿子的计算结果求出来
        temp->RealValue = (root->type == AddExp_Add_) ? (add->RealValue + mul->RealValue) : (add->RealValue - mul->RealValue);

        // 建立映射
        SymbolTable->addItem(root, temp);
        return temp;
    }
}

Value *semantic_Func_FparamSon(GrammaNode *root)
{ // 处理三种不同的函数参数声明里面的参数：int、一维度的array、多维度array
    if (root->type == FuncFParam_single_)
    {
        IntegerValue *item = new IntegerValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0);
        //建表
        SymbolTable->addItem(root, item);
        SymbolTable->addItem(root->son[0], item);
        return item;
    }
    else if (root->type == FuncFParam_singleArray_)
    {
        ArrayValue *item = new ArrayValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0);
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
        ArrayValue *item = new ArrayValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0);
        vector<unsigned> dimen;
        dimen.push_back(-1);
        for (int i = 0; i < root->son[3]->son.size(); i++)
        {
            IntegerValue *temp = (IntegerValue *)semantic_Exp_(root->son[3]->son[i], 1, 0); //！！这里必须返回常量
            dimen.push_back(temp->getValue());
        }
        // 建立维度信息的vector
        item->setDimen(dimen);
        //建表
        SymbolTable->addItem(root, item);
        SymbolTable->addItem(root->son[0], item);
        return item;
    }
    else
        return NULL; // 为了让warning闭嘴，严格上不会执行到这一步
}

vector<Value *> semantic_Func_Fparam(GrammaNode *root)
{ // 函数声明的参数表
    vector<Value *> ret;
    ret.clear();
    for (int i = 0; i < root->son.size(); i++)
    {
        // 由于参数自己本身是一个节点，所以还要对son进行处理
        Value *ParamSon = semantic_Func_FparamSon(root->son[i]);
        ParamSon->isPara=i+1;
        ret.push_back(ParamSon);
    }
    return ret;
}

void semantic_FuncDef_int_para_(GrammaNode *root)
{ //如果他是一个int返回值函数且有形参
    int howManySon = root->son[1]->son.size();
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, howManySon, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                         //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semantic_Block(root->son[2]); //去遍历block
}

void semantic_FuncDef_void_para_(GrammaNode *root)
{ //如果他是一个void返回值函数且有形参
    int howManySon = root->son[1]->son.size();
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, howManySon, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                         //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semantic_Block(root->son[2]); //去遍历block
}

ArrayValue *semantic_initVal_Son(GrammaNode *root, int isConst, int dimen = 0, vector<unsigned> dimen_std = {0})
{
    int base = 0, batchsize, tot = 1;
    //base: 当前填充到数组的第几个
    //tot：当前需要填充的数组总共多大
    ArrayValue *ret = new ArrayValue(name + to_string(cnt++), root->lineno, root->var_scope, isConst);
    ret->isTemp = 1;
    //创建带返回的value
    batchsize = dimen_std[dimen_std.size() - 1];
    //batchsize：当前填充维度大小
    for (auto i : dimen_std)
        tot *= i;
    int soni = 0; // 遍历他的儿子
    for (soni = 0; soni < root->son.size(); soni++)
    { //如果碰到了下一层数组就直接填过来，碰到exp，就换思路
        if (root->son[soni]->type == InitVal_EXP)
            break;
        else
        {
            vector<unsigned> new_dim;
            if(dimen_std.size()==1)
                throw SemanticError(root->lineno,root->str,"维度错误");
            else new_dim.assign(dimen_std.begin() + 1, dimen_std.end());
            new_dim.assign(dimen_std.begin() + 1, dimen_std.end()); //新维度减少到0 √error101
            ArrayValue *val = (ArrayValue *)semantic_InitVal3_(root->son[soni], isConst, 0, new_dim);
            ret->ArrayElement.insert(ret->ArrayElement.end(), val->ArrayElement.begin(), val->ArrayElement.end());
            base += tot / dimen_std[0]; //多了一个数组的值
        }
    }
    int batchi = 0;
    for (; soni < root->son.size(); soni++)
    { //这里按batch填充，如果遇到数组恰好batch也是新的，就不展开了，否则全部展开填，填满就报错
        if (root->son[soni]->type == InitVal_EXP)
        {
            IntegerValue *val = (IntegerValue *)semantic_InitVal3_(root->son[soni], isConst, 0, dimen_std);
            batchi++;
            batchi %= batchsize;
            base++; //又多了一个值
            ret->ArrayElement.push_back(val->RealValue);
        }
        else
        {
            vector<unsigned> new_dim;
            if(dimen_std.size()==1)
                throw SemanticError(root->lineno,root->str,"维度错误");
            else new_dim.assign(dimen_std.begin() + 1, dimen_std.end());
            ArrayValue *val = (ArrayValue *)semantic_InitVal3_(root->son[soni], isConst, 0, new_dim);
            while (val->ArrayElement[val->ArrayElement.size() - 1] == 0)
                val->ArrayElement.pop_back();
            if (val->ArrayElement.size() + batchi > batchsize)
            {
                throw SemanticError(val->lineno,val->VName,"维度错误");
            }
            if (batchi == 0)
            { //如果恰好在一个batch，那就不拉平数组了
                ret->ArrayElement.insert(ret->ArrayElement.end(), val->ArrayElement.begin(), val->ArrayElement.end());
                batchi += val->ArrayElement.size();
                base += val->ArrayElement.size();
                while (batchi < batchsize)
                {
                    ret->ArrayElement.push_back(0);
                    base++;
                    batchi++;
                }
                batchi %= batchsize;
                continue;
            }
            ret->ArrayElement.insert(ret->ArrayElement.end(), val->ArrayElement.begin(), val->ArrayElement.end());
            batchi += val->ArrayElement.size();
            batchi %= batchsize;
            base += val->ArrayElement.size();
        }
    }
    while (base < tot)
    {
        ret->ArrayElement.push_back(0);
        base++;
    } //here we padding with zero
    SymbolTable->addItem(root, ret);
    return ret;
}

Value *semantic_InitVal3_(GrammaNode *root, int isConst, int dimen, vector<unsigned> dimen_std)
{ // 三种常量初值：InitVal_EXP InitVal_NULL InitVal_

    if (root->type == InitVal_EXP)
    {
        return semantic_Exp_(root->son[0], isConst, 0); // 好像有问题，isConst和这个1
    }
    else if (root->type == InitVal_NULL)
    {
        int x = 1;
        for (int i = 0; i < dimen_std.size(); i++)
            x *= dimen_std[i];
        vector<int> valzero(x, 0); //初值全设为0
        ArrayValue *ret = new ArrayValue(name + to_string(cnt++), root->lineno, root->var_scope, isConst);
        ret->isTemp = 1;
        ret->setDimen(dimen_std);
        ret->setArray(valzero);
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else if (root->type == InitVal_)
    { //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@该怎么解决呢
        ArrayValue *ret = semantic_initVal_Son(root->son[0], isConst, 0, dimen_std);
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else
    {
        throw SemanticError(root->lineno,root->str,"不可能");
        return NULL; //√error
    }
}

void semantic_ConstDefSon(GrammaNode *root)
{ // 只有两种情况
    if (root->type == ConstDef_single_)
    { //第一种情况：const int a = 0;
        if (root->son[1]->type != InitVal_EXP)
        { // √error 只可能是InitVal_EXP
            throw SemanticError(root->lineno, "不可能-1");
        }
        // 要的到初值
        IntegerValue *initVal = (IntegerValue *)semantic_InitVal3_(root->son[1], 1); //OOP

        // what's this
        // cout<<initVal<<endl; // 0 问题所在
        // cout<<initVal->getValue()<<endl;
        // cout<<root->son[0];
        // cout<<" "<<root->lineno<<" ";

        IntegerValue *tem = new IntegerValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, initVal->getValue(), 1);
        SymbolTable->addItem(root, tem);
        SymbolTable->addItem(root->son[0], tem);
    }
    else if (root->type == ConstDef_array_)
    { // 第二种情况：const int d[x[0]][4%4][5*6] = {};
        if (root->son[2]->type == InitVal_EXP)
        { // √error 这里是因为，他的第三个孩子（初值）只有两种情况：InitVal_NULL（空值）和InitVal（复杂的情况）
            throw SemanticError(root->lineno, "不可能-2");
        }

        // 计算维度
        vector<unsigned> dimen;
        dimen.clear();
        for (int i = 0; i < root->son[1]->son.size(); i++)
        {
            GrammaNode *constexp = root->son[1]->son[i];
            IntegerValue *val = (IntegerValue *)semantic_Exp_(constexp, 1, 0); //计算第i维的大小
            dimen.push_back(val->getValue());
        }

        // 计算初值
        ArrayValue *initVal = (ArrayValue *)semantic_InitVal3_(root->son[2], 1, 0, dimen); //calc initval
        //语义检查：维度和初值是否匹配 在semantic_InitVal3_中已经检查

        /// 语义检查通过，new结点，建立映射
        // new
        ArrayValue *tem = new ArrayValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 1);
        tem->setDimen(dimen); // 设置维度信息
        tem->setArray(initVal->ArrayElement);
        // mapping
        SymbolTable->addItem(root, tem);
        SymbolTable->addItem(root->son[0], tem);
    }
    else
    { // √error
        throw SemanticError(root->lineno, "不可能-3");
    }
}

void semantic_ConstDef_(GrammaNode *root)
{
    for (int i = 0; i < root->son.size(); i++)
        semantic_ConstDefSon(root->son[i]);
}

void semantic_VarDefSon(GrammaNode *root)
{ // 有四种情况：VarDef_array_ VarDef_array_init_ VarDef_single_ VarDef_single_init_

    if (root->type == VarDef_single_)
    { // 单值变量，无初始参数（默认都为0）
        //只需要new结点，建立映射即可
        IntegerValue *single = new IntegerValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);
        //两个映射都建
        SymbolTable->addItem(root, single);
        SymbolTable->addItem(root->son[0], single);
    }
    else if (root->type == VarDef_single_init_)
    { // 单值变量，有初始参数
        //先算出初值 initValue
        IntegerValue *initValueObj = (IntegerValue *)semantic_InitVal3_(root->son[2], 0);
        int initValue = initValueObj->RealValue;
        //new出新的结点
        IntegerValue *single_init = new IntegerValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, initValue, 0);
        SymbolTable->addItem(root, single_init);
        SymbolTable->addItem(root->son[0], single_init);
    }
    else if (root->type == VarDef_array_)
    { // 没有初始值的数组，算维度，new结点，建立映射
        // 计算维度
        vector<unsigned> dimen;
        dimen.clear();
        for (int i = 0; i < root->son[1]->son.size(); i++)
        {
            GrammaNode *constexp = root->son[1]->son[i];
            IntegerValue *val = (IntegerValue *)semantic_Exp_(constexp, 1, 0); //计算第i维的大小
            dimen.push_back(val->getValue());
        }
        //new结点
        ArrayValue *varArray = new ArrayValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);
        // set dimension设置维度信息
        varArray->setDimen(dimen);
        //建立映射，root和root->son[0]都建立
        SymbolTable->addItem(root, varArray);
        SymbolTable->addItem(root->son[0], varArray);
    }
    else if (root->type == VarDef_array_init_)
    { // 有初值的array，算维度，算初值，new结点，建立映射
        //先把结点new了
        ArrayValue *varArrayInit = new ArrayValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);

        //计算维度，和上面那个是一样的
        vector<unsigned> dimen;
        dimen.clear();
        for (int i = 0; i < root->son[1]->son.size(); i++)
        {
            GrammaNode *constexp = root->son[1]->son[i];
            IntegerValue *val = (IntegerValue *)semantic_Exp_(constexp, 1, 0); //计算第i维的大小
            dimen.push_back(val->getValue());
        }
        // set dimension设置维度信息
        varArrayInit->setDimen(dimen);

        // 算初值
        ArrayValue *initArrayValueObj = (ArrayValue *)semantic_InitVal3_(root->son[2], 0, 0, dimen);
        // 算出初值之后还得检查这个声明的维度信息和这个初值是否匹配
        // 语义检查 -------------------------- 在semantic_InitVal3_里检查了
        // set Array 设置初值
        varArrayInit->setArray(initArrayValueObj->ArrayElement);

        //建立映射，root和root->son[0]都建立
        SymbolTable->addItem(root, varArrayInit);
        SymbolTable->addItem(root->son[0], varArrayInit);
    }
    else
    { // √error
        throw SemanticError(root->lineno, "不可能-4");
    }
}

void semantic_VarDefs_(GrammaNode *root)
{
    for (auto & i : root->son)
        semantic_VarDefSon(i);
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
        {
            funcType = 0;
            semantic_FuncDef_int_(son); // 函数声明 int 无参数
        }
        else if (son->type == FuncDef_void_)
        {
            funcType = 1;
            semantic_FuncDef_void_(son); // 函数声明  void 无参数
        }
        else if (son->type == FuncDef_int_para_)
        {
            funcType = 0;
            semantic_FuncDef_int_para_(son); // 函数声明  int 有参数
        }
        else if (son->type == FuncDef_void_para_)
        {
            funcType = 1;
            semantic_FuncDef_void_para_(son); // 函数声明  void 有参数
        }
        else if (son->type == ConstDefs_)
            semantic_ConstDef_(son); // 常量定义
        else if (son->type == VarDefs_)
            semantic_VarDefs_(son); // 变量定义
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

void printFuncInfo(int type, FunctionValue *FV)
{
    cout << "line " << FV->lineno << "\tGNType: " << type << "\t函数名称：" << FV->VName
         << "\t作用域：" << FV->var_scope << "\t返回类型：" << FV->getResult() << "\t参数个数：" << FV->getParamCnt() << endl;
}

void printFuncParam(vector<Value *> params)
{
    for (int i = 0; i < params.size(); i++)
    {
        cout << "\t参数名：" << params[i]->VName << "\tscope:" << params[i]->var_scope << endl;
    }
}

void printVector(vector<int> v)
{
    cout << " -->初值：";
    for (int i : v)
    {
        cout << i << " ";
    }
    cout << endl;
}
void printVector(vector<unsigned> v)
{
    cout << " -->维度：";
    for (unsigned int i : v)
    {
        cout << i << " ";
    }
    cout << endl;
}

void show_SymbleTable(idTable_struct *SymbolTable)
{
    // 一长串，with info not likely to be used
    int count = 0;
    cout << "\nSymbolTable指针地址：" << SymbolTable << " 符号表大小：" << SymbolTable->table.size() << endl;
    for (auto & iter : SymbolTable->table)
    {
        if(iter.first == NULL)continue;
        cout << "GNType: " << iter.first->type << "\tscope:\t" << iter.first->var_scope
             << "\tGN Name: " << iter.first->str << "\t\tlineNumber:" << iter.first->lineno << endl;
    }
    cout << endl;
#if DEBUG_ON
    dbg("SymbolTable(partly):");               
#endif

    for (auto & iter : SymbolTable->table)
    {
        if(iter.first == NULL)continue;
        /// 函数声明
        if (iter.first->type == FuncDef_int_ || iter.first->type == FuncDef_void_) // 函数声明-int无参数 和 函数声明-void无参数
            printFuncInfo(iter.first->type, (FunctionValue *)iter.second);
        else if (iter.first->type == FuncDef_int_para_)
        { // 函数声明  int 有参数
            printFuncInfo(FuncDef_int_para_, (FunctionValue *)iter.second);
            printFuncParam(((FunctionValue *)iter.second)->getParams());
        }
        else if (iter.first->type == FuncDef_void_para_)
        { // 函数声明  void 有参数
            printFuncInfo(FuncDef_void_para_, (FunctionValue *)iter.second);
            printFuncParam(((FunctionValue *)iter.second)->getParams());
        }

        // 常量声明-single
        else if (iter.first->type == ConstDef_single_)
        {
            IntegerValue *IV = (IntegerValue *)iter.second;
            cout << "line " << IV->lineno << "\tGNType: " << iter.first->type << "\t常量single名称：" << IV->VName
                 << "\t初值：" << IV->RealValue << "\tisConst：" << IV->isConst << "\t作用域：" << IV->var_scope << endl;
        }

        // 常量声明-array
        else if (iter.first->type == ConstDef_array_)
        {
            ArrayValue *AV = (ArrayValue *)iter.second;
            cout << "line " << AV->lineno << "\tGNType: " << iter.first->type << "\t常量array名称：" << AV->VName
                 << "\tisConst：" << AV->isConst << "\t作用域：" << AV->var_scope << endl;

            printVector(AV->NumOfDimension);
            printVector(AV->ArrayElement);
        }

        // 变量声明-single-noInit 变量声明-single-Init
        else if (iter.first->type == VarDef_single_ || iter.first->type == VarDef_single_init_)
        {
            IntegerValue *IV = (IntegerValue *)iter.second;
            cout << "line " << IV->lineno << "\tGNType: " << iter.first->type << "\t变量single名称：" << IV->VName
                 << "\t初值：" << IV->RealValue << "\tisConst：" << IV->isConst << "\t作用域：" << IV->var_scope << endl;
        }

        // 变量声明-array-noInit 变量声明-array-Init
        else if (iter.first->type == VarDef_array_ || iter.first->type == VarDef_array_init_)
        {
            ArrayValue *AV = (ArrayValue *)iter.second;
            cout << "line " << AV->lineno << "\tGNType: " << iter.first->type << "\t变量array名称：" << AV->VName
                 << "\tisConst：" << AV->isConst << "\t作用域：" << AV->var_scope << endl;

            printVector(AV->NumOfDimension);
            printVector(AV->ArrayElement);
        }
    }
}