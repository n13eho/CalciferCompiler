#pragma once
#include <iostream>
#include "Value.h"
#include<list>
//基本块
class BasicBlock{
public:
    enum BlockType {
    Basic,
    If,
    While,
    //用于部分死代码删除
    Break,
    Continue,
    IfNext
    };

    BasicBlock(BasicBlock::BlockType t){bType = t;}

    void setFuncV(FunctionValue* f){FuncV = f;BlockName = f->VName;}
    void Addins(int id){InstrList.push_back(id);}

    //this作为前驱、succ作为后继
    void Link(BasicBlock* succ)
    {
        for(auto bb:this->succBlock)
        {
            if(bb == succ)
            {
                return;
            }
        }
        // std::cout<<this->BlockName<<" link with "<<succ->BlockName<<std::endl;
        this->succBlock.push_back(succ);
        succ->pioneerBlock.push_back(this);
    }
    void AddDom(BasicBlock* b){domBlock.push_back(b);}

    void setParnt(BasicBlock* p){parent_ = p;}

    //获取该基本块的首指令
    int getFirstIns()
    {
        if(0!=InstrList.size())
        {
            return *(InstrList.begin());
        }
        else
        {
            return -1;
        }
    }

    //获取该基本块的末尾指令
    int getLastIns()
    {
        if(0!=InstrList.size())
        {
            return InstrList.back();
        }
        else
        {
            return -1;
        }
    }
    
    //获取函数基本块的第一个基本块
    BasicBlock* getFirstB()
    {
        if(0 != domBlock.size())
        {
            return domBlock[0];
        }
        else
        {
            return nullptr;
        }
    }

    FunctionValue* getFuncV(){return FuncV;}

    std::list<int> InstrList;
    // std::vector<int> ;
    //后继基本块
    std::vector<BasicBlock*> succBlock;
    //前驱基本块
    std::vector<BasicBlock*> pioneerBlock;
    //属于的函数体
    BasicBlock* parent_=nullptr;
    //函数所控制的基本块
    std::vector<BasicBlock*> domBlock;
    //基本块类型
    BlockType bType;
    //条件嵌套时，上一层的if的next
    BasicBlock* LastIfNext;
    //表示函数顶层基本块，被调用情况
    int called = 0;

    //对应符号表中的函数
    FunctionValue* FuncV;
    //用于可视化基本块关系
    std::string BlockName = "basic";
};

