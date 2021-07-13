/* 
delete dead code and block
1. empty
2. return
3. after break
4. after continue
*/
#include <vector>
#include <list>
#include "../include/detetedeadblock.h"

void DeleteBlock(std::vector<BasicBlock *> Blocks, int i)
{
    //删除后继里的自己
    vector<BasicBlock *>::iterator itr1 = Blocks[i]->succBlock.begin();
    while (itr1 != Blocks[i]->succBlock.end())
    {
        if (*itr1 == Blocks[i])
        {
            itr1 = Blocks.erase(itr1);
        }
        else
        {
            itr1++;
        }
    }
    //删除前驱里的自己
    vector<BasicBlock *>::iterator itr2 = Blocks[i]->pioneerBlock.begin();
    while (itr2 != Blocks[i]->pioneerBlock.end())
    {
        if (*itr2 == Blocks[i])
        {
            itr2 = Blocks.erase(itr2);
        }
        else
        {
            itr2++;
        }
    }
    //前驱连上后继
    itr1 = Blocks[i]->pioneerBlock.begin();
    while (itr1 != Blocks[i]->pioneerBlock.end())
    {
        itr2 = Blocks[i]->succBlock.begin();
        while (itr2 != Blocks[i]->succBlock.end())
        {
            (*itr1)->Link(*itr2);
            itr2++;
        }
        itr1++;
    }
    Blocks.erase(Blocks.begin() + i);
}

void Visitblock(LinearIR *IR)
{

    //判断globle是否为空
    // if (Blocks[0]->InstrList.size() == 0)
    // {
    //     DeleteBlock(Blocks, 0);
    // }

    //对函数的dom进行遍历，dom指令为空则删除dom
    for (int i = 1; i < IR->Blocks.size(); i++)
    {
        //cout << IR->Blocks[i]->BlockName << endl;
        //函数外层没有前驱
        if (IR->Blocks[i]->pioneerBlock.size() == 0)
        {
            DeleteBlock(IR->Blocks, i);
        }

        //domblock中的处理 domblock指令为空、没有前驱和后继的都删除
        for (int j = 0; j < IR->Blocks[i]->domBlock.size(); j++) //遍历所有domblock
        {
            if (IR->Blocks[i]->domBlock[j]->InstrList.size() == 0)
            {
                DeleteBlock(IR->Blocks[i]->domBlock, j);
            }

            else if (IR->Blocks[i]->domBlock[j]->succBlock.size() == 0 && IR->Blocks[i]->domBlock[j]->pioneerBlock.size() == 0) //前驱后继都为0
            {
                DeleteBlock(IR->Blocks[i]->domBlock, j);
            }

            else
            {
                if (IR->Blocks[i]->domBlock[j]->bType == BasicBlock::Break || IR->Blocks[i]->domBlock[j]->bType == BasicBlock::Continue)
                { //break 和 continue jump后的代码删除

                    for (list<int>::iterator it = IR->Blocks[i]->domBlock[j]->InstrList.begin(); it != IR->Blocks[i]->domBlock[j]->InstrList.end(); ++it)
                    {
                        if (IR->InstList[*it]->getOpType() == Instruction::Jmp && *it != IR->Blocks[i]->domBlock[j]->InstrList.back()) //找到jmp指令
                        {
                            it++;
                            while (it != IR->Blocks[i]->domBlock[j]->InstrList.end())
                            {

                                it = IR->Blocks[i]->domBlock[j]->InstrList.erase(it);
                            }
                            break;
                        }
                    }
                }
                //return 语句后的指令删除
                for (list<int>::iterator it = IR->Blocks[i]->domBlock[j]->InstrList.begin(); it != IR->Blocks[i]->domBlock[j]->InstrList.end(); ++it)
                {
                    if (IR->InstList[*it]->getOpType() == Instruction::Ret && *it != IR->Blocks[i]->domBlock[j]->InstrList.back())
                    {
                        it++;
                        cout << *it << endl;
                        while (it != IR->Blocks[i]->domBlock[j]->InstrList.end())
                        {
                            it = IR->Blocks[i]->domBlock[j]->InstrList.erase(it);
                        }
                        break;
                    }
                }
            }
        }
    }
}
