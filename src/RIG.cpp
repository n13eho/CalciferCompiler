#include"RIG.h"

// input at liveSet.h
   /*map<BasicBlock*, vector<armInstr*>> newBlock;*/

// output
map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph
map<armInstr*, set<Decl*>> ins; // 每条arm指令对应的in集合，要记得清空
map<armInstr*, set<Decl*>> outs; // 公用复用的out集合

// visited block
map<BasicBlock*, bool> blockVisited;

void ArmI2InOut(armInstr* ai)
{//根据类型，找出每一条语句的in集合
    if(ai->getType() == armInstr::type::add)
    {

    }
}

void fillInOut(BasicBlock* bb)
{// 不断访问后继，直到访问到最后一个没有没有后继的block，一步一步算in 和 out
//    if(bb->succBlock.size() == 0)
//    { // 再无后继，则从该block的最后一条语句开始添加 in out 集合
//        // 先处理最后一个block的最后一条指令
//        outs[newBlock[bb][newBlock[bb].size() - 1]] = {};
//        for(int i = newBlock[bb].size() - 1; i >= 0; --i)
//        {
//            ArmI2InOut(newBlock[bb][i]);
//            if(i)outs[newBlock[bb][i-1]]=ins[newBlock[bb][i]];
//        }
//    }
//    else
//    {

    if(blockVisited[bb]) return; // 若已经访问过，则跳过
    blockVisited[bb] = true; // 标记访问

    armInstr * last_b_ins=newBlock[bb][newBlock[bb].size() - 1];
    outs[last_b_ins]={};
    for(auto succ: bb->succBlock)
    {// 先不断访问后继，递归下去
        fillInOut(succ);

        // out[s] = U in[p] 把后继的第一条指令对应的 in 集合 放入当前指令的out集合
        for (auto i : ins[newBlock[succ][0]])outs[last_b_ins].insert(i);
    }
    // 直到后面没有后继了，开始算
    for(int i = newBlock[bb].size() - 1; i >= 0; --i)
    {
        // in[s] = gen[s] U (out[s] - kill[s])
        // ins[s] = out[s] 后面进去再减去kill[s], out[s]已经被上一条更新过了
        ins[newBlock[bb][i]] = outs[newBlock[bb][i]];
        // 计算真正的ins[s]
        ArmI2InOut(newBlock[bb][i]);
        // 更新它上一条指令的outs，即将自己的in赋给它
        if(i)outs[newBlock[bb][i-1]] = ins[newBlock[bb][i]];
    }


//    }
}


void buildRIG()
{
    // 对于每个顶层块（除了第一个全局模块），都应该对应一个RIG图
    for(auto gb: IR1->Blocks)
    {
        // 跳过第一个全局变量，core dump，可能有隐患
        if(gb->domBlock.size() == 0)continue;

        // 1 init: clear the ins and outs sets
        ins.clear();
        outs.clear();
        blockVisited.clear();

        // 2 开始从第一个domblock递归，填满in 和 out 集合
        fillInOut(gb->domBlock[0]);
//        dbg(newBlock[gb->domBlock[0]].size());
//        for(auto ains: newBlock[gb->domBlock[0]])
//        {
//            cout << *ains << endl;
//
//        }

        // 3 利用填好的in、out集合，建立冲突图



    }
}