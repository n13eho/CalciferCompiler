#include "../include/BuildIR.h"
#include "../include/debug.h"
#include "../include/semanticAnalyze.h"
#include <stack>
using namespace std;

extern idTable_struct* SymbolTable;
extern BasicBlock* globalBlock;
//当前是否在全局基本块中，加入顶层所有的变量定义相关指令加
int global = 0;
//全局基本块或者当前函数内基本块
BasicBlock* bbNow = nullptr;
//当前函数基本块，用于定界
BasicBlock* FuncN = nullptr;
//若在while body中，表示while的下一个基本块
stack<pair<BasicBlock*,BasicBlock*>> LoopNext;

//用于数组初始化
std::vector<Value *> array_init;
std::vector<unsigned> array_dimen;
int dimen_dpeth;

BasicBlock* GetPresentBlock(BasicBlock* funcP,BasicBlock::BlockType t)
{
    bbNow = CreateBlock(t);
    bbNow->BlockName = "basic";
    //若当前函数已有基本块，更新前驱后继
    if(0 != funcP->domBlock.size())
    {
        funcP->domBlock.back()->Link(bbNow);
    }
    funcP->AddDom(bbNow);   
    bbNow->setParnt(funcP);
    return bbNow;
}

BasicBlock* CreateBlock(BasicBlock::BlockType t)
{
    BasicBlock* b = new BasicBlock(t);
    return b;
}

void AllocCreate(GrammaNode* node,LinearIR *IR,Value* VL,int space_size)
{
    Instruction* ins_alloc = new Instruction(IR->getInstCnt(),Instruction::Alloc,2);
    ins_alloc->addOperand(VL);
    IntegerValue* space  = new IntegerValue("space",node->lineno,node->var_scope,space_size,1);
    ins_alloc->addOperand((Value*)space);
    IR->InsertInstr(ins_alloc);

    //向基本块加入指令
    bbNow->Addins(ins_alloc->getId());

    ins_alloc->setParent(bbNow);
}

void CreateIns(GrammaNode* node,LinearIR *IR,Instruction::InsType ins_type,unsigned oprands_num,std::vector<Value*>op,Value* res)
{
    Instruction* ins = new Instruction(IR->getInstCnt(),ins_type,oprands_num);
    for(int i=0;i<op.size();i++)
    {
        ins->addOperand(op[i]);
    }
    if(nullptr!=res)
    {
        ins->setResult(res);
    }
    //向基本块加入指令
    bbNow->Addins(ins->getId());
    ins->setParent(bbNow);
    IR->InsertInstr(ins);

}

void VisitAST(GrammaNode* DRoot,LinearIR *IR)
{
    //全局基本块
    IR->AddBlock(globalBlock);
//    dbg("start VisitAST");
    
    for(int i=0;i<DRoot->son.size();i++)
    {
        if(ConstDefs_ == DRoot->son[i]->type)
        {
            // if(globalBlock == nullptr)
            // {
            //     globalBlock = new BasicBlock(BasicBlock::Basic);
            //     IR->AddBlock(globalBlock);
            // }
            bbNow = globalBlock;
            global = 1;
            ConstDefNode(DRoot->son[i],IR);
            bbNow = nullptr;
            global = 0;
        }
        else if(VarDefs_ ==  DRoot->son[i]->type)
        {
            if(globalBlock == nullptr)
            {
                //error
                // globalBlock = new BasicBlock(BasicBlock::Basic);
                // IR->AddBlock(globalBlock);
            }
            bbNow = globalBlock;
            global = 1;
            VarDefNode(DRoot->son[i],IR);
            global = 0;
            bbNow = nullptr;
        }
        else
        {
            FuncDefNode(DRoot->son[i],IR);
            bbNow = nullptr;
        }
    }
}

void ConstDefNode(GrammaNode* node,LinearIR *IR)
{
    //节点先递归得到右值
    for(int i=0;i<node->son.size();i++)
    {
        GrammaNode* p_node = node->son[i];

        Value* VL=SymbolTable->askItem(p_node->son[0]);
        
        
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(0 == global && nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }

        Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,0);
        ins_new->setResult(VL);

        //向基本块加入指令
        bbNow->Addins(ins_new->getId());
        ins_new->setParent(bbNow);

        IR->InsertInstr(ins_new);
            
        

        // if(ConstDef_array_ == p_node->type)
        // {
        //     //左值
        //     Value* VL= SymbolTable->askItem(p_node->son[0]);
            
        //     //右值
        //     Value* VR=nullptr;
        //     //递归第三个孩子，即初值
        //     if(p_node->son.size() == 3)
        //     {
        //         VR = InitValNode(p_node->son[2],IR);
        //         if(VR == nullptr)
        //         {
        //             //符号表阶段填充0
        //         }
        //         else
        //         {
        //             //赋值四元式，复杂情况仍需讨论
        //             Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
        //             ins_new->addOperand(VR);
        //             ins_new->setResult(VL);
        //             //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        //             if(0 == global && nullptr == bbNow)
        //             {
        //                 bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        //             }
        //             //向基本块加入指令
        //             bbNow->Addins(ins_new->getId());
        //             ins_new->setParent(bbNow);

        //             IR->InsertInstr(ins_new);
        //         }
        //     }
        //     else
        //     {
        //         throw BuildIRError(VL->lineno, VL->VName, "错误1");
        //         //error
        //     }

        // }
        // else if(ConstDef_single_ == p_node->type)
        // {
        //     //左值
        //     Value* VL=SymbolTable->askItem(p_node->son[0]);;
            
        //     //右值必为单值
        //     Value* VR=nullptr;
        //     //ConstDef:Ident ASSIGN InitVal
        //     if(p_node->son.size()==2)
        //     {
        //         VR = InitValNode(p_node->son[1],IR);
        //         if(VR == nullptr)
        //         {
        //             throw BuildIRError(VL->lineno, VL->VName, "错误2");
        //             //error，不符合语义约束
        //         }
        //         else
        //         {
        //             Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
        //             ins_new->addOperand(VR);
        //             ins_new->setResult(VL);
        //             //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        //             if(0 == global && nullptr == bbNow)
        //             {
        //                 bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        //             }
        //             //向基本块加入指令
        //             bbNow->Addins(ins_new->getId());
        //             ins_new->setParent(bbNow);
        //             IR->InsertInstr(ins_new);
        //         }
        //     }
        //     else
        //     {
        //         throw BuildIRError(VL->lineno, VL->VName, "错误3");
        //         //error
        //     }
            
        // }
        // else
        // {
        //     // throw BuildIRError(VL->lineno, VL->VName, "错误4");
        //     //error
        // }
    }
}

void VarDefNode(GrammaNode* node,LinearIR *IR)
{
    for(int i=0;i<node->son.size();i++)
    {
        //当前节点的第i个孩子
        GrammaNode* p_node = node->son[i];
        if(VarDef_array_init_ ==  p_node->type)
        {
            //左值
            Value* VL=SymbolTable->askItem(p_node->son[0]);
            int total = 1;
            array_init.clear();
            dimen_dpeth = 0;
            array_dimen = ((ArrayValue*)VL)->NumOfDimension;
            for(int j = 0;j<((ArrayValue*)VL)->NumOfDimension.size();j++)
            {
                total*=((ArrayValue*)VL)->NumOfDimension[j];
            }
            // cout<<"array allocate space:"<<total<<endl;

            //右值
            Value* VR=nullptr;
            //递归第三个孩子，即初值
            if(p_node->son.size() == 3)
            {
                
                VR = InitValNode(p_node->son[2],IR);
                // cout<<"finish array initvals compute"<<endl;

                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(0 == global && nullptr == bbNow)
                {
                    bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
                }
                if(0 == global)
                    AllocCreate(p_node,IR,VL,total);

                if(VR != nullptr)
                {
                    if(0 == global)
                    {
                        for(int j=0;j<array_init.size();j++)
                        {
                            IntegerValue* index = new IntegerValue("index",node->lineno,node->var_scope,j,1);
                            std::vector<Value*> op = {VL,index,array_init[j]};
                            cout<<"store "<<array_init[j]->getName()<<" to index "<<j<<endl;
                            CreateIns(node,IR,Instruction::Store,3,op,nullptr);
                        }
                    }
                    //变量数组 初始值存于该结构中，在代码生成时，直接遍历该结构
                    ((ArrayValue*)VL)->ArrayInitList.assign(array_init.begin(),array_init.end());
                    array_init.clear();
                }
                
            }
            else
            {
                //error
            }
        }
        else if(VarDef_single_init_ ==  p_node->type)
        {
            //左值
            Value* VL=SymbolTable->askItem(p_node->son[0]);

            //右值必为单值
            Value* VR=nullptr;
            //VarDef:Ident ASSIGN InitVal
            if(p_node->son.size()==3)
            {
                VR = InitValNode(p_node->son[2],IR);
                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(0 == global && nullptr == bbNow)
                {
                    // cout<<"*********"<<FuncN->BlockName<<endl;
                    bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
                }
                // cout<<"*********"<<FuncN->BlockName<<endl;
                if(0 == global)
                    AllocCreate(p_node,IR,VL,1);
                Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
                ins_new->addOperand(VR);
                ins_new->setResult(VL);
                //向基本块加入指令
                bbNow->Addins(ins_new->getId());
                // 标识该条指令所属的基本块
                ins_new->setParent(bbNow);
                // 向IR中添加这一条指令
                IR->InsertInstr(ins_new);
            }
            else
            {
                std::cout<<"VarDef_single's children num is "<<p_node->son.size()<<std::endl;
                //1. int a={}  不符合语义约束
                //2. 其他
                //error
            }
        }
        else
        {
            Value* VL=SymbolTable->askItem(p_node->son[0]);            
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(0 == global && nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            if(0 == global)
            {

                int total = 1;
                if(VarDef_array_ == p_node->type)
                {
                    for(int j = 0;j<((ArrayValue*)VL)->NumOfDimension.size();j++)
                    {
                        total*=((ArrayValue*)VL)->NumOfDimension[j];
                    }
                }
                AllocCreate(p_node,IR,VL,total);

            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,0);
            ins_new->setResult(VL);
            //向基本块加入指令
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);

            IR->InsertInstr(ins_new);
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
        BasicBlock* NewFunc = new BasicBlock(BasicBlock::Basic);
        NewFunc->BlockName = "basic";

        FunctionValue* fcNode = (FunctionValue*)SymbolTable->askItem(node);
        NewFunc->setFuncV(fcNode);
        IR->AddBlock(NewFunc);
        IR->FuncMap[(Value*)fcNode] = NewFunc;
        if(fcNode->getName() == "main")
        {
            IR->Blocks[0]->Link(NewFunc);
        }

        FuncN = NewFunc;
        bbNow = nullptr;
        //递归函数体
        BlockNode(block_,IR); 
        FuncN = nullptr;
    }
}

void BlockNode(GrammaNode* node,LinearIR *IR)
{
    for(int i=0;i<node->son.size();i++)
    {
        if(nullptr==node->son[i])
        {// 这是何故
            continue;
        }
        GrammaNode* sonnode = node->son[i];
        //Decl
        if(ConstDefs_ == sonnode->type)
        {
            ConstDefNode(sonnode,IR);
        }
        else if(VarDefs_ == sonnode->type)
        {
            VarDefNode(sonnode,IR);
        }
        else
        {
            StmtNode(sonnode,IR);
        }
    }
}

void StmtNode(GrammaNode* node,LinearIR *IR)
{
    if(Stmt_Assign_ == node->type)
    {
        AssignNode(node,IR);
    }
    else if(Stmt_Exp_ == node->type)
    {
        Value* useless = AddExpNode(node->son[0],IR);
    }
    else if(Stmt_If_ == node->type)
    {
        IfNode(node,IR);
    }
    else if(Stmt_IfElse_ == node->type)
    {
        IfElseNode(node,IR);
    }
    else if(Stmt_While_ == node->type)
    {
        WhileNode(node,IR);
    }
    else if(Stmt_Return_ == node->type)
    {
        //带返回值
        ReturnValueNode(node,IR);
    }
    else if(BREAK_ == node->type)
    {
        BreakNode(node,IR);
    }
    else if(CONTINUE_ == node->type)
    {
        ContinueNode(node,IR);
    }
    else if(RETURN_ == node->type)
    {
        ReturnNode(node,IR);
    }
    else if(Block_ == node->type)
    {
        BlockNode(node,IR);
    }
    else
    {
        //error
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
            LV = SymbolTable->askItem(node->son[0]);
            Value* RV = AddExpNode(node->son[1],IR);
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Assign,1);
            ins_new->addOperand(RV);
            ins_new->setResult(LV);

            if(nullptr == FuncN && 0 == global)
            {
                //error
                return;
            }
            //首指令，新建基本块
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            //向基本块加入指令
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);

            IR->InsertInstr(ins_new);
        }
        else if(LVal_Array_ == node->son[0]->type)
        {
            //左值
            LV = SymbolTable->askItem(node->son[0]);
            Value* index =  LValArrayNode(node->son[0],IR);
            Value* RV = AddExpNode(node->son[1],IR);
            Instruction* ins_store = new Instruction(IR->getInstCnt(),Instruction::Store,3);
            ins_store->addOperand(LV);
            ins_store->addOperand(index);
            ins_store->addOperand(RV);

            if(nullptr == FuncN && 0 == global)
            {
                //error
                return;
            }
            //首指令，新建基本块
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            //向基本块加入指令
            bbNow->Addins(ins_store->getId());
            ins_store->setParent(bbNow);

            IR->InsertInstr(ins_store);
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

void IfNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        if(nullptr == FuncN && 0 == global)
        {
            return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::If);
        }
        CondNode(node->son[0],IR);

        //条件成立后转移的基本块
        BasicBlock* caseT = new BasicBlock(BasicBlock::Basic);
        caseT->BlockName = "ifTrue";
        //if下一条转移的基本块
        BasicBlock* next = new BasicBlock(BasicBlock::Basic);
        next->BlockName = "ifNext";
        //条件所在基本块建立与caseT、next的联系
        bbNow->Link(caseT);
        bbNow->Link(next);

        caseT->setParnt(FuncN);
        next->setParnt(FuncN);
        FuncN->AddDom(caseT);
        FuncN->AddDom(next);    
        

        //条件成立跳转指令
        Instruction* ins_br = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
        IR->InsertInstr(ins_br);
        bbNow->Addins(ins_br->getId());
        ins_br->setParent(bbNow);
        ins_br->jmpDestBlock = caseT;

        //条件不成立跳转指令
        Instruction* ins_jmp = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_jmp);
        bbNow->Addins(ins_jmp->getId());
        ins_br->setParent(bbNow);
        ins_jmp->jmpDestBlock = next;

        bbNow = caseT;
        StmtNode(node->son[1],IR);
        //此时的bbNow不一定是caseT
        bbNow->Link(next);
        bbNow = next;
        //update jmp address
        //后面删除该结果value
        ins_br->setResult(new IntegerValue("jmpAddress0",node->lineno,node->var_scope,IR->getInstCnt(),1));
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
        if(nullptr == FuncN && 0 == global)
        {
            return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::If);
        }
        CondNode(node->son[0],IR);
        
        //条件成立后转移的基本块
        BasicBlock* caseT = new BasicBlock(BasicBlock::Basic);
        caseT->BlockName = "ifTrue";
        //条件不成立转移的基本块
        BasicBlock* caseF = new BasicBlock(BasicBlock::Basic);
        caseF->BlockName = "ifFalse";
        //if下一条转移的基本块
        BasicBlock* next = new BasicBlock(BasicBlock::Basic);
        next->BlockName = "ifNext";
        //更新函数控制的基本块
        FuncN->AddDom(caseT);
        FuncN->AddDom(caseF);
        FuncN->AddDom(next);

        caseT->setParnt(FuncN);
        caseF->setParnt(FuncN);
        next->setParnt(FuncN);
        //更新基本块前驱、后继信息
        bbNow->Link(caseT);
        bbNow->Link(caseF);

        //条件成立，跳转至caseT
        Instruction* ins_br1 = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
        IR->InsertInstr(ins_br1);
        bbNow->Addins(ins_br1->getId());
        ins_br1->setParent(bbNow); 
        ins_br1->jmpDestBlock = caseT;

        //条件不成立，跳转至caseF
        Instruction* ins_br2 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_br2);
        bbNow->Addins(ins_br2->getId());
        ins_br2->setParent(bbNow);
        ins_br2->jmpDestBlock = caseF;

        

        //T
        bbNow = caseT;
        StmtNode(node->son[1],IR);
        //如果此分支不存在break、continue、ret
        if(linkNext(bbNow,IR))
        {
            //此时bbNow不一定是caseT
            bbNow->Link(next);
            //T跳转至next
            Instruction* ins_br = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            IR->InsertInstr(ins_br);
            caseT->Addins(ins_br->getId());
            ins_br->setParent(caseT);
            ins_br->jmpDestBlock = next;

            cout<<"case T "<<bbNow->BlockName<<"link next"<<endl;
        }
        //后面删除
        //if条件跳转地址
        // ins_br2->setResult(new IntegerValue("jmpAddress0",node->lineno,node->var_scope,IR->getInstCnt(),1));
        // cout<<"ifelse 中if跳转地址："<<ins_br2->getResult()<<endl;

        //F
        bbNow = caseF;
        StmtNode(node->son[2],IR);
        //bbNow不一定是caseF
        bbNow->Link(next);
        //更新ins_br2参数，todo
        bbNow = next;

        //后面删除
        //update caseT最后一条无条件跳转指令的地址
        // ins_br->setResult(new IntegerValue("jmpAddress0",node->lineno,node->var_scope,IR->getInstCnt(),1));
        // cout<<"ifelse 中caseT跳转地址："<<ins_br->getResult()<<endl;
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
        if(nullptr == FuncN && 0 == global)
        {
            return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        //while的条件单独拎出来成为一个基本块
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::While);
        }
        else
        {
            BasicBlock* condBlock = new BasicBlock(BasicBlock::While);
            condBlock->BlockName = "while";
            condBlock->setParnt(FuncN);
            FuncN->AddDom(condBlock);

            bbNow->Link(condBlock);

            bbNow = condBlock;
        }
        BasicBlock* whileHead = bbNow;
        
        BasicBlock* caseT = new BasicBlock(BasicBlock::Basic);
        caseT->BlockName = "whileTrue";
        //while body下一个基本块
        BasicBlock* next = new BasicBlock(BasicBlock::Basic);
        next->BlockName = "whileFalse";
        LoopNext.push(make_pair(bbNow,next));

        CondNode(node->son[0],IR);

        //函数控制的基本块更新
        FuncN->AddDom(caseT);
        FuncN->AddDom(next);
        caseT->setParnt(FuncN);
        next->setParnt(FuncN);
        //更新前驱、后继信息
        bbNow->Link(caseT);
        bbNow->Link(next);
        //循环
        caseT->Link(bbNow);

        //条件成立，跳转至caseT，该指令属于bbNow
        Instruction* ins_br2 = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
        IR->InsertInstr(ins_br2);
        ins_br2->jmpDestBlock = caseT;
        bbNow->Addins(ins_br2->getId());
        ins_br2->setParent(bbNow);

        //条件不成立，跳转至next,该指令属于bbNow
        Instruction* ins_br = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_br);
        ins_br->jmpDestBlock = next;
        
        bbNow->Addins(ins_br->getId());
        ins_br->setParent(bbNow);

        
        int condInsId = bbNow->getFirstIns();
        
        //T
        bbNow = caseT;
        StmtNode(node->son[1],IR);

        //插入跳转到cond语句的跳转语句
        Instruction* ins_br3 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        ImmValue* jmpIns = new ImmValue("jmpaddress",condInsId);
        // ins_br3->setResult(jmpIns);
        IR->InsertInstr(ins_br3);
        ins_br3->jmpDestBlock = whileHead;

        bbNow->Addins(ins_br3->getId());
        ins_br3->setParent(bbNow);
        
        //后面删除
        //caseT body的无条件跳转指令的下一条指令就是while的条件跳转目的地址
        // ins_br->setResult(new IntegerValue("jmpAddress0",node->lineno,node->var_scope,IR->getInstCnt(),1));
        //next
        bbNow = next;
        LoopNext.pop();

    }
    else
    {
        //error
    }
}
void ReturnNode(GrammaNode* node,LinearIR *IR)
{
    if(nullptr == FuncN && 0 == global)
    {
        return ;
    }
    //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
    if(nullptr == bbNow)
    {
        bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
    }
    Instruction* ins_ret = new Instruction(IR->getInstCnt(),Instruction::Ret,0);
    IR->InsertInstr(ins_ret);
    bbNow->Addins(ins_ret->getId());
    ins_ret->setParent(bbNow);
    
}
void BreakNode(GrammaNode* node,LinearIR *IR)
{
    if(nullptr == FuncN && 0 == global)
    {
        return;
    }
    if(nullptr == bbNow)
    {
        //error
        return;
    }
    BasicBlock* breakB = CreateBlock(BasicBlock::Break);
    breakB->BlockName = "break";
    FuncN->AddDom(breakB);
    breakB->setParnt(FuncN);
    
    bbNow->Link(breakB);
    


    //根据语义信息，break一定出现在while中
    Instruction* ins_bk = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);

    //operand todo
    breakB->Addins(ins_bk->getId());
    ins_bk->setParent(breakB);
    IR->InsertInstr(ins_bk);

    if(!LoopNext.empty())
    {
        BasicBlock* next = LoopNext.top().second;
        ins_bk->jmpDestBlock = next;
        //next->Addins(ins_bk->getId());
        breakB->Link(next);
        bbNow = breakB;
    }
    
}
void ContinueNode(GrammaNode* node,LinearIR *IR)
{
    if(nullptr == FuncN && 0 == global)
    {
        return;
    }
    if(nullptr == bbNow)
    {
        //error
        return;
    }   
    
    BasicBlock* continueB = CreateBlock(BasicBlock::Continue);
    continueB->BlockName = "continue";
    FuncN->AddDom(continueB);
    continueB->setParnt(FuncN);

    bbNow->Link(continueB);

    Instruction* ins_jmp = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
    //operand todo
    IR->InsertInstr(ins_jmp);
    continueB->Addins(ins_jmp->getId());
    ins_jmp->setParent(continueB);
    if(!LoopNext.empty())
    {
        BasicBlock* whileB = LoopNext.top().first;
        continueB->Link(whileB);
        ins_jmp->jmpDestBlock = whileB;
        bbNow = continueB;
    }
    

}
void ReturnValueNode(GrammaNode* node,LinearIR *IR)
{
    if(nullptr == FuncN && 0 == global)
    {
        return ;
    }
    //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
    if(nullptr == bbNow)
    {
        bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
    }
    Value* retvalue = AddExpNode(node->son[0],IR);
    Instruction* ins_ret = new Instruction(IR->getInstCnt(),Instruction::Ret,1);
    ins_ret->addOperand(retvalue); // 把return的value放进操作数vector中
    IR->InsertInstr(ins_ret);

    bbNow->Addins(ins_ret->getId());
    ins_ret->setParent(bbNow);
}

void CondNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size()>=1)
        LOrExpNode(node->son[0],IR);
}

void LOrExpNode(GrammaNode* node,LinearIR *IR)
{
    //前一个条件value
    Value* Condpre = LAndExpNode(node->son[0],IR);
    if(node->son.size()==1)
        return;
    for(int i=1;i<node->son.size();i++)
    {
        //当前条件value
        Value* Condi = LAndExpNode(node->son[i],IR);
        //当前a or b计算结果
        Value* ret = new Value("t"+std::to_string(i),node->lineno,node->var_scope);

        if(nullptr == FuncN && 0 == global)
        {
            return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }

        Instruction* ins_or = new Instruction(IR->getInstCnt(),Instruction::LogicOr,2);
        ins_or->addOperand(Condpre);
        ins_or->addOperand(Condi);
        ins_or->setResult(ret);
        IR->InsertInstr(ins_or);
        bbNow->Addins(ins_or->getId());
        ins_or->setParent(bbNow);
        Condpre=ret;
    }
    //立即数0
    ImmValue* const0 = new ImmValue("0",0);
    Value* ret = new Value("tr",node->lineno,node->var_scope);
    if(nullptr == FuncN && 0 == global)
    {
        return ;
    }
    //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
    if(nullptr == bbNow)
    {
        bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
    }

    //条件value和立即数0比较
//    Instruction* ins_neq = new Instruction(IR->getInstCnt(),Instruction::ArithNeq,2);
//    ins_neq->addOperand(Condpre);
//    ins_neq->addOperand(const0);
//    ins_neq->setResult(ret);
//    IR->InsertInstr(ins_neq);
//
//    bbNow->Addins(ins_neq->getId());
//    ins_neq->setParent(bbNow);
    // return ret;
}

Value* LAndExpNode(GrammaNode* node,LinearIR *IR)
{
    //前一个条件value
    Value* Condpre = EqExpNode(node->son[0],IR);
    for(int i=1;i<node->son.size();i++)
    {
        //当前条件value
        Value* Condi = EqExpNode(node->son[i],IR);
        //当前a or b计算结果
        Value* ret = new Value("t"+std::to_string(i),node->lineno,node->var_scope);

        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(ret->lineno,ret->VName,"error");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }

        Instruction* ins_and = new Instruction(IR->getInstCnt(),Instruction::LogicAnd,2);
        ins_and->addOperand(Condpre);
        ins_and->addOperand(Condi);
        ins_and->setResult(ret);
        IR->InsertInstr(ins_and);
        bbNow->Addins(ins_and->getId());
        ins_and->setParent(bbNow);
        Condpre=ret;
    }
    //立即数0
    ImmValue* const0 = new ImmValue("0",0);
    Value* ret = new Value("tr",node->lineno,node->var_scope);
    if(nullptr == FuncN&& 0 == global)
    {
        throw BuildIRError(ret->lineno,ret->VName,"error");
        // return ;
    }
    //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
    if(nullptr == bbNow)
    {
        bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
    }
    //条件value和立即数0比较
//    Instruction* ins_neq = new Instruction(IR->getInstCnt(),Instruction::ArithNeq,2);
//    ins_neq->addOperand(Condpre);
//    ins_neq->addOperand(const0);
//    ins_neq->setResult(ret);
//    IR->InsertInstr(ins_neq);
//    bbNow->Addins(ins_neq->getId());
//    ins_neq->setParent(bbNow);
    return ret;
}

Value* EqExpNode(GrammaNode* node,LinearIR *IR)
{
    if(EqExp_EQ_ == node->type)
    {
        Value* VL = EqExpNode(node->son[0],IR);
        Value* RL = RelExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
        if(nullptr == FuncN&& 0 == global)
        {
            throw BuildIRError(VL->lineno, VL->VName, "错误5");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_eq = new Instruction(IR->getInstCnt(),Instruction::ArithEq,2);
        ins_eq->addOperand(VL);
        ins_eq->addOperand(RL);
        ins_eq->setResult(ret);
        IR->InsertInstr(ins_eq);
        bbNow->Addins(ins_eq->getId());
        ins_eq->setParent(bbNow);
        return ret;
    }
    else if(EqExp_NEQ_ == node->type)
    {
        Value* VL = EqExpNode(node->son[0],IR);
        Value* RL = RelExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(VL->lineno, VL->VName, "错误6");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_neq = new Instruction(IR->getInstCnt(),Instruction::ArithNeq,2);
        ins_neq->addOperand(VL);
        ins_neq->addOperand(RL);
        ins_neq->setResult(ret);
        IR->InsertInstr(ins_neq);
        bbNow->Addins(ins_neq->getId());
        ins_neq->setParent(bbNow);
        return ret;
    }
    else
    {
        return RelExpNode(node,IR);
    }
}

Value* RelExpNode(GrammaNode* node,LinearIR *IR)
{
    if(RelExp_LT_ == node->type)
    {
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(ret->lineno,ret->VName,"error");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_lt = new Instruction(IR->getInstCnt(),Instruction::ArithLT,2);
        ins_lt->addOperand(VL);
        ins_lt->addOperand(RL);
        ins_lt->setResult(ret);
        IR->InsertInstr(ins_lt);
        bbNow->Addins(ins_lt->getId());
        ins_lt->setParent(bbNow);
        return ret;
    }
    else if(RelExp_BG_ == node->type)
    {
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);// new Value("t1",node->lineno,node->var_scope);

        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(VL->lineno, VL->VName, "错误7");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_bg = new Instruction(IR->getInstCnt(),Instruction::ArithBG,2);
        ins_bg->addOperand(VL);
        ins_bg->addOperand(RL);
        ins_bg->setResult(ret);
        IR->InsertInstr(ins_bg);
        bbNow->Addins(ins_bg->getId());
        ins_bg->setParent(bbNow);
        return ret;
    }
    else if(RelExp_LQ_ == node->type)
    {
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(VL->lineno, VL->VName, "错误8");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_lq = new Instruction(IR->getInstCnt(),Instruction::ArithLQ,2);
        ins_lq->addOperand(VL);
        ins_lq->addOperand(RL);
        ins_lq->setResult(ret);
        IR->InsertInstr(ins_lq);
        bbNow->Addins(ins_lq->getId());
        ins_lq->setParent(bbNow);
        return ret;
    }
    else if(RelExp_BQ_ == node->type)
    {
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        Value* ret = SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError(VL->lineno, VL->VName, "错误9");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }
        Instruction* ins_bq = new Instruction(IR->getInstCnt(),Instruction::ArithBG,2);
        ins_bq->addOperand(VL);
        ins_bq->addOperand(RL);
        ins_bq->setResult(ret);
        IR->InsertInstr(ins_bq);
        bbNow->Addins(ins_bq->getId());
        ins_bq->setParent(bbNow);
        return ret;
    }
    else
    {
        //RelExp:AddExp
        return AddExpNode(node,IR);
        return nullptr;
    }
}

Value* InitValNode(GrammaNode* node,LinearIR *IR)
{
    if(InitVal_EXP == node->type)
    {//表达式,son个数为1
        //该表达式结果
        Value* ret=nullptr;
        if(node->son.size() == 1)
        {
            // cout<<"InitVal_EXP"<<endl;
            ret = AddExpNode(node->son[0],IR);
            // if(((IntegerValue*)ret)->isConst == 1)
            // {
            //     cout<<"计算为常数："<<((IntegerValue*)ret)->getValue()<<endl;
            // }
            return ret;
        }
        else
        {
            //error
            return nullptr;
        }
    }
    
    int cur_dimen = array_dimen[dimen_dpeth];
    int d_len = 1;
    for(int i=dimen_dpeth+1;i<array_dimen.size();i++)
    {
        d_len*=array_dimen[i];
    }
    std::vector<Value *> init_list;

    if(InitVal_NULL == node->type)
    {//空{}
        //用于 int a[5][2] = {}; 
        //填充多少个，后面再改，todo
        for(int j=0; j < d_len*cur_dimen;j++)
        {
            IntegerValue* const0 = new IntegerValue("const0",node->lineno,node->var_scope,0,1);
            array_init.push_back((Value*)const0);
        }

        IntegerValue* ret = new IntegerValue("sub matrix size",node->lineno,node->var_scope,init_list.size(),1);
        return (Value*) ret;
    }
    else if(InitVal_ == node->type)
    {//多个初值
        if(node->son.size()==1)
        {
            //InitVals_
            GrammaNode* p_node = node->son[0];
            IntegerValue* ret= new IntegerValue("t1",p_node->lineno,p_node->var_scope,d_len*cur_dimen,1);
            int cnt = 0;
            // cout<<"初值son个数:"<<p_node->son.size()<<endl;
            for(int i=0;i<p_node->son.size();i++)
            {
                if(InitVal_EXP == p_node->son[i]->type)
                {
                    
                    Value* ExpV = InitValNode(p_node->son[i],IR);
                    // if(((IntegerValue*)ExpV)->isConst == 1)
                    // {
                    //     cout<<"初值ExpV:"<<((IntegerValue*)ExpV)->getValue()<<endl;
                    // }
                    // init_list.push_back(ExpV);
                    array_init.push_back(ExpV);
                    cnt++;
                }
                else// if(InitVal_NULL == p_node->son[i]->type )
                {
                    //位置再看
                    // int pos = init_list.size();
                    // for(int j=0; j < (total_len - (pos % total_len)%total_len);j++)
                    // {
                    //     IntegerValue* const0 = new IntegerValue("const0",p_node->lineno,p_node->var_scope,0,1);
                    //     array_init.push_back((Value*)const0);
                    //     init_list.push_back((Value*)const0);
                    // }

                   //InitVal_
                    int pos = cnt;//init_list.size();
                    for(int j=0;j < (d_len - (pos % d_len)) % d_len ;j++)
                    {
                        IntegerValue* const0 = new IntegerValue("const0",p_node->lineno,p_node->var_scope,0,1);
                        array_init.push_back((Value*)const0);
                        // init_list.push_back((Value*)const0);
                        cnt++;
                    }
                    if(InitVals_ == p_node->son[i]->type)
                    {
                        dimen_dpeth++;
                        //递归
                        IntegerValue* ExpV = (IntegerValue*)InitValNode(p_node->son[i],IR);
                        //递归出来后，数值已经压入array_init，但是为保证init_List pos正确，向init_list压入同样数量的0
                        dimen_dpeth--;
                        cnt+=(ExpV->getValue());

                    }
                    
                }
            }
            // int pos = init_list.size();
            for(int j = cnt;j<d_len*cur_dimen;j++)
            {
                IntegerValue* const0 = new IntegerValue("const0",p_node->lineno,p_node->var_scope,0,1);
                array_init.push_back((Value*)const0);
            }

            return ret;
        }
        else
        {
            //error
            return nullptr;
        }
        
    }
    else
    {
        return nullptr;
    }
}

Value* AddExpNode(GrammaNode* node,LinearIR *IR)
{
    IntegerValue* nn = (IntegerValue*)SymbolTable->askItem(node);
    if(nn->isConst == 1)
    {//是一个常数
        return (Value*)nn;
    }

    if(AddExp_Add_ == node->type)
    {
        //ret = arg1 + arg2
        if(node->son.size() == 2)
        {
            //递归arg1、arg2
            Value* arg1 = AddExpNode(node->son[0],IR);
            Value* arg2 = MulExpNode(node->son[1],IR);
            //本表达式结果
            Value* ret = SymbolTable->askItem(node);//new IntegerValue("t3",node->lineno,node->var_scope,0);
            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(arg1->lineno, arg1->VName, "错误10");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Add,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
            return nullptr;
        }
    }
    else if(AddExp_Sub_ == node->type)
    {
        //ret = arg1 - arg2
        if(node->son.size() == 2)
        {
            //递归arg1、arg2
            Value* arg1 = AddExpNode(node->son[0],IR);
            Value* arg2 = MulExpNode(node->son[1],IR);
            Value* ret = SymbolTable->askItem(node);//erValue("t3",node->lineno,node->var_scope,0);

            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(arg1->lineno, arg1->VName, "错误11");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }

            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Sub,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);
            IR->InsertInstr(ins_new);
            return ret;
        }
        else
        {
            //error
            return nullptr;
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
    IntegerValue* nn = (IntegerValue*)SymbolTable->askItem(node);
    if(nn->isConst == 1)
    {//是一个常数
        return (Value*)nn;
    }
    if(MulExp_Mul_ == node->type)
    {
        //ret = arg1 * arg2
        if(node->son.size() == 2)
        {
            //递归arg1
            Value* arg1 = MulExpNode(node->son[0],IR);
            Value* arg2 = UnaryExpNode(node->son[1],IR);
            //临时变量名待改
            Value* ret = SymbolTable->askItem(node);//new IntegerValue("t3",node->lineno,node->var_scope,0);
            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(arg1->lineno, arg1->VName, "错误12");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Mul,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);
            return ret;
        }
        else
        {
            //error
            return nullptr;
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
            Value* ret = SymbolTable->askItem(node);//new IntegerValue("t3",node->lineno,node->var_scope,0);

            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(arg1->lineno, arg1->VName, "错误13");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }

            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Div,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);
            return ret;
        }
        else
        {
            //error
            return nullptr;
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
            Value* ret = SymbolTable->askItem(node);//new IntegerValue("t3",node->lineno,node->var_scope,0);
            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(arg1->lineno, arg1->VName, "错误14");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }

            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Mod,2);
            ins_new->addOperand(arg1);
            ins_new->addOperand(arg2);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);
            return ret;
        }
        else
        {
            //error
            return nullptr;
        }
        
    }
    else
    {//UnaryExp
        return UnaryExpNode(node,IR);
    }
}

Value* UnaryExpNode(GrammaNode* node,LinearIR *IR)
{
    IntegerValue* nn = (IntegerValue*)SymbolTable->askItem(node);
    if(nn->isConst == 1)
    {//是一个常数
        return (Value*)nn;
    }
    if(UnaryExp_func_ == node->type)
    {
        if(node->son.size() == 2)
        {
            //有实参的函数调用
            FunctionValue* called=(FunctionValue*)SymbolTable->askItem(node->son[0]);
            //根据函数返回值，若为int，建立返回值
            Value* ret=SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
            int para_num = node->son[1]->son.size();

            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(ret->lineno, ret->VName, "错误15");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Call,para_num+1);
            ins_new->addOperand(called);
            ins_new->setResult(ret);
            for(int i=0;i<para_num;i++)
            {
                //这里需要确认，实参进入的顺序
                ins_new->addOperand(AddExpNode(node->son[1]->son[i],IR));
            }
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);

            //调用函数对应的函数基本块
            BasicBlock* funcCalled = IR->FuncMap[called];
            bbNow->Link(funcCalled);

            BasicBlock* next = GetPresentBlock(FuncN,BasicBlock::Basic);

            funcCalled->Link(next);

            bbNow = next;
            return ret;
        }
        else if(node->son.size() == 1)
        {
            //无实参的函数调用
            FunctionValue* called=(FunctionValue*)SymbolTable->askItem(node->son[0]);
            //根据函数返回值，若为int，建立返回值
            Value* ret=SymbolTable->askItem(node);//new Value("t1",node->lineno,node->var_scope);
            if(nullptr == FuncN && 0 == global)
            {
                throw BuildIRError(ret->lineno, ret->VName, "错误16");
                // return ;
            }
            //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
            if(nullptr == bbNow)
            {
                bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
            }
            Instruction* ins_new = new Instruction(IR->getInstCnt(),Instruction::Call,1);
            
            ins_new->addOperand(called);
            ins_new->setResult(ret);
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);

            //调用函数对应的函数基本块
            BasicBlock* funcCalled = IR->FuncMap[called];
            bbNow->Link(funcCalled);

            //call指令下一条指令作为首指令的基本块
            BasicBlock* next = CreateBlock(BasicBlock::Basic);
            next->BlockName = "basic";
            funcCalled->Link(next);

            bbNow = next;
            return ret;
        }
        else
        {
            //error
            return nullptr;
        }
    }
    else if(UnaryExp_ == node->type)
    {
        if(node->son.size() == 2)
        {
            //UnaryPos等
            Value* arg1 = UnaryExpNode(node->son[1],IR);
            dbg(arg1->getName());
            Value* ret = nullptr;
            Instruction* ins_new = nullptr;
            if(ADD_ == node->son[0]->type)
            {
                //可省略
                // ret = new IntegerValue("t3",node->lineno,node->var_scope);
                // ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryPos,1);
                // ins_new->addOperand(arg1);
                // ins_new->setResult(ret);
                // IR->InsertInstr(ins_new);
                ret = arg1;
                return ret;
            }
            else if(SUB_ == node->son[0]->type)
            {
                ret = SymbolTable->askItem(node);//new IntegerValue("t3",node->lineno,node->var_scope,0);
                if(nullptr == FuncN && 0 == global)
                {
                    throw BuildIRError(node->lineno, ret->VName, "错误17");
                    // return ;
                }
                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(nullptr == bbNow)
                {
                    bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
                }
                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryNeg,1);
                ins_new->addOperand(arg1);
                ins_new->setResult(ret);
                IR->InsertInstr(ins_new);
                bbNow->Addins(ins_new->getId());
                ins_new->setParent(bbNow);
                return ret;
            }
            else if(NOT_ == node->son[0]->type)
            {
                ret = SymbolTable->askItem(node);//new Value("t3",node->lineno,node->var_scope);
                dbg(ret->getName());
                if(nullptr == FuncN && 0 == global)
                {
                    throw BuildIRError(node->lineno, ret->VName, "错误18");
                    // return ;
                }
                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(nullptr == bbNow)
                {
                    bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
                }

                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryNot,1);
                ins_new->addOperand(arg1);
                ins_new->setResult(ret);
                IR->InsertInstr(ins_new);
                bbNow->Addins(ins_new->getId());
                ins_new->setParent(bbNow);
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
    IntegerValue* nn = (IntegerValue*)SymbolTable->askItem(node);
    if(nn->isConst == 1)
    {//是一个常数
        return (Value*)nn;
    }

    if(Ident_ == node->type)
    {
        //左值
        return SymbolTable->askItem(node);
    }
    else if(LVal_Array_ == node->type)
    {
        ArrayValue* lval = (ArrayValue*)SymbolTable->askItem(node);
        Value* index = LValArrayNode(node,IR);
        Value* ret = SymbolTable->askItem(node);//new IntegerValue("tx",node->lineno,node->var_scope,0);

        if(nullptr == FuncN && 0 == global)
        {
            throw BuildIRError((int)node->lineno, (string&)ret->VName, (string&)"错误19");
            // return ;
        }
        //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
        if(nullptr == bbNow)
        {
            bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
        }

        Instruction* ins_load = new Instruction(IR->getInstCnt(),Instruction::Load,2);
        ins_load->addOperand(lval);
        ins_load->addOperand(index);
        ins_load->setResult(ret);
        IR->InsertInstr(ins_load);
        bbNow->Addins(ins_load->getId());
        ins_load->setParent(bbNow);
        return ret;
    }
    else if(IntConst_O_ == node->type || IntConst_D_ == node->type || IntConst_H_ == node->type)
    {
        return SymbolTable->askItem(node);
    }
    else
    {
        return AddExpNode(node,IR);
    }
}

//计算数组访问下标
Value* LValArrayNode(GrammaNode* node,LinearIR *IR)
{
    if(node->son.size() == 2)
    {
        //数组
        ArrayValue* lval = (ArrayValue*)SymbolTable->askItem(node->son[0]);
        std::vector<unsigned> NumOfDimension_ = lval->getDimen();
        //索引
        Value* index = nullptr;
        //Exps_节点
        GrammaNode* p_node = node->son[1];
        //维度长度累乘
        Value* accum = nullptr;
        //数组访问结果
        // Value* ret = new IntegerValue("t"+std::to_string(p_node->son.size()),node->lineno,node->var_scope);
        for(int i=p_node->son.size()-1;i>=0;i--)
        {
            if(p_node->son.size()-1 == i)
            {
                index = AddExpNode(p_node->son[i],IR);
                int dimen = NumOfDimension_[i];
                accum = new ImmValue("dimen",dimen);
            }
            else
            {
                //待修改，访问符号表,得到当前数组维度长度
                int dimen = NumOfDimension_[i];
                ImmValue* present_dimen = new ImmValue("dimen",dimen);
                //当前维度的索引
                Value* present_index = AddExpNode(p_node->son[i],IR);
                Value* arg3 = new IntegerValue("t"+std::to_string(i),node->lineno,node->var_scope,0);

                if(nullptr == FuncN && 0 == global)
                {
                    throw BuildIRError(arg3->lineno, arg3->VName, "错误20");
                    // return ;
                }
                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(nullptr == bbNow)
                {
                    bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
                }
                //上一次累乘*本维度索引
                Instruction* ins_mul = new Instruction(IR->getInstCnt(),Instruction::Mul,2);
                ins_mul->addOperand(accum);
                ins_mul->addOperand(present_index);
                ins_mul->setResult(arg3);
                IR->InsertInstr(ins_mul);
                bbNow->Addins(ins_mul->getId());
                ins_mul->setParent(bbNow);

                //累加
                Instruction* ins_add = new Instruction(IR->getInstCnt(),Instruction::Add,2);
                ins_add->addOperand(arg3);
                ins_add->addOperand(index);
                ins_add->setResult(index);
                IR->InsertInstr(ins_add);
                bbNow->Addins(ins_add->getId());
                ins_add->setParent(bbNow);

                //计算维度累乘
                Instruction* ins_mul2 = new Instruction(IR->getInstCnt(),Instruction::Mul,2);//这里后期考虑muladd指令优化
                ins_mul2->addOperand(present_dimen);
                ins_mul2->addOperand(accum);
                ins_mul2->setResult(accum);
                IR->InsertInstr(ins_mul2);
                bbNow->Addins(ins_mul2->getId());
                ins_mul2->setParent(bbNow);
            }
        }
        //数组访问
        //如果数组就采用一维，不嵌套，就使用上述计算过程计算得到下标，然后访问，访问单独开一个指令？

        // Instruction* ins_load = new Instruction(IR->getInstCnt(),Instruction::Load,2);
        // ins_load->addOperand(lval);
        // ins_load->addOperand(index);
        // ins_load->setResult(ret);
        // IR->InsertInstr(ins_load);
        return index;
    }
    else
    {
        //error
        return nullptr;
    }
}


bool linkNext(BasicBlock* node,LinearIR *IR)
{
    if(BasicBlock::Break ==node->bType||BasicBlock::Continue ==node->bType)
    {
        return false;
    }
    else
    {
        list<int>::iterator it = node->InstrList.begin();
        for(;it!=node->InstrList.end();++it)
        {
            if(IR->getIns(*it)->getOpType() ==Instruction::Ret)
            {
                return false;
            }
        }
        return true;
    }
}


// 打印当前IR中的所有指令
void show_IR_ins(LinearIR *IR)
{
    cout<<"\n\n";
    dbg("Instruction List:");
    cout<<"InsID\tOP\targ1\targ2\tresult\n";
    Instruction* presenIns;
    
    for(int i=0; i<IR->InstList.size(); i++)
    {
        // 当前指令
        presenIns = IR->InstList[i];
        cout << presenIns->getId() << "\t" << DEBUG_insOP[presenIns->getOpType()] << "\t";
        cout<<presenIns->getParent()<<"\t";
        if(presenIns->getOpType() == Instruction::Jmp|| presenIns->getOpType() == Instruction::ConBr)
        {
            if(nullptr != presenIns->jmpDestBlock)
            {
                cout<<presenIns->jmpDestBlock->BlockName<< presenIns->jmpDestBlock->getFirstIns()<<endl;
            }
            // if(nullptr!=presenIns->getResult())
                // cout<<((IntegerValue*)presenIns->getResult())->RealValue<<endl;
            else
                cout<<endl;
            continue;
        }
        if(presenIns->getOpType() == Instruction::Alloc)
        {
            std::cout <<presenIns->getOp()[0]->VName<<" space size:"<<((IntegerValue*)(presenIns->getOp()[1]))->getValue()<<endl;
            continue;
        }
        if(presenIns->getOpType() == Instruction::Store)
        {
            std::cout<<presenIns->getOp()[0]->VName<<" ["<<((IntegerValue*)presenIns->getOp()[1])->getValue()<<"]: "<<(presenIns->getOp()[2])->getName()<<endl;
            continue;
        }
        for(int i = 0; i < presenIns->getOp().size(); i++)
        {
            // std::cout << presenIns->getOp()[i]<< " \t";
            std::cout << presenIns->getOp()[i]->VName << "\t";
        }
        if(presenIns->getOp().size() == 1) cout << "\t";
        if(presenIns->getOpType() == Instruction::InsType::Ret)
        { // Retrun 语句没有reslut，访问空0 segmentation fault
            cout << endl;
        }
        else
        {
            cout << presenIns->getResult()->VName << endl;
        }
    }
    cout<<"\n\n";

    for(auto i: IR->Blocks)
        cout<<i<<" ";
    cout<<"\n\n";
}