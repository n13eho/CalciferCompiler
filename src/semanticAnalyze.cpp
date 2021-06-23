#include "semanticAnalyze.h" //语义检查
#include "sysy_node.hpp"
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
IntegerValue* semantic_Exp_(GrammaNode *root, int needConst,int needCond);
IntegerValue* semantic_LVal_Array_(GrammaNode* root, int needConst,int needCod);
IntegerValue* semantic_PrimaryExp_(GrammaNode* root, int needConst,int needCod);
IntegerValue* semantic_EqExp_(GrammaNode* root);
void semantic_ConstDef_(GrammaNode* root);
void semantic_VarDefs_(GrammaNode* root);
Value* semantic_InitVal3_(GrammaNode* root, int isConst, int dimen=0, vector<unsigned> dimen_std={0});

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

IntegerValue* semantic_LVal_(GrammaNode* root)
{
    if(root->type == LVal_Array_)return semantic_LVal_Array_(root,-1,0);//-1表示必须不是常量！！！error1
    else 
    {
        return semantic_PrimaryExp_(root,-1,0);//error2,必须不是常量
    }

}

IntegerValue* semantic_RelExp_(GrammaNode* root)
{
    if(root->type == RelExp_BG_||root->type == RelExp_BQ_ || root->type == RelExp_LQ_ || root->type == RelExp_LT_)
    {
        IntegerValue* rel = semantic_EqExp_(root->son[0]);
        IntegerValue* add = semantic_RelExp_(root->son[1]);
        IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,0);
        if(root->type == RelExp_BG_)ret->RealValue = (rel->RealValue > add->RealValue); 
        else if(root->type == RelExp_BQ_)ret->RealValue = (rel->RealValue >= add->RealValue); 
        else if(root->type == RelExp_LQ_)ret->RealValue = (rel->RealValue <= add->RealValue); 
        else if(root->type == RelExp_LT_)ret->RealValue = (rel->RealValue < add->RealValue); 
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else{ return semantic_Exp_(root,0,1);}
}

IntegerValue* semantic_EqExp_(GrammaNode* root)
{
    if(root->type == EqExp_EQ_||root->type == EqExp_NEQ_)
    {
        IntegerValue* eq = semantic_EqExp_(root->son[0]);
        IntegerValue* rel = semantic_RelExp_(root->son[1]);
        IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,0);
        if(root->type == EqExp_NEQ_)ret->RealValue = (eq->RealValue != rel->RealValue); 
        else if(root->type == EqExp_EQ_)ret->RealValue = (eq->RealValue == rel->RealValue); 
        SymbolTable->addItem(root, ret);
        return ret;
    }
    else{ return semantic_RelExp_(root);}
}

IntegerValue* semantic_AndExp_(GrammaNode* root)
{
    IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,0);
    ret->RealValue =1;
    for(int i=0;i<root->son.size();i++)
    {
        IntegerValue* tem =semantic_EqExp_(root->son[i]);
        ret->RealValue=ret->RealValue && tem->RealValue;
    }
    SymbolTable->addItem(root,ret);
    return ret;
}

IntegerValue* semantic_LOrExp_(GrammaNode* root)
{
    IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,0);
    ret->RealValue =1;
    for(int i=0;i<root->son.size();i++)
    {
        IntegerValue* tem =semantic_AndExp_(root->son[i]);
        ret->RealValue=ret->RealValue || tem->RealValue;
    }
    SymbolTable->addItem(root,ret);
    return ret;
}

void semantic_cond_(GrammaNode* root)
{
    IntegerValue* temp = semantic_LOrExp_(root->son[0]);
    SymbolTable->addItem(root->son[0],temp);
}

void semantic_stmt_(GrammaNode* root)
{
    if(root->type == Stmt_Assign_)
    {
        IntegerValue* zuo = semantic_LVal_(root);
        IntegerValue* you = semantic_Exp_(root,0,0);
        SymbolTable->addItem(root->son[0],zuo);
        IntegerValue* tem = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,you->RealValue,0);
        SymbolTable->addItem(root,tem);
    }
    else if(root->type == Stmt_Exp_)
    {
        semantic_Exp_(root->son[0],0,0);
    }
    else if(root->type == Stmt_If_)
    {
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
    }
    else if(root->type == Stmt_IfElse_)
    {
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
        semantic_stmt_(root->son[1]);
    }
    else if(root->type == Stmt_While_)
    {
        semantic_cond_(root->son[0]);
        semantic_stmt_(root->son[1]);
    }
    else if(root->type == Stmt_Return_)
    {
        semantic_Exp_(root->son[0],0,0);
    }
    else
    {
        //error3
        //break,return,continue;
        //这里需要循环语义检查！
    }
}

void semantic_Block(GrammaNode* root)
{
    for(int i=0;i<root->son.size();i++)
    {
        if(root->type == ConstDefs_)semantic_ConstDef_(root);
        else if(root->type == VarDefs_)semantic_VarDefs_(root);
        else semantic_stmt_(root);
    }
}

void semantic_FuncDef_int_(GrammaNode *root)
{                                                                                                    //如果他是一个int返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                        //建立SymbolTable映射
    SymbolTable->addItem(root, item); // 他自己也要，不然找不到
    semantic_Block(root->son[1]);                                                                  //去遍历block
}

void semantic_FuncDef_void_(GrammaNode *root)
{                                                                                                    //如果他是一个void返回值函数且无形参数
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, 0, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                        //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    semantic_Block(root->son[1]);                                                                  //去遍历block
}

IntegerValue* semantic_LVal_Array_(GrammaNode* root, int needConst,int needCond)
{
    // 找到声明地方的原数组
    GrammaNode* temp = idList[make_pair(root->son[0]->str,root->son[0]->var_scope)]; // 从idList找原来的书上的结点
    // 检查一下是不是arrayvlaue
    ArrayValue* val =(ArrayValue*)SymbolTable->askItem(temp);
    // 建立映射
    SymbolTable->addItem(root, val);  
    // SymbolTable->addItem(root->son[0], val);

    // 求索引
    vector<int> indexVector;
    int dimensionSize = 1, index = 0;
    indexVector.clear();
    for(int i=0; i<root->son[1]->son.size(); i++)
    {
        indexVector.push_back(semantic_Exp_(root->son[1]->son[i], needConst,needCond)->RealValue);
        dimensionSize *= val->NumOfDimension[i];
    }
    for(int i = 0; i< indexVector.size(); i++)
    {
        dimensionSize /= val->NumOfDimension[i];
        index += indexVector[i] * dimensionSize;
    }
    int indexVal = val->ArrayElement[index];
    IntegerValue* ret = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,indexVal,val->isConst);
    // 建立映射
    SymbolTable->addItem(root, ret);

    return ret;
}

IntegerValue* semantic_PrimaryExp_(GrammaNode* root, int needConst,int needCond)
{
    // 情况3：IntConst
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
    // 情况2.2 Ident
    else if(root->type == Ident_)
    {
        GrammaNode* init = idList[make_pair(root->str,root->var_scope)];
        IntegerValue* temp = (IntegerValue*)SymbolTable->askItem(init);
        if(needConst == 1 && temp->isConst != 1){
            //error4
            // 该左值->Ident：如果传入参数needConst为1的话，这个Ident也必须为常量，否则报错
            //----------------语义检查【1】----------------
            return NULL;
            
        }
        else
        {
            SymbolTable->addItem(root,temp);
            return temp;
        }
    }
    else if(root->type == LVal_Array_)
    {
        return semantic_LVal_Array_(root, needConst,needCond);
    }
    else
    {
        return semantic_Exp_(root, needConst,needCond);
    }
}

IntegerValue* semantic_UnaryExp_(GrammaNode* root, int needConst,int needCond)
{
    if(UnaryExp_func_ == root->type)
    {
        GrammaNode* tempGn = idList[make_pair(root->son[0]->str,root->son[0]->var_scope)]; // 从idList找原来的书上的结点
        FunctionValue* val =(FunctionValue*)SymbolTable->askItem(tempGn);
        // 函数调用语义检查 error5

        //语义检查没问题就映射
        SymbolTable->addItem(root->son[0],val);

        // 这里好像不能return一个IntegerValue了，还是会warning，先warning住吧。随便返回一个临时变量，初始值为0
        IntegerValue* lsbl = new IntegerValue(name+to_string(cnt++), root->lineno, root->var_scope, 0);
        SymbolTable->addItem(root, lsbl);
        return lsbl;
    }
    else if(UnaryExp_ == root->type)
    {
        IntegerValue* sonval = semantic_UnaryExp_(root->son[1],needConst,needCond);
        if(needConst == 1 && sonval->isConst == 0){;}//error6
        
        IntegerValue* tem = new IntegerValue(name+to_string(cnt++),root->lineno,root->son[1]->var_scope,sonval->isConst);
        
        if(root->son[0]->str == "+")
            tem->RealValue = sonval->RealValue;
        else if(root->son[0]->str == "-")
            tem->RealValue = -sonval->RealValue;
        else if(root->son[0]->str == "!"&& needCond == 1)//可能需要判断这里能否取非（语义检查）
            tem->RealValue = !sonval->RealValue;
        else {
            //error7
        }
        
        SymbolTable->addItem(root,tem);
        return tem;
    }
    else
    {
        return semantic_PrimaryExp_(root, needConst,needCond);
    }
}

IntegerValue* semantic_MulExp_(GrammaNode *root, int needConst,int needCond)
{ //这里是MulExp
    if(root->type != MulExp_Mul_ && root->type != MulExp_Div_ && root->type != MulExp_Mod_)
    {
        return semantic_UnaryExp_(root, needConst,needCond);
    }
    else
    {
        IntegerValue* mul = semantic_MulExp_(root->son[0],needConst,needCond);
        IntegerValue* unary = semantic_UnaryExp_(root->son[1],needConst,needCond);
        int thisconst = (mul->isConst>0) && (unary->isConst>0);
        if(thisconst == 0 && needConst == 1)
        {
            //error8;
        }
        IntegerValue* temp = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,thisconst);

        //这里同样需要赋初始值
        if(root->type == MulExp_Mul_)
            temp->RealValue = mul->RealValue * unary->RealValue;
        else if(root->type == MulExp_Div_)
            temp->RealValue = mul->RealValue / unary->RealValue;
        else if(root->type == MulExp_Mod_)
            temp->RealValue = mul->RealValue % unary->RealValue;

        SymbolTable->addItem(root,temp);
        return temp;
    }    
}

IntegerValue* semantic_Exp_(GrammaNode *root, int needConst,int needCond)
{ //这里可以做语义检查：其值必须是常量，needConst为真的话就表明这里必须都是常量，不能是变量 
// 这里本质是addexp
// 来源可以是 InitVal_Exp->son[i] ConstExps->son[i]
    if(root->type != AddExp_Add_ && root->type != AddExp_Sub_)
    {// 对应一个没有孩子的 
        return semantic_MulExp_(root, needConst,needCond);
    }
    else
    {
        IntegerValue* add = semantic_Exp_(root->son[0],needConst,needCond);
        IntegerValue* mul = semantic_MulExp_(root->son[1],needConst,needCond);
        int thisconst = (add->isConst>0) && (mul->isConst>0); // 必须确保两个两的常量状态相与 和 当前needConst一致 否则报错
        if(thisconst == 0 && needConst == 1)
        {
            //error9;
        }
        IntegerValue* temp = new IntegerValue(name+to_string(cnt++),root->lineno,root->var_scope,thisconst);
        // 把两个儿子的计算结果求出来
        temp->RealValue = (root->type == AddExp_Add_) ? (add->RealValue + mul->RealValue) : (add->RealValue - mul->RealValue);

        // 建立映射
        SymbolTable->addItem(root,temp);
        return temp;
    }
}

Value *semantic_Func_FparamSon(GrammaNode *root)
{// 处理三种不同的函数参数声明里面的参数：int、一维度的array、多维度array
    if (root->type == FuncFParam_single_)
    {
        IntegerValue *item = new IntegerValue(root->son[0]->str, root->lineno, root->son[0]->var_scope,0);
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
            IntegerValue *temp = (IntegerValue *)semantic_Exp_(root->son[3]->son[i], 1,0); //！！这里必须返回常量
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
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, howManySon, 1); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                 //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semantic_Block(root->son[2]); //去遍历block
}

void semantic_FuncDef_void_para_(GrammaNode *root)
{ //如果他是一个void返回值函数且有形参
    int howManySon = root->son[1]->son.size();
    FunctionValue *item = new FunctionValue(root->son[0]->str, root->lineno, root->son[0]->var_scope, howManySon, 0); // build the value table of funcdef_int
    SymbolTable->addItem(root->son[0], item);                                                                 //建立SymbolTable映射
    SymbolTable->addItem(root, item);
    // 创建参数列表
    item->setParam(semantic_Func_Fparam(root->son[1]));
    semantic_Block(root->son[2]); //去遍历block
}

ArrayValue* semantic_initVal_Son(GrammaNode* root, int isConst, int dimen=0, vector<unsigned> dimen_std={0})
{
    int base=0,batchsize,batchnum=dimen_std.size()-1,tot = 1;
    ArrayValue* ret = new ArrayValue(name+to_string(cnt++),root->lineno,root->var_scope,isConst);
    batchsize = dimen_std[batchnum];
    for(auto i : dimen_std)tot*=i;
    int soni = 0;
    for(soni=0;soni<root->son.size();soni++)
    {
        if(root->son[soni]->type == InitVal_EXP)break;
        else
        {
            vector<unsigned> new_dim;
            new_dim.assign(dimen_std.begin()+1,dimen_std.end());//新维度减少到0 error
            ArrayValue* val =(ArrayValue* )semantic_InitVal3_(root->son[soni],isConst,0,new_dim);
            ret->ArrayElement.insert(ret->ArrayElement.end(),val->ArrayElement.begin(),val->ArrayElement.end());
            base+=tot/dimen_std[0];
        }
    }
    int batchi = 0;
    for(;soni<root->son.size();soni++)
    {
        if(root->son[soni]->type ==InitVal_EXP )
        {
            IntegerValue* val = (IntegerValue*)semantic_InitVal3_(root->son[soni], isConst, 0, dimen_std);
            batchi++;batchi%=batchsize;base++;
            ret->ArrayElement.push_back(val->RealValue);
        }
        else
        {
            ArrayValue* val =(ArrayValue* )semantic_InitVal3_(root->son[soni], isConst, 0, dimen_std);
            while(val->ArrayElement[val->ArrayElement.size()-1]==0)val->ArrayElement.pop_back();
            if(val->ArrayElement.size()+batchi>batchsize)
            {
                //error;
            }
            ret->ArrayElement.insert(ret->ArrayElement.end(),val->ArrayElement.begin(),val->ArrayElement.end());
        }
    }
    while(base<tot){ret->ArrayElement.push_back(0);base++;}//here we padding with zero
    SymbolTable->addItem(root,ret);
    return ret;
}

Value* semantic_InitVal3_(GrammaNode* root, int isConst, int dimen, vector<unsigned> dimen_std)
{// 三种常量初值：InitVal_EXP InitVal_NULL InitVal_
    
    if(root->type == InitVal_EXP)
    {
        return semantic_Exp_(root->son[0], 1,0);
    }
    else if( root->type == InitVal_NULL)
    {
        int x=1;
        for(int i=dimen; i<dimen_std.size(); i++) x *= dimen_std[i];
        vector<int> valzero(x, 0); //初值全设为0
        ArrayValue* ret = semantic_initVal_Son(root->son[0], isConst, dimen, dimen_std);
        SymbolTable->addItem(root,ret);
        return ret;
    }
    else if( root->type == InitVal_)
    {//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@该怎么解决呢
        if(dimen >= dimen_std.size())
        {//----------语义检查：维度匹配-----
            //error10;
            return NULL;
        }
        ArrayValue* ret = semantic_initVal_Son(root->son[0], isConst, dimen, dimen_std);
        SymbolTable->addItem(root,ret);
        return ret;
    }
    else
    {
        return NULL;//error
    }
}

void semantic_ConstDefSon(GrammaNode* root)
{// 只有两种情况
    if(root->type == ConstDef_single_)
    {//第一种情况：const int a = 0;
        if(root->son[1]->type != InitVal_EXP)
        {// 只可能是InitVal_EXP
            ;//error
        }
        // 要的到初值
        IntegerValue* initVal = (IntegerValue*)semantic_InitVal3_(root->son[1], 1);//OOP
        IntegerValue* tem = new IntegerValue(root->son[0]->str,root->lineno,root->var_scope,initVal->getValue(),1);
        SymbolTable->addItem(root,tem);
        SymbolTable->addItem(root->son[0],tem);

    }
    else if(root->type == ConstDef_array_)
    {// 第二种情况：const int d[x[0]][4%4][5*6] = {};
        if(root->son[2]->type == InitVal_EXP)
        {// 这里是因为，他的第三个孩子（初值）只有两种情况：InitVal_NULL（空值）和InitVal（复杂的情况）
            ;//error
        }

        // 计算维度
        vector<unsigned> dimen;
        dimen.clear();
        for(int i=0;i<root->son[1]->son.size();i++)
        {
            GrammaNode* constexp = root->son[1]->son[i];
            IntegerValue* val = (IntegerValue*)semantic_Exp_(constexp,1,0);//计算第i维的大小
            dimen.push_back(val->getValue());
        }

        // 计算初值
        ConstArrayValue* initVal = (ConstArrayValue*)semantic_InitVal3_(root->son[2], 1, 0, dimen);//calc initval
        //TODO:语义检查：维度和初值是否匹配
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

void semantic_VarDefSon(GrammaNode* root)
{// 有四种情况：VarDef_array_ VarDef_array_init_ VarDef_single_ VarDef_single_init_
    if(root->type == VarDef_single_)
    {// 单值变量，无初始参数（默认都为0）
        //只需要new结点，建立映射即可
        IntegerValue* single = new IntegerValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);
        //两个映射都建
        SymbolTable->addItem(root, single);
        SymbolTable->addItem(root->son[0], single);
    }
    else if(root->type == VarDef_single_init_)
    {// 单值变量，有初始参数
        //先算出初值 initValue
        IntegerValue* initValueObj = (IntegerValue*)semantic_InitVal3_(root->son[2], 0);
        int initValue = initValueObj->RealValue;
        //new出新的结点
        IntegerValue* single_init = new IntegerValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, initValue, 0);
    }
    else if(root->type == VarDef_array_)
    {// 没有初始值的数组，算维度，new结点，建立映射
        // 计算维度
        vector<unsigned> dimen;
        dimen.clear();
        for(int i=0;i<root->son[1]->son.size();i++)
        {
            GrammaNode* constexp = root->son[1]->son[i];
            IntegerValue* val = (IntegerValue*)semantic_Exp_(constexp,1,0);//计算第i维的大小
            dimen.push_back(val->getValue());
        }
        //new结点
        ArrayValue* varArray = new ArrayValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);
        // set dimension设置维度信息
        varArray->setDimen(dimen);
        //建立映射，root和root->son[0]都建立
        SymbolTable->addItem(root, varArray);
        SymbolTable->addItem(root->son[0], varArray);
        
    }
    else if(root->type == VarDef_array_init_)
    {// 有初值的array，算维度，算初值，new结点，建立映射
        //先把结点new了
        ArrayValue* varArrayInit = new ArrayValue(root->son[0]->str, root->son[0]->lineno, root->son[0]->var_scope, 0);
        
        //计算维度，和上面那个是一样的
        vector<unsigned> dimen;
        dimen.clear();
        for(int i=0;i<root->son[1]->son.size();i++)
        {
            GrammaNode* constexp = root->son[1]->son[i];
            IntegerValue* val = (IntegerValue*)semantic_Exp_(constexp,1,0);//计算第i维的大小
            dimen.push_back(val->getValue());
        }
        // set dimension设置维度信息
        varArrayInit->setDimen(dimen);

        // 算初值
        ArrayValue* initArrayValueObj = (ArrayValue*)semantic_InitVal3_(root->son[2], 0, 0, dimen);
        // TODO:算出初值之后还得检查这个声明的维度信息和这个初值是否匹配
        // 语义检查 -------------------------- error
        // set Array 设置初值
        varArrayInit->setArray(initArrayValueObj->ArrayElement);

        //建立映射，root和root->son[0]都建立
        SymbolTable->addItem(root, varArrayInit);
        SymbolTable->addItem(root->son[0], varArrayInit);
    }
    else
    {
        ;//error
    }
}

void semantic_VarDefs_(GrammaNode* root)
{
    for(int i=0;i<root->son.size();i++)semantic_VarDefSon(root->son[i]);
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
            semantic_FuncDef_int_(son); // 函数声明 int 无参数
        else if (son->type == FuncDef_void_)
            semantic_FuncDef_void_(son); // 函数声明  void 无参数
        else if (son->type == FuncDef_int_para_)
            semantic_FuncDef_int_para_(son); // 函数声明  int 有参数
        else if (son->type == FuncDef_void_para_)
            semantic_FuncDef_void_para_(son); // 函数声明  void 有参数
        else if (son->type == ConstDefs_)
            semantic_ConstDef_(son); // 常量定义
        // else if (son->type == VarDefs_)
        //     semantic_VarDefs_(son); // 常量定义
        
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

void printFuncInfo(int type, FunctionValue* FV)
{
    cout << "GrammaNode Type: " << type  << "\t函数名称：" << FV->VName \
        << "\t作用域：" << FV->var_scope << "\t返回类型：" << FV->getResult() << "\t参数个数：" << FV->getParamCnt() << endl;
}

void printFuncParam(vector<Value *> params)
{
    for(int i=0; i<params.size(); i++)
    {
        cout << "参数名：" << params[i]->VName <<"\tscope:" <<  params[i]->var_scope << endl;
    }
}

void showSymbleTable(idTable_struct* SymbolTable)
{
    cout << "SymbolTable指针地址：" << SymbolTable << " 符号表大小：" <<  SymbolTable->table.size() << endl;
    for(auto iter = SymbolTable->table.begin(); iter != SymbolTable->table.end(); iter++)
    {
        cout << "GN Type: " << iter->first->type << "\tscope:\t" << iter->first->var_scope \
        << "\tGN Name: " << iter->first->str << "\t\tlineNumber:" << iter->first->lineno  << endl;
    }
    cout<<endl;
    for(auto iter = SymbolTable->table.begin(); iter != SymbolTable->table.end(); iter++)
    {
        /// 函数声明
        if(iter->first->type == FuncDef_int_ || iter->first->type == FuncDef_void_)// 函数声明-int无参数 和 函数声明-void无参数
            printFuncInfo(iter->first->type, (FunctionValue*)iter->second);
        else if(iter->first->type == FuncDef_int_para_)
        {// 函数声明  int 有参数
            printFuncInfo(FuncDef_int_para_, (FunctionValue*)iter->second);
            printFuncParam(((FunctionValue*)iter->second)->getParams());
        }
        else if(iter->first->type == FuncDef_void_para_)
        {// 函数声明  void 有参数
            printFuncInfo(FuncDef_void_para_, (FunctionValue*)iter->second);
            printFuncParam(((FunctionValue*)iter->second)->getParams());
        }

        /// 常量声明


        /// 变量声明
    }
}