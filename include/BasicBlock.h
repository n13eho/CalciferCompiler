#include "Value.h"
//基本块
class BasicBlock
{
    public:
    enum BlockType {
    Basic,
    If,
    While,
    };
    BasicBlock(BasicBlock::BlockType t){bType = t;}
    void Addins(int id){InstrList.push_back(id);}
    void AddSucc(BasicBlock* b){succBlock.push_back(b);}
    void AddPion(BasicBlock* b){pioneerBlock.push_back(b);}
    void AddDom(BasicBlock* b){domBlock.push_back(b);}

    void setParnt(BasicBlock* p){parent_ = p;}
    //获取该基本块的首指令
    int getFirstIns()
    {
        if(0!=InstrList.size())
        {
            return InstrList[0];
        }
        else
        {
            return -1;
        }
    }

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

    std::vector<int> InstrList;
    //后继基本块
    std::vector<BasicBlock*> succBlock;
    //前驱基本块
    std::vector<BasicBlock*> pioneerBlock;
    //属于的函数体
    BasicBlock* parent_;
    //函数所控制的基本块
    std::vector<BasicBlock*> domBlock;
    //基本块类型
    BlockType bType;
};