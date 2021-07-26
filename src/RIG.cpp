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
    if(ai->getType() == armInstr::armInsType::add)
    {
        armAdd* add_ai = (armAdd*)ai; // 向子类塑性
        // out[s] - kill[s]
        ins[ai].erase(add_ai->rd);
        // gen[s] U (out[s] - kill[s])
        ins[ai].insert(add_ai->r0);
        // 当它只有是var register的时候才insert，否则就不insert
        if(add_ai->r1->gettype() == Decl::declType::var_decl)
            ins[ai].insert(add_ai->r1);
    }
    else if(ai->getType() == armInstr::armInsType::sub)
    {
        armSub* sub_ai = (armSub*)ai;
        ins[ai].erase(sub_ai->rd);
        ins[ai].insert(sub_ai->r0);
        if(sub_ai->r1->gettype() == Decl::declType::var_decl)
            ins[ai].insert(sub_ai->r1);
    }
    else if(ai->getType() == armInstr::armInsType::mul)
    {
        armMul* mul_ai = (armMul*)ai;
        ins[ai].erase(mul_ai->rd);
        ins[ai].insert(mul_ai->r0);
        if(mul_ai->r1->gettype() == Decl::declType::var_decl)
            ins[ai].insert(mul_ai->r1);
    }



}

void fillInOut(BasicBlock* bb)
{// 不断访问后继，直到访问到最后一个没有没有后继的block，一步一步算in 和 out

//    dbg(block2lb[bb]);
    if(blockVisited[bb]) return; // 若已经访问过，则跳过
    blockVisited[bb] = true; // 标记访问

    // 若根本没有这个block的键值，直接返回（其实是出错了）；若当前block下根本没有指令，直接返回
    if(newBlock.count(bb) == 0 || newBlock[bb].size() == 0) return;

    armInstr * last_b_ins=newBlock[bb][newBlock[bb].size() - 1];
    outs[last_b_ins]={};
    for(auto succ: bb->succBlock)
    {// 先不断访问后继，递归下去
        fillInOut(succ);
        // out[s] = U in[p] 把后继的第一条指令对应的 in 集合 放入当前指令的out集合

        // 如果它后继也一行代码也没有，也直接return了，否则core dump
        if(newBlock.count(succ) == 0 || newBlock[succ].size() == 0) return;
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

}

void showSets(DomTreenode* dn)
{
    BasicBlock* b = dn->block;
    cout << block2lb[b] << endl;
    for(auto arm_ins: newBlock[b])
    {
        cout << *arm_ins << "\t";
        dbg(ins[arm_ins].size());
        for(auto in_decl: ins[arm_ins])
            cout << *in_decl << " ";
        for(auto out_decl: outs[arm_ins])
            cout << *out_decl << " ";
        cout << "\n";
    }
    // 递归打印剩下的
    for(auto nx: dn->son)
    {
        showSets(nx);
    }
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
        dbg("neho -- clear sets and graph");

        // 2 开始从第一个domblock递归，填满in 和 out 集合
        fillInOut(gb->domBlock[0]);
        dbg("neho -- fill in/out sets");

        // 2.5 for debug 先临时打印一下这些个in 和 out
        cout << "\n\n";
        for(auto dr: DomRoot)
        {
            showSets(dr);
        }

        // 3 利用填好的in、out集合，建立冲突图



    }
}