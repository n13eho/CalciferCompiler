#include "Instruction.h"

//线性IR，存储所有四元式
class LinearIR
{
    public:
    LinearIR();

    void InsertInstr(Instruction* InsNew)
    {
        InstList.push_back(InsNew);
        InsNew->setId(InstCnt);
        InstCnt++;
    }

    int getInstCnt(){return InstCnt;}

    private:
    std::vector<Instruction*> InstList;
    int InstCnt=0;
};


