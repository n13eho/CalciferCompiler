#include "../include/BasicBlock.h"
#include "../include/BuildIR.h"

using namespace std;

void BasicBlock::AddInstruction(LinearIR *instruction)
{
    instructions.push_back(instruction);
}

void BasicBlock::AddLink(BasicBlock *pred, BasicBlock *succ)
{
    if (std::find(succ->preds.begin(), succ->preds.end(), pred) == succ->preds.end())
    {
        succ->preds.push_back(pred);
    }

    if (std::find(pred->succs.begin(), pred->succs.end(), succ) == pred->succs.end())
    {
        pred->succs.push_back(succ);
    }
}