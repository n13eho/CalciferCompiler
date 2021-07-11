/* 
delete dead code and block
1. empty
2. return
3. after break
4. after continue
*/
#include <vector>
#include <list>
#include "../include/BuildIR.h"
#include "../include/BasicBlock.h"

void DeleteBlock(std::vector<BasicBlock *> Blocks, int i)
{ //删除该基本块后继基本块的前驱（自己） 并删除该基本块
    vector<BasicBlock *>::iterator itr = Blocks[i]->succBlock.begin();
    while (itr != Blocks[i]->succBlock.end())
    {
        if (itr == Blocks[i])
        {
            itr = Blocks.erase(itr);
        }
        else
        {
            itr++;
        }
    }
    vector<BasicBlock *>::iterator itr1 = Blocks[i]->pioneerBlock.begin();
    while (itr1 != Blocks[i]->pioneerBlock.end())
    {
        itr = Blocks[i]->succBlock.begin();
        while (itr != Blocks[i]->succBlock.end())
        {
            itr1.push_back(*itr);
            itr++;
        }
        itr1++;
    }
    vector<BasicBlock *>::iterator itr2 = Blocks[i];
    itr2 = Blocks.erase(itr2);
}

void Visitblock(std::vector<BasicBlock *> Blocks, LinearIR *IR)
{
    //判断globle是否为空
    if (Blocks[0]->InstrList.size() == 0)
    {
        DeleteBlock(Blocks, 0);
    }

    //对函数的dom进行遍历，dom指令为空则删除dom
    for (int i = 1; i < Blocks.size(); i++)
    {
        //没有domblock
        if (Blocks[i]->domBlock.size() == 0)
        {
            DeleteBlock(Blocks, i);
        }

        //domblock中的处理 domblock指令为空、没有前驱和后继的都删除
        for (int j = 0; j < Blocks[i]->domBlock.size(); j++) //遍历所有domblock
        {
            if (Blocks[i]->domBlock[j]->InstrList.size() == 0)
            {
                DeleteBlock(Blocks[i]->domBlock, j);
            }
            else if (Blocks[i]->domBlock[j]->succBlock.size() == 0 && Blocks[i]->domBlock[j]->pioneerBlock.size() == 0)
            {
                DeleteBlock(Blocks[i]->domBlock, j);
            }

            else
            {
                if (Blocks[i]->domBlock[j]->bType == BasicBlock::Break || Blocks[i]->domBlock[j]->bType == BasicBlock::Continue)
                { //break 和 continue jump后的代码删除

                    for (list<int>::iterator it = Blocks[i]->domBlock[j]->InstrList.begin(); it != Blocks[i]->domBlock[j]->InstrList.end(); ++it)
                    {
                        if (IR->InstList[it].getOpType == Jmp) //找到jmp指令
                        {
                            for (list<int>::iterator k = it + 1; k != Blocks[i]->domBlock[j]->InstrList.end(); ++k)
                            {
                                Blocks[i]->domBlock[j]->InstrList.erase(k);
                            }
                        }
                    }
                }

                //return 语句后的指令删除
                for (list<int>::iterator it = Blocks[i]->domBlock[j]->InstrList.begin(); it != Blocks[i]->domBlock[j]->InstrList.end(); ++it)
                {
                    if (IR->InstList[it].getOpType == Ret)
                    {
                        for (list<int>::iterator k = it + 1; k != Blocks[i]->domBlock[j]->InstrList.end(); ++k)
                        {
                            Blocks[i]->domBlock[j]->InstrList.erase(k);
                        }
                    }
                }
            }
        }
    }
}
