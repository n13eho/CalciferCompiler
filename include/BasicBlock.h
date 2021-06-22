// #include <vector>

// //基本块
// class BasicBlock
// {
//     public:
//     BasicBlock();

//     protected:

//     private:
//     std::vector<int> InstrList;
// };

#include <vector>

//基本块
class BasicBlock
{
private:
    int _index;
    std::string _label;

public:
    std::vector<BasicBlock *> succs;      //后继
    std::vector<BasicBlock *> preds;      //前驱
    std::vector<LinearIR *> instructions; //基本块包括的

    BasicBlock();
    void AddInstruction(LinearIR *instruction);
    static void AddLink(BasicBlock *pred, BasicBlock *succ);
    BasicBlock(int index, std::string label) : _index(index), _label(label){};

protected:
};