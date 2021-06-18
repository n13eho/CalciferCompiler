#include "BuildIR.h"


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
        else
        {
            FuncDefNode(DRoot->son[i],IR);
        }
    }
}

void ConstDefNode(GrammaNode* node,LinearIR *IR)
{
    //节点先递归得到右值
    for(int i=0;i<node->son.size();i++)
    {
        GrammaNode* p_node = node->son[i];
        if(ConstDef_array_ == p_node->type)
        {
            //左值
            Value* VL=nullptr;
            //左值需要符号表提供一个find

            //右值
            Value* VR=nullptr;
            //递归第三个孩子，即初值
            if(p_node->son.size() == 3)
            {
                VR = InitValNode(p_node->son[2],IR);
                if(VR == nullptr)
                {
                    //填充0
                }
                else
                {
                    //复杂情况仍需讨论
                    //赋值四元式
                    Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
                    ins_new->addOperand(VR);
                    ins_new->setResult(VL);
                    IR->InsertInstr(ins_new);
                    
                }
                //更新到符号表吗？？
            }
            else
            {
                //error
            }

        }
        else if(ConstDef_single_ == p_node->type)
        {
            //左值需要符号表提供一个find
            Value* VL=nullptr;
            
            //右值必为单值
            Value* VR=nullptr;
            //ConstDef:Ident ASSIGN InitVal
            if(p_node->son.size()==2)
            {
                VR = InitValNode(p_node->son[1],IR);
                if(VR == nullptr)
                {
                    //不符合语义约束
                    //error
                }
                else
                {
                    Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
                    ins_new->addOperand(VR);
                    ins_new->setResult(VL);
                    IR->InsertInstr(ins_new);
                }
                //更新到符号表吗？？
            }
            else
            {
                //error
            }
            
        }
        else
        {
            //error
        }
    }
}

void VarDefNode(GrammaNode* node,LinearIR *IR)
{
    for(int i=0;i<node->son.size();i++)
    {
        GrammaNode* p_node = node->son[i];
        if(VarDef_array_init_ ==  p_node->type)
        {
            //左值
            Value* VL=nullptr;
            //左值需要符号表提供一个find

            //右值
            Value* VR=nullptr;
            //递归第三个孩子，即初值
            if(p_node->son.size() == 3)
            {
                VR = InitValNode(p_node->son[2],IR);
                if(VR == nullptr)
                {
                    //int a[2] = {}
                    //值为默认？
                }
                else
                {
                    //复杂情况仍需讨论
                    //赋值四元式
                    Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
                    ins_new->addOperand(VR);
                    ins_new->setResult(VL);
                    IR->InsertInstr(ins_new);
                }
                //这里需要更新到符号表吗？？
            }
            else
            {
                //error
            }
        }
        else if(VarDef_single_init_ ==  p_node->type)
        {
            //Ident,待修改
            Value* VL=nullptr;
            //左值需要符号表提供一个find

            //右值必为单值
            Value* VR=nullptr;
            //VarDef:Ident ASSIGN InitVal
            if(node->son[i]->son.size()==2)
            {
                VR = InitValNode(node->son[i]->son[1],IR);
                Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
                ins_new->addOperand(VR);
                ins_new->setResult(VL);
                IR->InsertInstr(ins_new);
            }
            else
            {
                //1. int a={}  不符合语义约束
                //2. 其他
                //error
            }
        }
    }
}

void FuncDefNode(GrammaNode* node,LinearIR *IR)
{
    GrammaNode* block_=nullptr;
    if(FuncDef_int_ == node->type)
    {
        //INT Ident_TEMP RDBRAL_TEMP RDBRAR Block
        block_ = node->son[1];
    }
    else if(FuncDef_void_ == node->type)
    {
        //VOID Ident_TEMP RDBRAL_TEMP RDBRAR Block
        block_ = node->son[1];
    }
    else if(FuncDef_int_para_ == node->type)
    {
        //NT Ident_TEMP RDBRAL_TEMP FuncFParams RDBRAR Block
        block_ = node->son[2];
    }
    else if(FuncDef_void_para_ == node->type)
    {
        //VOID Ident_TEMP RDBRAL_TEMP FuncFParams RDBRAR Block
        block_ = node->son[2];
    }
    else
    {
        //error
    }
    if(nullptr != block_)
    {    
        //函数入口Label
        //todo

        //递归函数体
        BlockNode(block_,IR);        
    }
}

void BlockNode(GrammaNode* node,LinearIR *IR)
{
    for(int i=0;i<node->son.size();i++)
    {
        if(nullptr==node->son[i])
        {
            continue;
        }
        GrammaNode* sonnode = node->son[i];
        if(Stmt_Assign_ == sonnode->type)
        {
            AssignNode(sonnode,IR);
        }
        else if(Stmt_Exp_ == sonnode->type)
        {
            Value* useless = AddExpNode(sonnode,IR);
        }
        else if(Stmt_If_ == sonnode->type)
        {
            IfNode(sonnode,IR);
        }
        else if(Stmt_IfElse_ == sonnode->type)
        {
            IfElseNode(sonnode,IR);
        }
        else if(Stmt_While_ == sonnode->type)
        {
            WhileNode(sonnode,IR);
        }
        else if(Stmt_Return_ == sonnode->type)
        {
            //带返回值
            ReturnValueNode(sonnode,IR);
        }
        else if(BREAK_ == sonnode->type)
        {
            //todo
        }
        else if(CONTINUE_ == sonnode->type)
        {
            //todo
        }
        else if(RETURN_ == sonnode->type)
        {
            //todo
        }
        else if(Block_ == sonnode->type)
        {
            BlockNode(sonnode,IR);
        }
        else
        {
            //Decl
            if(ConstDefs_ == sonnode->type)
            {
                ConstDefNode(sonnode,IR);
            }
            else if(VarDefs_ == sonnode->type)
            {
                VarDefNode(sonnode,IR);
            }
        }
        
    }
}

void AssignNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        Value* LV=nullptr;
        if(Ident_ == node->son[0]->type)
        {
            //左值，单变量
            //符号表查找
        }
        else if(LVal_Array_ == node->son[0]->type)
        {
            //左值，访问数组
            LV =  LValArrayNode(node->son[0],IR);
        }
        else
        {
            //error
        }
        Value* RV = AddExpNode(node->son[1],IR);
        Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
        ins_new->addOperand(RV);
        ins_new->setResult(LV);
        IR->InsertInstr(ins_new);
    }
    else
    {
        //error
    }
}

void IfNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        CondNode(node->son[0],IR);
        //插入分支指令,判断，跳转
        BlockNode(node->son[1],IR);
    }
    else
    {
        //error
    }
}
void IfElseNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 3)
    {
        CondNode(node->son[0],IR);
        //插入分支指令,判断，跳转
        BlockNode(node->son[1],IR);
        //插入分支指令,跳转
        BlockNode(node->son[2],IR);
    }
    else
    {
        //error
    }
}
void WhileNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        CondNode(node->son[0],IR);
        //插入分支指令,判断，跳转
        BlockNode(node->son[1],IR);
    }
    else
    {
        //error
    }
}
void ReturnNode(GrammaNode* node,LinearIR *IR)
{

}
void BreakNode(GrammaNode* node,LinearIR *IR){}
void ContinueNode(GrammaNode* node,LinearIR *IR){}
void ReturnValueNode(GrammaNode* node,LinearIR *IR){}
void CondNode(GrammaNode* node,LinearIR *IR){}

Value* InitValNode(GrammaNode* node,LinearIR *IR)
{
    if(InitVal_EXP == node->type)
    {//表达式,son个数为1
        Value* ret=nullptr;
        if(node->son.size() == 1)
        {
            ret = AddExpNode(node->son[0],IR);
        }
        else
        {
            //error
        }
    }
    else if(InitVal_NULL == node->type)
    {//空{}
        return nullptr;
    }
    else if(InitVal_ == node->type)
    {//多个初值
        if(node->son.size()==1)
        {
            //InitVals_
            GrammaNode* p_node = node->son[0];
            //临时变量需要一个全局变量记录对应序号
            ArrayValue* ret= new ArrayValue("t1",p_node->lineno,p_node->var_scope);
            for(int i=0;i<p_node->son.size();i++)
            {
                Value* arrayV = InitValNode(p_node->son[i],IR);
                //ret 插入arrayV
            }
            return ret;
        }
        else
        {
            //error
        }
        
    }
}

Value* AddExpNode(GrammaNode* node,LinearIR *IR)
{
    if(AddExp_Add_ == node->type)
    {
        //arg1 + arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = AddExpNode(node->son[0],IR);
            Value* arg2 = MulExpNode(node->son[1],IR);
            Value* ret = new IntegerValue("t3",node->lineno,node->var_scope);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Add,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
    }
    else if(AddExp_Sub_ == node->type)
    {
        //ret = arg1 - arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = AddExpNode(node->son[0],IR);
            Value* arg2 = MulExpNode(node->son[1],IR);
            Value* ret = new IntegerValue("t3",node->lineno,node->var_scope);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Sub,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
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
        //ret = arg1 * arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = MulExpNode(node->son[0],IR);
            Value* arg2 = UnaryExpNode(node->son[1],IR);
            //临时变量名待改
            Value* ret = new IntegerValue("t3",node->lineno,node->var_scope);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Mul,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
    }
    else if(MulExp_Div_ == node->type)
    {
        //ret = arg1 / arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = MulExpNode(node->son[0],IR);
            Value* arg2 = UnaryExpNode(node->son[1],IR);
            //临时变量名待改
            Value* ret = new IntegerValue("t3",node->lineno,node->var_scope);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Div,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
    }
    else if(MulExp_Mod_ == node->type)
    {
        //ret = arg1 % arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = MulExpNode(node->son[0],IR);
            Value* arg2 = UnaryExpNode(node->son[1],IR);
            //临时变量名待改
            Value* ret = new IntegerValue("t3",node->lineno,node->var_scope);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Mod,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
        
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
        if(node->son.size() == 2)
        {
            //有实参的函数调用
            FunctionValue* called=nullptr;//调用符号表查找
            //根据函数返回值，若为int，建立返回值
            Value* ret=nullptr;
            int para_num = node->son[1]->son.size();
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Call,para_num+1);
            ins_new->addOperand(called);
            ins_new->setResult(ret);
            for(int i=0;i<para_num;i++)
            {
                //这里需要确认，实参进入的顺序
                ins_new->addOperand(AddExpNode(node->son[1]->son[i],IR));
            }
            IR->InsertInstr(ins_new);
            return ret;
        }
        else if(node->son.size() == 1)
        {
            //无实参的函数调用
            FunctionValue* called=nullptr;
            //根据函数返回值，若为int，建立返回值
            Value* ret=nullptr;
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Call,1);
            ins_new->addOperand(called);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
        }
    }
    else if(UnaryExp_ == node->type)
    {
        if(node->son.size() == 2)
        {
            //UnaryPos等
            Value* arg1 = UnaryExpNode(node->son[1],IR);
            Value* ret = nullptr;
            Instruction* ins_new = nullptr;
            if(ADD_ == node->son[0]->type)
            {
                ret = new IntegerValue("t3",node->lineno,node->var_scope);
                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryPos,1);
                ins_new->addOperand(arg1);
                ins_new->setResult(ret);
                IR->InsertInstr(ins_new);
                return ret;
            }
            else if(SUB_ == node->son[0]->type)
            {
                ret = new IntegerValue("t3",node->lineno,node->var_scope);
                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryNeg,1);
                ins_new->addOperand(arg1);
                ins_new->setResult(ret);
                IR->InsertInstr(ins_new);
                return ret;
            }
            else if(NOT_ == node->son[0]->type)
            {
                //boolvalue?
                ret = new Value("t3",node->lineno,node->var_scope);
                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryNot,1);
                ins_new->addOperand(arg1);
                ins_new->setResult(ret);
                IR->InsertInstr(ins_new);
                return ret;
            }
            else
            {
                //error
                return  nullptr;
            }
        }
        else
        {
            //error
            return  nullptr;
        }
    }
    else
    {//PrimaryExp
        return PrimaryExpNode(node,IR);
    }
}

Value* PrimaryExpNode(GrammaNode* node,LinearIR *IR)
{
    if(Ident_ == node->type)
    {
        //左值，单变量
        //符号表查找
    }
    else if(LVal_Array_ == node->type)
    {
        //左值，访问数组
        return LValArrayNode(node,IR);
    }
    else if(IntConst_O_ == node->type || IntConst_D_ == node->type || IntConst_H_ == node->type)
    {
        //立即数
        //符号表查表
    }
    else
    {
        return AddExpNode(node,IR);
    }
}

Value* LValArrayNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        //数组
        ArrayValue* lval = nullptr;//通过利用第一个孩子查符号表得到
        //索引
        Value* index = nullptr;
        //Exps_
        GrammaNode* p_node = node->son[1];
        //前一维度单个索引
        Value* pre = nullptr;
        for(int i=0;i<p_node->son.size();i++)
        {
            if(0 == i)
            {
                pre = AddExpNode(p_node->son[0],IR);
            }
            else
            {
                //前一个维度长度
                Value* pre_dimen = nullptr;//待修改
                //前一维度索引的积
                Value* arg3=nullptr;
                
                //计算上一维度索引积
                Instruction* ins_mul = new Instruction(IR->getInstCnt(),Instruction::Mul,2);//这里后期考虑muladd指令优化
                ins_mul->addOperand(pre_dimen);
                ins_mul->addOperand(pre);
                ins_mul->setResult(arg3);
                IR->InsertInstr(ins_mul);
                //累加
                Instruction* ins_add = new Instruction(IR->getInstCnt(),Instruction::Add,2);
                ins_add->addOperand(arg3);
                ins_add->addOperand(index);
                ins_add->setResult(index);
                IR->InsertInstr(ins_add);
                
                //当前维度索引
                Value* arg2=AddExpNode(p_node->son[i],IR);
                pre = arg2;
            }
        }
        if(pre!=nullptr)
        {
            Instruction* ins_add = new Instruction(IR->getInstCnt(),Instruction::Add,2);
            ins_add->addOperand(pre);
            ins_add->addOperand(index);
            ins_add->setResult(index);
            IR->InsertInstr(ins_add);
        }
        //数组访问
        //todo

    }
    else
    {
        //error
        return nullptr;
    }
}
