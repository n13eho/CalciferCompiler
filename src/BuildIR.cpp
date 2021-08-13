#include "../include/BuildIR.h"
#include "../include/debug.h"
#include "../include/semanticAnalyze.h"
#include <stack>

//决定数组是否用memset的比例
#define ArrayPercent 20
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
int given_value = 0;
std::vector<unsigned> array_dimen;
int dimen_dpeth;
//记录条件语句的两种跳转位置
stack<BasicBlock*> CaseTBlocks;
stack<BasicBlock*> CaseFBlocks;
//记录当前条件是逻辑或、与
vector<int> CondLogi;
//当前与或的条件个数
vector<int> CondCnt;
//条件嵌套
stack<BasicBlock*> IfNextBlocks;

map<BasicBlock*,int> visited;
int funCNext = 0;
//记录条件比较轨迹,当上一个是数值比较时,当前的比较不需要跳转
stack<int> cmp_no_jmp;
//记录表达式是否作为函数实参
stack<int> funcCall_param;
int func_param_address = 0;


BasicBlock* GetPresentBlock(BasicBlock* funcP,BasicBlock::BlockType t)
{
    bbNow = CreateBlock(t);
    bbNow->BlockName = "basic";
    //若当前函数已有基本块，更新前驱后继
    if(0 != funcP->domBlock.size())
    {
        if(!funCNext)
        {
            funcP->domBlock.back()->Link(bbNow);
        }
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
    space->isTemp = 1;
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

#ifdef DEBUG_ON
    std::cout << "start VisitAST and CFG" << std::endl;
#endif

   
    
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
    visited.clear();
    for(auto gb:IR->Blocks)
        fixIfNext(IR,gb,0);
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
            given_value = 0;
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
        
                for(auto vv:array_init)
                {
//                    dbg(((IntegerValue*)vv)->getValue());
                }

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
                        int memset_flag = 0;
                        if(given_value*ArrayPercent <= total)
                        {
                            //用memset
                            memset_flag = 1;
                            IntegerValue* const00 = new IntegerValue("const0",node->lineno,node->var_scope,0,1);
                            IntegerValue* arraysize = new IntegerValue("ArraySize",node->lineno,node->var_scope,total*4,1);
                            const00->isTemp = 1;
                            arraysize->isTemp = 1;
                            FunctionValue* funcMemset = new FunctionValue("memset",node->lineno,node->var_scope,3,0);
                            std::vector<Value*> op = {funcMemset,VL,const00,arraysize};//调用的函数value、数组首地址、0、memset数组的大小
                            CreateIns(node,IR,Instruction::Call,4,op,nullptr);
                        }
                        for(int j=0;j<array_init.size();j++)
                        {
                            if(memset_flag && array_init[j]->getName() == "const0")
                                continue;
                            IntegerValue* index = new IntegerValue("index",node->lineno,node->var_scope,j,1);
                            index->isTemp = 1;
                            std::vector<Value*> op = {VL,index,array_init[j]};
#ifdef DEBUG_ON
                            cout<<"store "<<array_init[j]->getName()<<" to index "<<j<<endl;
               
#endif
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
#ifdef DEBUG_ON
               std::cout<<"VarDef_single's children num is "<<p_node->son.size()<<std::endl;
#endif
                
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
            else
            {
                //是否是全局变量数组
                if(VL->getType() == 2)
                {
                    int total = 1;
                    if(VarDef_array_ == p_node->type)
                    {
                        for(int j = 0;j<((ArrayValue*)VL)->NumOfDimension.size();j++)
                        {
                            total*=((ArrayValue*)VL)->NumOfDimension[j];
                        }
                    }
                    IntegerValue* const0_ = new IntegerValue("const0",node->lineno,node->var_scope,0,1);
                    const0_->isTemp = 1;
                    vector<Value*> chuzhi;
                    while(total--)
                    {
                        chuzhi.push_back(const0_);
                    }
                    ((ArrayValue*)VL)->ArrayInitList.assign(chuzhi.begin(),chuzhi.end());
                }
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
            LV = SymbolTable->askItem(node->son[0]->son[0]);
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
        

        //条件成立后转移的基本块
        BasicBlock* caseT = new BasicBlock(BasicBlock::Basic);
        caseT->BlockName = "ifTrue";
        //if下一条转移的基本块
        BasicBlock* next = new BasicBlock(BasicBlock::Basic);
        next->BlockName = "ifNext";
        //条件所在基本块建立与caseT、next的联系
        // cout<<"cond :bbNow "<<bbNow<<bbNow->BlockName<<endl;
        // bbNow->Link(caseT);
        // bbNow->Link(next);

        caseT->setParnt(FuncN);
        next->setParnt(FuncN);
        FuncN->AddDom(caseT);
        FuncN->AddDom(next);    

        CaseTBlocks.push(caseT);
        CaseFBlocks.push(next);
        IfNextBlocks.push(next);

        CondNode(node->son[0],IR);

        //条件不成立跳转指令
        Instruction* ins_jmp = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_jmp);
        bbNow->Addins(ins_jmp->getId());
        ins_jmp->setParent(bbNow);
        ins_jmp->setJmpDestBlock(next);
        // ins_jmp->jmpDestBlock = next;

        bbNow = caseT;
        StmtNode(node->son[1],IR);
        //此时的bbNow不一定是caseT

        if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() != Instruction::Jmp)
        {
            bbNow->Link(next);
            Instruction* ins_jmp2 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            IR->InsertInstr(ins_jmp2);
            bbNow->Addins(ins_jmp2->getId());
            // ins_jmp2->jmpDestBlock = next;
            ins_jmp2->setParent(bbNow);
            ins_jmp2->setJmpDestBlock(next);
        }
        else if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() == Instruction::Jmp)
        {

        }
        else
        {
            bbNow->Link(next);
            bbNow->LastIfNext = next;
        }
        // cout<<"case T :bbNow "<<bbNow<<bbNow->BlockName<<endl;
        
        bbNow = next;
        bbNow->bType = BasicBlock::IfNext;
        IfNextBlocks.pop();
        if(IfNextBlocks.empty())
        {
            //若前面无嵌套，并且最后ifnext也是空，则加入return
            bbNow->LastIfNext = nullptr;
        }
        else
        {
            bbNow->LastIfNext = IfNextBlocks.top();
        }

        CaseFBlocks.pop();
        CaseTBlocks.pop();

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
        // bbNow->Link(caseT);
        // bbNow->Link(caseF);

        CaseTBlocks.push(caseT);
        CaseFBlocks.push(caseF);
        IfNextBlocks.push(next);
        CondNode(node->son[0],IR);
        //条件成立，跳转至caseT
        // Instruction* ins_br1 = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
        // IR->InsertInstr(ins_br1);
        // bbNow->Addins(ins_br1->getId());
        // ins_br1->setParent(bbNow); 
        // ins_br1->jmpDestBlock = caseT;

        //条件不成立，跳转至caseF
        Instruction* ins_br2 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_br2);
        bbNow->Addins(ins_br2->getId());
        ins_br2->setParent(bbNow);
        ins_br2->setJmpDestBlock(caseF);
        // ins_br2->jmpDestBlock = caseF;

        

        //T
        bbNow = caseT;
        StmtNode(node->son[1],IR);        
        
        //T跳转至next
        if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() != Instruction::Jmp)
        {
            bbNow->Link(next);
            //块非空，且最后一条不是jmp
            Instruction* ins_br3 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            IR->InsertInstr(ins_br3);
            bbNow->Addins(ins_br3->getId());
            ins_br3->setParent(bbNow);
            // ins_br3->jmpDestBlock = next;
            ins_br3->setJmpDestBlock(next);
        }
        else if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() == Instruction::Jmp)
        {
            //块非空，最后一条是jmp
        }
        else
        {
            //块空或者
            bbNow->Link(next);
            bbNow->LastIfNext = next;
        }
        
        
        //F
        bbNow = caseF;
        StmtNode(node->son[2],IR);
        //此时bbNow不一定是caseF
        
        //F跳转至next
        if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() != Instruction::Jmp)
        {
            bbNow->Link(next);
            Instruction* ins_br4 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            IR->InsertInstr(ins_br4);
            bbNow->Addins(ins_br4->getId());
            ins_br4->setParent(bbNow);
            // ins_br4->jmpDestBlock = next;
            ins_br4->setJmpDestBlock(next);
        }
        else if(bbNow->getLastIns()>0 && IR->getIns(bbNow->getLastIns())->getOpType() == Instruction::Jmp)
        {
            //块非空，最后一条是jmp
        }
        else
        {
            //块空
            bbNow->Link(next);
            bbNow->LastIfNext = next;
        }
        bbNow = next;
        bbNow->bType = BasicBlock::IfNext;
        IfNextBlocks.pop();
        if(IfNextBlocks.empty())
        {
            //若前面无嵌套，并且最后ifnext也是空，则加入return
            bbNow->LastIfNext = nullptr;
        }
        else
        {
            bbNow->LastIfNext = IfNextBlocks.top();
        }

        CaseFBlocks.pop();
        CaseTBlocks.pop();

        if(next->pioneerBlock.size() == 0)
        {
            DeleteBlockWithNoPio(next,IR);
            next = nullptr;
        }

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
            Instruction* jmpIns = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            // jmpIns->jmpDestBlock = condBlock;
            IR->InsertInstr(jmpIns);
            bbNow->Addins(jmpIns->getId());
            jmpIns->setParent(bbNow);
            jmpIns->setJmpDestBlock(condBlock);

            bbNow = condBlock;
        }
        BasicBlock* whileHead = bbNow;
        // dbg("while block",bbNow);
        BasicBlock* caseT = new BasicBlock(BasicBlock::Basic);
        caseT->BlockName = "whileTrue";
        //while body下一个基本块
        BasicBlock* next = new BasicBlock(BasicBlock::Basic);
        next->BlockName = "IfNext";
        LoopNext.push(make_pair(bbNow,next));

        CaseTBlocks.push(caseT);
        CaseFBlocks.push(next);
        IfNextBlocks.push(next);
        
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
        // caseT->Link(bbNow);


        //条件不成立，跳转至next,该指令属于bbNow
        Instruction* ins_br = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
        IR->InsertInstr(ins_br);
        // ins_br->jmpDestBlock = next;
        
        bbNow->Addins(ins_br->getId());
        ins_br->setParent(bbNow);
        ins_br->setJmpDestBlock(next);
        
        int condInsId = bbNow->getFirstIns();
        
        //T
        bbNow = caseT;
        StmtNode(node->son[1],IR);
        //dbg("while case T link with while head",bbNow,bbNow->BlockName,whileHead,whileHead->BlockName);
        if(bbNow->pioneerBlock.size() != 0)
        {
            bbNow->Link(whileHead);
            //插入跳转到cond语句的跳转语句
            Instruction* ins_br3 = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            IntegerValue* jmpIns = new IntegerValue("jmpaddress",node->lineno,node->var_scope,condInsId,1);
            jmpIns->isTemp = 1;
            // ins_br3->setResult(jmpIns);
            IR->InsertInstr(ins_br3);
            // ins_br3->jmpDestBlock = whileHead;

            bbNow->Addins(ins_br3->getId());
            ins_br3->setParent(bbNow);
            ins_br3->setJmpDestBlock(whileHead);
        }
        else
        {
            if(bbNow->pioneerBlock.size() == 0)
            {
                DeleteBlockWithNoPio(bbNow,IR);
                bbNow = nullptr;
            }
        }       

        bbNow = next;
        bbNow->bType = BasicBlock::IfNext;
        IfNextBlocks.pop();
        if(IfNextBlocks.empty())
        {
            //若前面无嵌套，并且最后ifnext也是空，则加入return
            bbNow->LastIfNext = nullptr;
        }
        else
        {
            bbNow->LastIfNext = IfNextBlocks.top();  
        }
        LoopNext.pop();
        CaseTBlocks.pop();
        CaseFBlocks.pop();
        
        

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
    // BasicBlock* breakB = CreateBlock(BasicBlock::Break);
    // breakB->BlockName = "break";
    // FuncN->AddDom(breakB);
    // breakB->setParnt(FuncN);
    
    // bbNow->Link(breakB);
    


    //根据语义信息，break一定出现在while中
    Instruction* ins_bk = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);

    //operand todo
    bbNow->Addins(ins_bk->getId());
    ins_bk->setParent(bbNow);
    IR->InsertInstr(ins_bk);

    if(!LoopNext.empty())
    {
        BasicBlock* next = LoopNext.top().second;
        // ins_bk->jmpDestBlock = next;
        ins_bk->setJmpDestBlock(next);
        //next->Addins(ins_bk->getId());
        bbNow->Link(next);
        bbNow = bbNow;
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
    
    // BasicBlock* continueB = CreateBlock(BasicBlock::Continue);
    // continueB->BlockName = "continue";
    // FuncN->AddDom(continueB);
    // continueB->setParnt(FuncN);

    // bbNow->Link(continueB);

    Instruction* ins_jmp = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
    //operand todo
    IR->InsertInstr(ins_jmp);
    //continueB change to bbNow
    bbNow->Addins(ins_jmp->getId());
    ins_jmp->setParent(bbNow);
    if(!LoopNext.empty())
    {
        BasicBlock* whileB = LoopNext.top().first;
        bbNow->Link(whileB);
        // ins_jmp->jmpDestBlock = whileB;
        ins_jmp->setJmpDestBlock(whileB);
        bbNow = bbNow;
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


    /*
    当LOrExp孩子数
    =1时
        当LAnd孩子数
        =1时：a
        >1时:  a&&b
    >1时
        当LAnd孩子数
        =1时: a|| c
        >1时:a||b&&c

    */
}

void LOrExpNode(GrammaNode* node,LinearIR *IR)
{
    CondLogi.push_back(Instruction::LogicOr);
    CondCnt.push_back(node->son.size());
//    cout<<"LOrExpNode cond cnt:"<<node->son.size()<<endl;
    if(node->son.size() == 1)
    {
        cmp_no_jmp.push(0);
        Value* Condi = LAndExpNode(node->son[0],IR);   
        cmp_no_jmp.pop();
    }
    else
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

        for(int i=0;i<node->son.size();i++)
        {
            //当有'与'条件在'或'条件前，短路需要创建新基本块，如 a&&b&&c || d
            if(i!=node->son.size()-1)
            {
                BasicBlock* nextOrCond = new BasicBlock(BasicBlock::If);
                nextOrCond->BlockName = "condOr";
                FuncN->AddDom(nextOrCond);
                nextOrCond->setParnt(FuncN);
                CaseFBlocks.push(nextOrCond);
                cmp_no_jmp.push(0);
                Value* Condi = LAndExpNode(node->son[i],IR);
                cmp_no_jmp.pop();
                if(!CaseTBlocks.empty())
                    bbNow->Link(CaseTBlocks.top());
                bbNow->Link(nextOrCond);
                CaseFBlocks.pop();
                Instruction* jmpIns = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
                // jmpIns->jmpDestBlock = nextOrCond;
                IR->InsertInstr(jmpIns);
                bbNow->Addins(jmpIns->getId());
                jmpIns->setParent(bbNow);
                jmpIns->setJmpDestBlock(nextOrCond);
                bbNow = nextOrCond;
            }
            else
            {
                Value* Condi = LAndExpNode(node->son[i],IR);
            }
        }
    }
    
    if(nullptr == FuncN && 0 == global)
    {
        return ;
    }
    //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
    if(nullptr == bbNow)
    {
        bbNow = GetPresentBlock(FuncN,BasicBlock::Basic);
    }

    CondLogi.pop_back();
    CondCnt.pop_back();
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
    CondLogi.push_back(Instruction::LogicAnd);
    IntegerValue* ret = new IntegerValue("and_res",node->lineno,node->var_scope,0);
    // Value* ret = new Value("tr",node->lineno,node->var_scope);
    ret->isTemp = 1;
    CondCnt.push_back(node->son.size());
//    cout<<"LAndExpNode cond cnt:"<<node->son.size()<<endl;
    if(node->son.size() == 1)
    {
        cmp_no_jmp.push(0);
        ret = (IntegerValue*)EqExpNode(node->son[0],IR);
        cmp_no_jmp.pop();
        // dbg(node->son[0]->type);
        if(EqExp_EQ_ != node->son[0]->type && EqExp_NEQ_ != node->son[0]->type &&
            RelExp_LT_ != node->son[0]->type && RelExp_BG_ != node->son[0]->type &&
            RelExp_LQ_ != node->son[0]->type && RelExp_BQ_!= node->son[0]->type)
        {
            /*
            
        if(Ident_ == node->son[0]->type || AddExp_Add_ == node->son[0]->type ||
            AddExp_Sub_ == node->son[0]->type || MulExp_Mul_ == node->son[0]->type ||
            MulExp_Div_ == node->son[0]->type || MulExp_Mod_ == node->son[0]->type||
            UnaryExp_ == node->son[0]->type||UnaryExp_func_ == node->son[0]->type||
            LVal_ == node->son[0]->type||LVal_Array_ == node->son[0]->type)
            
            */
            // dbg(node->son[0]->str);
            Value* VL = ret;
            IntegerValue* RL = new IntegerValue("const0",node->son[0]->lineno,node->son[0]->var_scope,0,1);
            RL->isTemp = 1;
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
            IntegerValue* Result = new IntegerValue("res",node->lineno,node->var_scope,0);
            // Value* Result = new Value("res",node->lineno,node->var_scope);
            Result->isTemp = 1;
            Instruction* ins_neq = new Instruction(IR->getInstCnt(),Instruction::ArithNeq,2);
            ins_neq->addOperand(VL);
            ins_neq->addOperand(RL);
            ins_neq->setResult(Result);
            IR->InsertInstr(ins_neq);
            bbNow->Addins(ins_neq->getId());
            ins_neq->setParent(bbNow);
            //notequal 0 true jump
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            // bbNow->Link(CaseTBlocks.top());

            // Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            // if(CaseFBlocks.empty())
            // {
            //     dbg("CaseFBLock empty!");
            // }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            // IR->InsertInstr(FJ);
            // bbNow->Addins(FJ->getId());
            // FJ->setParent(bbNow);
        }
    }
    else
    {
        //可以短路
        for(int i=0;i<node->son.size();i++)
        {
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
            BasicBlock* nextOrCond = nullptr;
            if(i!=node->son.size()-1)
            {
                // dbg("create下一个condblock");
                nextOrCond = new BasicBlock(BasicBlock::If);
                nextOrCond->BlockName = "condOr";
                FuncN->AddDom(nextOrCond);
                nextOrCond->setParnt(FuncN);
                CaseTBlocks.push(nextOrCond);
            }
            
            Value* Condi = EqExpNode(node->son[i],IR);
            if(EqExp_EQ_ != node->son[i]->type && EqExp_NEQ_ != node->son[i]->type &&
            RelExp_LT_ != node->son[i]->type && RelExp_BG_ != node->son[i]->type &&
            RelExp_LQ_ != node->son[i]->type && RelExp_BQ_!= node->son[i]->type)
            {                
                
                /*
                if(Ident_ == node->son[i]->type || AddExp_Add_ == node->son[i]->type ||
            AddExp_Sub_ == node->son[i]->type || MulExp_Mul_ == node->son[i]->type ||
            MulExp_Div_ == node->son[i]->type || MulExp_Mod_ == node->son[i]->type||
            UnaryExp_ == node->son[i]->type||UnaryExp_func_ == node->son[i]->type||
            LVal_ == node->son[i]->type||LVal_Array_ == node->son[i]->type)
                
                */
                //与常数0比较
                IntegerValue* const0 = new IntegerValue("const0",node->son[i]->lineno,node->son[i]->var_scope,0,1);
                const0->isTemp = 1;
                vector<Value*> ops={Condi,const0};
                IntegerValue* Result = new IntegerValue("res",node->lineno,node->var_scope,0);
                // Value* Result = new Value("res",node->lineno,node->var_scope);
                Result->isTemp = 1;
                if(CondCnt.back()>1)
                    CreateIns(node,IR,Instruction::ArithEq,2,ops,Result);
                else
                    CreateIns(node,IR,Instruction::ArithNeq,2,ops,Result);
                
                Instruction* conbr = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
                // //向基本块加入指令
                bbNow->Addins(conbr->getId());
                conbr->setParent(bbNow);
                IR->InsertInstr(conbr);
                if(CondCnt.back()>1)
                {
                    if(!CaseFBlocks.empty())
                    {
                        // conbr->jmpDestBlock = CaseFBlocks.top();
                        conbr->setJmpDestBlock(CaseFBlocks.top());
                    }
                    else
                    {
                        dbg("caseFBlock empty!");
                    }
                }
                else
                {
                    if(!CaseTBlocks.empty())
                    {
                        // conbr->jmpDestBlock = CaseTBlocks.top();
                        conbr->setJmpDestBlock(CaseTBlocks.top());
                    }
                    else
                    {
                        dbg("caseTBlock empty!");
                    }
                }
                CondCnt[CondCnt.size()-1]-=1;
            }

            if(!CaseFBlocks.empty())
                bbNow->Link(CaseFBlocks.top());

            if(nextOrCond != nullptr)
            {
                // dbg("下一个condblock");
                bbNow->Link(nextOrCond);
                CaseTBlocks.pop();
                Instruction* jmpIns = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
                // jmpIns->jmpDestBlock = nextOrCond;
                IR->InsertInstr(jmpIns);
                bbNow->Addins(jmpIns->getId());
                jmpIns->setParent(bbNow);
                jmpIns->setJmpDestBlock(nextOrCond);
                // bbNow->Link(jmpIns->jmpDestBlock);
                bbNow = nextOrCond;
            }
        }
    }
    
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
    CondLogi.pop_back();
    CondCnt.pop_back();
    return ret;
}

Value* EqExpNode(GrammaNode* node,LinearIR *IR)
{
    if(EqExp_EQ_ == node->type)
    {
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(1);
        Value* VL = EqExpNode(node->son[0],IR);
        Value* RL = RelExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            Instruction* ins_neq = new Instruction(IR->getInstCnt(),Instruction::ArithNeq,2);
            ins_neq->addOperand(VL);
            ins_neq->addOperand(RL);
            ins_neq->setResult(ret);
            IR->InsertInstr(ins_neq);
            bbNow->Addins(ins_neq->getId());
            ins_neq->setParent(bbNow);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            // bbNow->Link(FJ->jmpDestBlock);
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            Instruction* ins_eq = new Instruction(IR->getInstCnt(),Instruction::ArithEq,2);
            ins_eq->addOperand(VL);
            ins_eq->addOperand(RL);
            ins_eq->setResult(ret);
            IR->InsertInstr(ins_eq);
            bbNow->Addins(ins_eq->getId());
            ins_eq->setParent(bbNow);
            if(!pre_cond){
                Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
                if(CaseTBlocks.empty())
                {
                    dbg("CaseTBlocks is empty");
                }
                // TJ->jmpDestBlock = CaseTBlocks.top();
                IR->InsertInstr(TJ);
                bbNow->Addins(TJ->getId());
                TJ->setParent(bbNow);
                TJ->setJmpDestBlock(CaseTBlocks.top());
                // bbNow->Link(TJ->jmpDestBlock);
            }
            
        }
        return ret;
    }
    else if(EqExp_NEQ_ == node->type)
    {
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(1);
        Value* VL = EqExpNode(node->son[0],IR);
        Value* RL = RelExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithEq,2,ops,ret);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            // bbNow->Link(FJ->jmpDestBlock);
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithNeq,2,ops,ret);
            if(!pre_cond){
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            // bbNow->Link(TJ->jmpDestBlock);
            }
        }
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
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(1);
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithGQ,2,ops,ret);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithLT,2,ops,ret);
            if(!pre_cond){
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            }
        }
        return ret;
    }
    else if(RelExp_BG_ == node->type)
    {
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(1);
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithLQ,2,ops,ret);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithBG,2,ops,ret);
            if(!pre_cond){
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            }
        }
        return ret;
    }
    else if(RelExp_LQ_ == node->type)
    {
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(0);
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithBG,2,ops,ret);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithLQ,2,ops,ret);
            if(!pre_cond){
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            }
        }
        return ret;
    }
    else if(RelExp_BQ_ == node->type)
    {
        int pre_cond = 0;
        if(!cmp_no_jmp.empty()){
            pre_cond = cmp_no_jmp.top();
        }
        cmp_no_jmp.push(1);
        Value* VL = RelExpNode(node->son[0],IR);
        Value* RL = AddExpNode(node->son[1],IR);
        cmp_no_jmp.pop();
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
        
        
        if(CondLogi.back() == Instruction::LogicAnd && CondCnt.back()>1)
        {
            //翻转并短路
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithLT,2,ops,ret);

            Instruction* FJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseFBlocks.empty())
            {
                dbg("CaseFBlocks is empty");
            }
            // FJ->jmpDestBlock = CaseFBlocks.top();
            IR->InsertInstr(FJ);
            bbNow->Addins(FJ->getId());
            FJ->setParent(bbNow);
            FJ->setJmpDestBlock(CaseFBlocks.top());
            CondCnt[CondCnt.size()-1]-=1;

        }
        else
        {
            vector<Value*> ops = {VL,RL};
            CreateIns(node,IR,Instruction::ArithGQ,2,ops,ret);
            if(!pre_cond){
            Instruction* TJ = new Instruction(IR->getInstCnt(),Instruction::ConBr,0);
            if(CaseTBlocks.empty())
            {
                dbg("CaseTBlocks is empty");
            }
            // TJ->jmpDestBlock = CaseTBlocks.top();
            IR->InsertInstr(TJ);
            bbNow->Addins(TJ->getId());
            TJ->setParent(bbNow);
            TJ->setJmpDestBlock(CaseTBlocks.top());
            }
        }
        return ret;
    }
    else
    {
        Value* ret = AddExpNode(node,IR);
        // dbg("rel add",node,node->str);
        // if(node->son.size()>0)
        // {
        //     dbg(node->son[0],node->son[0]->str);
        // }
        return ret;
    }
}

Value* InitValNode(GrammaNode* node,LinearIR *IR)
{
    // dbg(node->type);
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
            const0->isTemp = 1;
            array_init.push_back((Value*)const0);
//            dbg("push a zero in array_init");
        }

        IntegerValue* ret = new IntegerValue("sub matrix size",node->lineno,node->var_scope,init_list.size(),1);
        ret->isTemp = 1;
        return (Value*) ret;
    }
    else if(InitVal_ == node->type)
    {//多个初值
        if(node->son.size()==1)
        {
            //InitVals_
            GrammaNode* p_node = node->son[0];
            // dbg("p_node",p_node->type);
            IntegerValue* ret= new IntegerValue("t1",p_node->lineno,p_node->var_scope,d_len*cur_dimen,1);
            ret->isTemp = 1;
            int cnt = 0;
            // cout<<"初值son个数:"<<p_node->son.size()<<endl;
            for(int i=0;i<p_node->son.size();i++)
            {
                // dbg(p_node->son[i]->type);
                if(InitVal_EXP == p_node->son[i]->type)
                {
                    Value* ExpV = InitValNode(p_node->son[i],IR);
                    // if(((IntegerValue*)ExpV)->isConst == 1)
                    // {
                    //     cout<<"初值ExpV:"<<((IntegerValue*)ExpV)->getValue()<<endl;
                    // }
                    // init_list.push_back(ExpV);
                    array_init.push_back(ExpV);
                    // dbg("push a int to",((IntegerValue*)ExpV)->getValue()," array_init");
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
                        const0->isTemp = 1;
                        array_init.push_back((Value*)const0);
                        // dbg("push a zero in array_init");
                        // init_list.push_back((Value*)const0);
                        cnt++;
                    }
                    //???InitVals与 InitVal_区别
                    if(InitVal_ == p_node->son[i]->type)
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
                const0->isTemp = 1;
                array_init.push_back((Value*)const0);
                // dbg("push a zero in array_init");
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
            if(called->Result == 1)
                ins_new->setResult(ret);
            funcCall_param.push(1);
            for(int i=0;i<para_num;i++)
            {
                //这里需要确认，实参进入的顺序
                ins_new->addOperand(AddExpNode(node->son[1]->son[i],IR));
            }
            funcCall_param.pop();
            IR->InsertInstr(ins_new);
            bbNow->Addins(ins_new->getId());
            ins_new->setParent(bbNow);

            //调用函数对应的函数基本块
//            BasicBlock* funcCalled = IR->FuncMap[called];
//            funcCalled->called = 1;
            // cout<<"函数调用所在块:bbNow "<<bbNow<<bbNow->BlockName<<endl;
            // bbNow->Link(funcCalled);
            // funCNext = 1;
            // BasicBlock* next = GetPresentBlock(FuncN,BasicBlock::Basic);
            // cout<<"funcCalled :"<<funcCalled<<funcCalled->BlockName<<endl;
            // funcCalled->Link(next);
            // funCNext = 0;
            // bbNow = next;
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
            if(called->getName() == "starttime" || called->getName() == "stoptime")
            {
                IntegerValue* lineV = new IntegerValue("lineno",node->lineno,node->var_scope,node->lineno,1);
                lineV->isTemp = 1;
                vector<Value*> ops = {called,lineV};
                CreateIns(node,IR,Instruction::Call,2,ops,0);
            }
            else
            {
                vector<Value*> ops = {called};
                if(called->Result == 0)
                    ret = nullptr;
                CreateIns(node,IR,Instruction::Call,1,ops,ret);
                    
            }


            //调用函数对应的函数基本块
//            BasicBlock* funcCalled = IR->FuncMap[called];
//            funcCalled->called = 1;
            // bbNow->Link(funcCalled);

            //call指令下一条指令作为首指令的基本块
            // BasicBlock* next = CreateBlock(BasicBlock::Basic);
            // next->BlockName = "basic";
            // funcCalled->Link(next);

            // bbNow = next;
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
                IntegerValue* const0 = new IntegerValue("const0",node->lineno,node->var_scope,0,1);
                const0->isTemp  =1;
                ins_new = new Instruction(IR->getInstCnt(),Instruction::UnaryNot,2);
                ins_new->addOperand(arg1);
                ins_new->addOperand(const0);
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
    // cout<<"aaaaaaaaaaaaaaaaaaaaaaaa"<<node->type<<endl;
    IntegerValue* nn = (IntegerValue*)SymbolTable->askItem(node);
    if(nn->isConst == 1)
    {//是一个常数
        return (Value*)nn;
    }

    if(Ident_ == node->type)
    {
        //当Ident是函数的实参且是全局单变量（非数组）时，增加一条assign指令
        if(nn->getScope() == "1"  && nn->getType() == 1)
        {
            // dbg("aaaaaaaaaaaaaaa");
            IntegerValue* ret = new IntegerValue("syy",node->lineno,"",0);
            ret->isTemp = 1;
            vector<Value*> ops = {nn};
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
            CreateIns(node,IR,Instruction::Assign,1,ops,ret);
            return ret;
        }
        else
        {
            return nn;
        }
        
    }
    else if(LVal_Array_ == node->type)
    {
        ArrayValue* lval = (ArrayValue*)SymbolTable->askItem(node->son[0]);
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
//        dbg(((IntegerValue*)index)->isConst);
        Instruction* ins_load = nullptr;
        if(func_param_address == 1)
        {
            ins_load = new Instruction(IR->getInstCnt(),Instruction::Add,2);
            ins_load->setAddressHead(1);
        }
        else
        {
            ins_load = new Instruction(IR->getInstCnt(),Instruction::Load,2);
        }
        ins_load->addOperand(lval);
        ins_load->addOperand(index);
        ins_load->setResult(ret);
        IR->InsertInstr(ins_load);
        bbNow->Addins(ins_load->getId());
        ins_load->setParent(bbNow);
        func_param_address = 0;
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
        int size_dimen = NumOfDimension_.size();
        int real_dimen = node->son[1]->son.size();
        if(size_dimen != real_dimen)
        {
            func_param_address = 1;
        }
        //索引
        IntegerValue* index = new IntegerValue("index",node->lineno,node->var_scope,0);
        index->isTemp = 1;
//        Value* index = nullptr;
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
                if(nullptr == FuncN && 0 == global)
                {
                    return index;
                }
                //属于某个函数且该指令为首指令，新建一个基本块，并建立联系
                if(nullptr == bbNow)
                {
                    bbNow = GetPresentBlock(FuncN,BasicBlock::If);
                }
                Value* lasti = AddExpNode(p_node->son[i],IR);
                vector<Value*> ops = {lasti};
                CreateIns(node,IR,Instruction::Assign,1,ops,index);
                // dbg("index is const?",((IntegerValue*)index)->isConst);
                int dimen = NumOfDimension_[i];
                accum = new IntegerValue("dimen",node->lineno,node->var_scope,dimen,1);
                accum->isTemp = 1;
//                accum = new ImmValue("dimen",dimen);
            }
            else
            {
                int dimen = NumOfDimension_[i];
                IntegerValue* present_dimen = new IntegerValue("dimen",node->lineno,node->var_scope,dimen,1);
                present_dimen->isTemp = 1;
                //当前维度的索引
                Value* present_index = AddExpNode(p_node->son[i],IR);
                Value* arg3 = new IntegerValue("t"+std::to_string(i),node->lineno,node->var_scope,0);
                arg3->isTemp = 1;
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
                if(i>0)
                {
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
        }
        //数组访问
        //如果数组就采用一维，不嵌套，就使用上述计算过程计算得到下标，然后访问，访问单独开一个指令？

        // Instruction* ins_load = new Instruction(IR->getInstCnt(),Instruction::Load,2);
        // ins_load->addOperand(lval);
        // ins_load->addOperand(index);
        // ins_load->setResult(ret);
        // IR->InsertInstr(ins_load);
        // dbg("index is const?",((IntegerValue*)index)->isConst);
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

//delete next
void DeleteBlockWithNoPio(BasicBlock* node,LinearIR *IR)
{
    //Func中dom删除next
#ifdef DEBUG_ON
    dbg(node->BlockName,node,node->pioneerBlock.size(),node->succBlock.size());
#endif
    std::vector<BasicBlock*>::iterator it;
    for (it = FuncN->domBlock.begin(); it != FuncN->domBlock.end();)
	{
		if (*it == node)
		{
#ifdef DEBUG_ON
            dbg("funcN delete dom block");    
#endif
			it = FuncN->domBlock.erase(it++);
		}
		else
		{
			it++;
		}
	}
   //找到next的succ，递归删除
    for (it = node->succBlock.begin(); it != node->succBlock.end();)
	{//遍历node的后继*it，在*it对应块的前驱中删去node，然后将*it从node的后继中删除
        BasicBlock* tmp = *it;
#ifdef DEBUG_ON
         dbg(tmp->BlockName,tmp);       
#endif
        std::vector<BasicBlock*>::iterator it2;
        for (it2 = tmp->pioneerBlock.begin(); it2 != tmp->pioneerBlock.end();)
        {
            // dbg(*it2);
            if(*it2 == node)
            {
#ifdef DEBUG_ON
                dbg("删除当前后继块的前驱连接");      
#endif
                it2 = tmp->pioneerBlock.erase(it2++);
                break;
            }
            it2++;
        }
        if(tmp->pioneerBlock.size() == 0)
        {
#ifdef DEBUG_ON
            dbg("递归");    
#endif
            DeleteBlockWithNoPio(tmp,IR);
        }
#ifdef DEBUG_ON
        dbg("删除当前后继块的连接",*it);   
#endif  
        it = node->succBlock.erase(it++);
	}
   
}

// 打印当前IR中的所有指令
void show_IR_ins(LinearIR *IR)
{
//    cerr<<"\n\n";
//    dbg("Instruction List:");
//    cerr<<"InsID\tOP\targ1\targ2\tresult\n";
//    Instruction* presenIns;
//
//    for(int i=0; i<IR->InstList.size(); i++)
//    {
//        // 当前指令
//        presenIns = IR->InstList[i];
//        cerr << presenIns->getId() << "\t";
////        dbg(presenIns->getId());
//        cerr<< DEBUG_insOP[presenIns->getOpType()] << "\t";
////        dbg(DEBUG_insOP[presenIns->getOpType()]);
//        cerr<<presenIns->getParent()<<"\t";
////        dbg(presenIns->getParent());
//        if(presenIns->getOpType() == Instruction::Jmp|| presenIns->getOpType() == Instruction::ConBr)
//        {
//            if(nullptr != presenIns->jmpDestBlock)
//            {
//                cerr<<presenIns->jmpDestBlock->BlockName<< presenIns->jmpDestBlock->getFirstIns()<<endl;
//            }
//            // if(nullptr!=presenIns->getResult())
//                // cout<<((IntegerValue*)presenIns->getResult())->RealValue<<endl;
//            else
//                cerr<<endl;
//            continue;
//        }
//        if(presenIns->getOpType() == Instruction::Alloc)
//        {
//            std::cerr <<presenIns->getOp()[0]->VName<<" space size:"<<((IntegerValue*)(presenIns->getOp()[1]))->getValue()<<endl;
//            continue;
//        }
//        if(presenIns->getOpType() == Instruction::Store)
//        {
//            std::cerr<<presenIns->getOp()[0]->VName<<" ["<<((IntegerValue*)presenIns->getOp()[1])->getValue()<<"]: "<<(presenIns->getOp()[2])->getName()<<endl;
//            continue;
//        }
//        for(int i = 0; i < presenIns->getOp().size(); i++)
//        {
//            // std::cout << presenIns->getOp()[i]<< " \t";
//            std::cerr << presenIns->getOp()[i]->VName << "\t";
////            dbg(presenIns->getOp()[i]->VName);
//        }
//        if(presenIns->getOp().size() == 1) cerr << "\t";
//        if(presenIns->getOpType() == Instruction::InsType::Ret)
//        { // Retrun 语句没有reslut，访问空0 segmentation fault
//            cerr << endl;
//        }
//        else
//        {
////            dbg(presenIns->getId());
////            dbg(presenIns->getResult());
//            if(presenIns->getResult()!=nullptr)
//                cerr << presenIns->getResult()->VName << endl;
//            else
//                cerr<<endl;
//        }
//    }
//    cerr<<"\n\n";
    std::cout << IR;

//    for(auto i: IR->Blocks)
//        cerr<<i<<" ";
//    cerr<<"\n\n\n";
    std::cout << std::endl;
}

void fixIfNext(LinearIR *IR,BasicBlock* node,int dep)
{
    visited[node]=1;
    // cout<<node->BlockName<<" "<<node->InstrList.size()<<" "<<node->getLastIns()<<endl;
    int insId = node->getLastIns();
//    dbg(node->BlockName,node->bType,node->parent_,insId);
    if((node->bType == BasicBlock::IfNext || node->BlockName == "ifTrue" || node->BlockName == "ifFalse")&&node->parent_!=nullptr &&(insId == -1 || (IR->getIns(insId)->getOpType() != 17 && IR->getIns(insId)->getOpType() != 20)))
    {
        // dbg("kong",node->BlockName,node);
        //空基本块
        if(node->LastIfNext == nullptr)
        {
            if(insId>0)
            {
                cout<<IR->getIns(insId)->getOpType()<<endl;
            }
            Instruction* rets = new Instruction(IR->getInstCnt(),Instruction::Ret,0);
            node->Addins(rets->getId());
            rets->setParent(node);
            IR->InsertInstr(rets);
        }
        else
        {
            Instruction* jmp = new Instruction(IR->getInstCnt(),Instruction::Jmp,0);
            // jmp->jmpDestBlock = node->LastIfNext;
            node->Addins(jmp->getId());
            jmp->setParent(node);
            IR->InsertInstr(jmp);
            jmp->setJmpDestBlock(node->LastIfNext);
        }
    }
    for(auto i : node->succBlock)
     {
        if(!visited.count(i))
        {
            fixIfNext(IR,i,dep);
        }
     }
    for(auto i : node->domBlock)
    {
        if(!visited.count(i))
        {
            fixIfNext(IR,i,dep+1);
        }
    }
    // vis.clear();
}