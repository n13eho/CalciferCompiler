#include"RIG.h"
#include"op_cfgFrequency.h"
// input at liveSet.h
   /*map<BasicBlock*, vector<armInstr*>> newBlock;*/

// output
map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph
map<armInstr*, set<pair<int, int> >> ins; // 每条arm指令对应的in集合，要记得清空
map<armInstr*, set<pair<int, int> >> outs; // 公用复用的out集合

// visited block 每个顶层模块内的block
map<BasicBlock*, bool> blockVisited;
// created RIGnode 该decl(现在是这个寄存器编号int)是否已经创建了对应的RIGnode
map<pair<int, int>, RIGnode*> rigNodeCreated;
// vregNumber 到 使用这个编号的decl 的集合，用于找到这些decl，来自LiveSet.cpp
// 这是个临时用于转存的map
map<int, vector<Decl*>> temp_Vreg2Decls;

map<RIGnode*, int> colors; // 着色color 一个rignode（其实是vreg）对应新的颜色

// 记录每一个寄存器编号（颜色）对应的spilling cost
map<int, double> spilling_cost;

bool notConst(Decl* d)
{
    return d->gettype() != Decl::declType::const_decl;
}

int VregNumofDecl(Decl* d)
{// 主要是返回这个decl对应的寄存器变化vreg；有vreg的只有两中decl，分别是var和address
    if(d->gettype() == Decl::var_decl)
    {
        varDecl* var_d = (varDecl*)d;
        return var_d->Vreg;
    }
    else if(d->gettype() == Decl::addr_decl)
    {
        addrDecl* add_d = (addrDecl*)d;
        return add_d->Vreg;
    }
    else if(d->gettype() == Decl::reg_decl){
        regDecl* reg_d = (regDecl*)d;
        if(reg_d->Rreg > 3)dbg("regDecl出问题了");
        return reg_d->Rreg; // 只有可能是0，1，2，3
    }
    return 789;
}

void ArmI2InOut(armInstr* ai)
{//根据类型，找出每一条语句的in集合
    if(ai->getType() == armInstr::armInsType::add)
    {
        armAdd* add_ai = (armAdd*)ai; // 向子类塑性
        // out[s] - kill[s]
        ins[ai].erase(make_pair(VregNumofDecl(add_ai->rd), add_ai->rd->gettype()));
        // gen[s] U (out[s] - kill[s])
        ins[ai].insert(make_pair(VregNumofDecl(add_ai->r0), add_ai->r0->gettype()));
        add_ai->r0->gen_used.push_back(ai); // 图着色溢出的1.2
        // 当它只有是var register的时候才insert，否则就不insert
        if(notConst(add_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(add_ai->r1), add_ai->r1->gettype()));
            add_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::moveq)
    {
        armMoveq* moveq_ai = (armMoveq*)ai;

        // moveq的rd是kill集合,只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(moveq_ai->rd), moveq_ai->rd->gettype()));
    }
    else if(ai->getType() == armInstr::armInsType::movne)
    {
        armMovne* movne_ai = (armMovne*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype()));
    }
    else if(ai->getType() == armInstr::armInsType::sub)
    {
        armSub* sub_ai = (armSub*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(sub_ai->rd), sub_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(sub_ai->r0), sub_ai->r0->gettype()));
        sub_ai->r0->gen_used.push_back(ai);
        if(notConst(sub_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(sub_ai->r1), sub_ai->r1->gettype()));
            sub_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::mul)
    {
        armMul* mul_ai = (armMul*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(mul_ai->rd), mul_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(mul_ai->r0), mul_ai->r0->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(mul_ai->r1), mul_ai->r1->gettype())); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mul_ai->r0->gen_used.push_back(ai);
        mul_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::div)
    {
        armDiv* div_ai = (armDiv*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(div_ai->rd), div_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(div_ai->r0), div_ai->r0->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(div_ai->r1), div_ai->r1->gettype())); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        div_ai->r0->gen_used.push_back(ai);
        div_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::mod)
    {
        armMod* mod_ai = (armMod*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(mod_ai->rd), mod_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(mod_ai->r0), mod_ai->r0->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(mod_ai->r1), mod_ai->r1->gettype())); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mod_ai->r0->gen_used.push_back(ai);
        mod_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::mov)
    {
        armMov* mov_ai = (armMov*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(mov_ai->rd), mov_ai->rd->gettype()));
        if(notConst(mov_ai->rs))
        {
            ins[ai].insert(make_pair(VregNumofDecl(mov_ai->rs), mov_ai->rs->gettype()));
            mov_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::cmp)
    {
        armCmp* cmp_ai = (armCmp*)ai;
        // cmp 指令没有kill集合，因此没有decl来erase，只有两个操作数来进行insert
        ins[ai].insert(make_pair(VregNumofDecl(cmp_ai->r0), cmp_ai->r0->gettype()));
        cmp_ai->r0->gen_used.push_back(ai);
        if(notConst(cmp_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(cmp_ai->r1), cmp_ai->r1->gettype()));
            cmp_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::str)
    {
        armStr* str_ai = (armStr*)ai;
        //str指令是的rd是gen集
        ins[ai].insert(make_pair(VregNumofDecl(str_ai->rd), str_ai->rd->gettype()));
        str_ai->rd->gen_used.push_back(ai);

        // str 的rs是[r0]这种情况的话，r0也是他的gen。PS:rs处只有可能是addr_decl和mem_decl
        if(str_ai->rs->gettype() == Decl::addr_decl)
        {
            ins[ai].insert(make_pair(VregNumofDecl(str_ai->rs), str_ai->rs->gettype()));
            str_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::ldr)
    {
        armLdr* ldr_ai = (armLdr*)ai;
        //ldr指令是的rd是kill集
        ins[ai].erase(make_pair(VregNumofDecl(ldr_ai->rd), ldr_ai->rd->gettype()));

        //ldr 的rs是[r0]这种情况，r0是他的gen。PS：rs处只有可能是 global_decl, memory_decl, addr_decl
        if(ldr_ai->rs->gettype() == Decl::addr_decl)
        {
            ins[ai].insert(make_pair(VregNumofDecl(ldr_ai->rs), ldr_ai->rs->gettype()));
            ldr_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::call)
    {
        armCall* call_ai = (armCall*)ai;
        // call 有返回值，需要kill掉
        if(call_ai->rd != NULL)
            ins[ai].erase(make_pair(VregNumofDecl(call_ai->rd), call_ai->rd->gettype()));

        // 0-3号全部kill掉
        ins[ai].erase(make_pair(0, 6));
        ins[ai].erase(make_pair(1, 6));
        ins[ai].erase(make_pair(2, 6));
        ins[ai].erase(make_pair(3, 6));

        // 0-3号再全部gen出来
        ins[ai].insert(make_pair(0, 6));
        ins[ai].insert(make_pair(1, 6));
        ins[ai].insert(make_pair(2, 6));
        ins[ai].insert(make_pair(3, 6));

        // rs内全是gen (这部分不变)
//        for(auto r: call_ai->rs)
//        {
//            if(notConst(r))
//            {
//                ins[ai].insert(make_pair(VregNumofDecl(r), r->gettype()));
//                r->gen_used.push_back(ai);
//            }
//        }

        // Decl* r;
        // for(int i=4; i<call_ai->rs.size(); i++){
        //     r = call_ai->rs[i];
        //     if(notConst(r))
        //     {
        //         ins[ai].insert(make_pair(VregNumofDecl(r), r->gettype()));
        //         r->gen_used.push_back(ai);
        //     }
        // }

    }
    else if(ai->getType() == armInstr::armInsType::ret)
    {
        armRet* ret_ai = (armRet*)ai;

        // rs is gen
        if(ret_ai->rs != NULL)
            if(notConst(ret_ai->rs))
            {
                ins[ai].insert(make_pair(VregNumofDecl(ret_ai->rs), ret_ai->rs->gettype()));
                ret_ai->rs->gen_used.push_back(ai);
            }
    }
    else if(ai->getType() == armInstr::rsb)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armRsb* rsb_ai = (armRsb*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(rsb_ai->rd), rsb_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(rsb_ai->r0), rsb_ai->r0->gettype()));
        rsb_ai->r0->gen_used.push_back(ai);
        if(notConst(rsb_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(rsb_ai->r1), rsb_ai->r1->gettype()));
            rsb_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::lsl)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armLsl* lsl_ai = (armLsl*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(lsl_ai->rd), lsl_ai->rd->gettype()));
        ins[ai].insert(make_pair(VregNumofDecl(lsl_ai->rs), lsl_ai->rs->gettype()));
        lsl_ai->rs->gen_used.push_back(ai);
        if(notConst(lsl_ai->sh))
        {
            ins[ai].insert(make_pair(VregNumofDecl(lsl_ai->sh), lsl_ai->sh->gettype()));
            lsl_ai->sh->gen_used.push_back(ai);
        }
    }
}

void fillInOut(BasicBlock* bb)
{// 不断访问后继，直到访问到最后一个没有没有后继的block，一步一步算in 和 out

    if(blockVisited[bb]==1) return; // 若已经访问过，则跳过
    blockVisited[bb] = true; // 标记访问

    // 若根本没有这个block的键值，直接返回（其实是出错了）；若当前block下根本没有指令，直接返回
    if(newBlock.count(bb) == 0 || newBlock[bb].size() == 0) return;

    armInstr* last_b_ins=newBlock[bb][newBlock[bb].size() - 1];
    outs[last_b_ins]={};
    for(auto succ: bb->succBlock)
    {// 先不断访问后继，递归下去
        fillInOut(succ);
        // 如果它后继也一行代码也没有，也直接?????了，否则core dump
        if(newBlock.count(succ) == 0 || newBlock[succ].size() == 0) continue;

        // out[s] = U in[p] 把后继的第一条指令对应的 in 集合 放入当前指令的out集合
        for (auto i : ins[newBlock[succ][0]])outs[last_b_ins].insert(i);
    }
    // 直到后面没有后继了，开始算
    for(int i = newBlock[bb].size() - 1; i >= 0; --i)
    {
        // ins[s] = gen[s] U (outs[s] - kill[s])
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
        cout << *arm_ins;
        cout << "\tins: ";
        for(auto in_decl: ins[arm_ins])
            cout << (in_decl.second == 6 ? "r" : "") << in_decl.first << " ";
        cout << "\touts: ";
        for(auto out_decl: outs[arm_ins])
            cout << (out_decl.second == 6 ? "r" : "") << out_decl.first << " ";
        cout << "\n";
    }
    // 递归打印剩下的
    for(auto nx: dn->son)
    {
        showSets(nx);
    }
}

RIGnode* ForCnode(pair<int, int> d_p, BasicBlock* gb)
{// find or create a new RIGnode
    RIGnode* ret_n;
    if(d_p.second == Decl::reg_decl)
    {// 就要返回一个reg_decl类型的node
        if(rigNodeCreated[d_p] != nullptr
            && rigNodeCreated[d_p]->dc_type == Decl::reg_decl
            && d_p.first == rigNodeCreated[d_p]->dc){
            ret_n = rigNodeCreated[d_p];
//            dbg(d_p.first);
        }
        else{
            ret_n = new RIGnode(d_p.first, d_p.second);
            rigNodeCreated[d_p] = ret_n;
            RIG[gb].push_back(ret_n);
        }
    }
    else
    {// 返回一个不是reg_decl类型的node
        if(rigNodeCreated[d_p] != nullptr
            && rigNodeCreated[d_p]->dc_type != Decl::reg_decl
            && d_p.first == rigNodeCreated[d_p]->dc){
            ret_n = rigNodeCreated[d_p];
        }
        else{
            ret_n = new RIGnode(d_p.first, d_p.second);
            rigNodeCreated[d_p] = ret_n;
            RIG[gb].push_back(ret_n);
        }
    }

    return ret_n;
}

void connectDecl(DomTreenode* dn, BasicBlock* gb)
{
    BasicBlock* b = dn->block;
    for(auto arm_ins: newBlock[b])
    {//挨个访问每一条arm_ins对应的ins集合，建立边
        for(auto in_decl: ins[arm_ins])
        {
            // 1 新建/找到存在的node
            // 如果该decl已经建立了RIGnode，则不再建立，否则建立
            RIGnode* n = ForCnode(in_decl, gb);

            // 2 建立映射
            for(auto other_decl: ins[arm_ins])
            {
                if(in_decl == other_decl)// 是自己，不用加边
                    continue;
                else
                {
                    RIGnode* other_node = ForCnode(other_decl, gb);
                    // 如果这条边已经连接过了，就不用加了
                    if(find(n->connectTo.begin(), n->connectTo.end(), other_node) != n->connectTo.end())
                         continue;
                    n->connectTo.push_back(other_node);
                }
            }
        }
    }

    // 递归连接剩下的
    for(auto nx: dn->son)
        connectDecl(nx, gb);
}
//filling colors data structure.
int trytimes=5;//某迭代次数
queue<RIGnode*> que;//queue of filling color with BFS


int usedK;

void init_color(BasicBlock* gb)
{
    // 别的需要用到寄存器的，从参数个数开始染色
    colors.clear();

    // 首先就把r0-r3的参数编号内定了
    usedK = 0;
    for(auto i=0 ; i<min(4,(int)gb->FuncV->FuncParams.size()) ; i++)
    {
        auto param_value = gb->FuncV->FuncParams[i];
        Decl* param_dc = Assign_rec[make_pair(param_value,gb->domBlock[0])][reachset_times-1];
        // 789 预警
        if(VregNumofDecl(param_dc) == 789)dbg("789 出现！！！！！");
        RIGnode* param_rignode = ForCnode(make_pair(VregNumofDecl(param_dc), param_dc->gettype()), gb); //RIGnode建立好了

        // 直接填死颜色
        colors[param_rignode] = ++usedK;
    }

    usedK = 5;

}

vector<RIGnode*> s_point; // 起点

bool check_ok(RIGnode* n, int c)
{
    for(auto con: n->connectTo){
        if(con->dc_type == Decl::reg_decl){ // 如果连接的node是reg_decl的话
            dbg(n->dc, c, con->dc); // 当前node的number，向然的颜色，相连reg 的颜色
            if(c == con->dc + 1)return false;
        }
        else if(!colors[con]){
            continue;
        }
        else if(colors[con]==c){
            return false;
        }
    }
    return true;
}

bool paintColor(BasicBlock* gb){
    //1. 找到所有起点;
    int maxdu=-1;
    s_point.clear();
    for(auto node: RIG[gb]){
        if(colors[node])continue;
        if(node->dc==13)continue; // 开后门: 不给13染
        if((int)node->connectTo.size()>maxdu){
            s_point.clear();
            s_point.push_back(node);
            maxdu=node->connectTo.size();
        }
        else if(node->connectTo.size()==maxdu)s_point.push_back(node);
    }
    //1.1random
    // random_shuffle(s_point.begin(),s_point.end());
    //1.2 add s_point，非联通的图可以重新使用参数个数/4

    if(s_point.size() == 0)return true;// 表示这个函数只用了参数分到的寄存器，没用其他的寄存器，因此直接返回true

    //给起点染色
    for(int i=1;i<=usedK;i++){
        if(i==14)continue;
        if(check_ok(s_point[0],i)){
            colors[s_point[0]]=i;
//            if(s_point[0]->dc == 21)
            break;
        }
    }
    // 如果给起点染色失败，直接新开一个usedk（上线
    if(colors[s_point[0]]==0){
        if(usedK == 13)usedK++; // 同上，不能染上13
        colors[s_point[0]]=++usedK;
    }
    // 起点入队
    que.push(s_point[0]);
    //2. BFS coloring
    while(!que.empty()){
        RIGnode* now = que.front();
        que.pop();
        // 随机的访问now所连的点
        // random_shuffle(now->connectTo.begin(),now->connectTo.end());
        for(auto nx:now->connectTo){
            //对nx尝试每一种颜色
            if(colors[nx] || nx->dc==13)continue;

            for(int i=1;i<=usedK;i++){ // 还是从1开始
                if(i == 14)continue; // 不能染上13，13要跳过
                if(check_ok(nx,i)){
                    colors[nx]=i;
                    que.push(nx);
                    break;
                }
            }
            if(colors[nx]==0){
                if(usedK == 13)usedK++; // 同上，不能染上13
                colors[nx]=++usedK;
            }
        }
    }
    for(auto node: RIG[gb]){
        if(node->dc==13)continue;
        if(colors[node]==0)return paintColor(gb);
    }
    return true;
}

void deleteDC(DomTreenode* dn, BasicBlock* gb)
{
    bool findDc;
    BasicBlock* b = dn->block;
    for(auto it = newBlock[b].begin(); it != newBlock[b].end(); it++)
    {// 遍历指令
        if((*it)->rd != NULL)
        {
//            if(VregNumofDecl((*it)->rd)>=0&&VregNumofDecl((*it)->rd)<=3)continue; // 0-3开后门
            findDc = false;
            for(auto rn: RIG[gb])
            {// 找该指令的左值是否出现在RIG[gb]中，如果该左值没有出现在RIG[gb]中，就删除这条指令
                if(rn->dc == VregNumofDecl((*it)->rd))
                {
                    findDc = true;
                    break;
                }
            }
            if(!findDc)
            {// 没找到这个dc就删除这条指令
                // 如果是改变全局变量，这里就不能删去这个call
                if((*it)->getType()==armInstr::call){ // 害怕这个call函数修改了全局变量
                    armCall* call_ins = (armCall*)(*it); // 先suxing
                    call_ins->rd = nullptr; // 再解决这条call_ins的rd的指针
                }
                else{
                    newBlock[b].erase(it--);
                }
            }
        }
    }
    // 递归删除剩下后继块的死代码
    for(auto nx: dn->son)
        deleteDC(nx, gb);
}

void specialInsDelete(DomTreenode* sd)
{
    BasicBlock* s=sd->block;
    for(auto it = newBlock[s].begin(); it != newBlock[s].end(); it++){
        if((*it)->getType() == armInstr::mov)
        {
            armMov* mov_ai = (armMov*)(*it);

            if(VregNumofDecl(mov_ai->rd) == VregNumofDecl(mov_ai->rs)){
                if(mov_ai->rs->gettype() == Decl::addr_decl){ // 如果rs是地址类型的，就不删
                    continue;
                }
                else{ // 如果rs不是地址类型的，那么任意mov的rd 和 rs number相同的话就都能删，管你是不是regdecl
                    newBlock[s].erase(it--);
                }
            }
        }

    }

    //递归
    for(auto nx:sd->son){
        specialInsDelete(nx);
    }
}

/*
 * 1 挑选哪个node出来
 * 计算每个node的spill cost，选出cost最小的
 * 计算spillCost算法：
 * 1.1 计算frequency of each block map_frequen<basicBlock* b, double frequency>
 * 1.2 在建立IN/OUT集合的时候就记录每个decl出现在gen集合中的次数，并记录，用dc->gen_used
 * 1.3 map_frequen[dc->rawBlock] * dc->gen_used.size() 得到最终的cost， 存入dc->spill_cost
 * 1.4 通过RIG图 遍历所有decl 找出cost最小的
 *
 * 2 挑出来之后...
 * 加指令：在定义之后加str；在要使用之前加ldr，使用之后也要加str
    - var to memery
    - global to 段
 */
int chosenOne = -1;
// cost最小的寄存器编号

void spillCost(BasicBlock* gb){
    for(auto node: RIG[gb]){
        if(node->dc==13)continue;
        auto dc_vreg= node->dc;
        spilling_cost[dc_vreg] = 0; // 清零
        for(auto dc: Vreg2Decls[dc_vreg])
        {
            spilling_cost[dc_vreg] += blockFrequency[dc->rawBlock] * (double)dc->gen_used.size();
            spilling_cost[dc_vreg] += blockFrequency[dc->rawBlock] * 1.0;
            dc->gen_used.clear();
        }
    }
}

map<Decl*, memoryDecl*> spill_dc2memdc; // spilling失败之后，记录每一个dc对应放在哪里的memdecl

memoryDecl* forc_memShift(Decl* d, BasicBlock* gb){
    // 找得到就返回已经有了的, 没找到就new一个回去

    memoryDecl* ret_m = spill_dc2memdc[d];
    if(ret_m == nullptr){
        ret_m = new memoryDecl(nullptr,gb,gblock2spbias[gb]++);
        spill_dc2memdc[d] = ret_m; // 更新映射
    }
    return ret_m;
}

void all2mem(BasicBlock* gb)
{
    for(auto b : gb->domBlock){
        for(auto it = newBlock[b].begin();it!=newBlock[b].end();it++){
            auto arm_ins = *it;

            //是否要加ldr
            vector<Decl*> rs = arm_ins->getGen();
            for(auto dc : rs){
                if(arm_ins->getType() != armInstr:: call 
                    && dc->gettype() != Decl::const_decl 
                    && dc->gettype() != Decl::memory_decl){
                    armLdr* ldr_ins= new armLdr();
                    ldr_ins->rd = dc;
                    ldr_ins->rs = forc_memShift(dc, gb);
                    it=newBlock[b].insert(it,ldr_ins)+1;
                    ldr_ins->comm = "ttt";
                }
            }

            //是否要加str: rd非空&&编号相等&&不能在一条str前加一个str指令
            if(arm_ins->rd != nullptr 
                && arm_ins->getType() != armInstr::str 
                && arm_ins->rd->gettype() != Decl::reg_decl){

                armStr* str_ins= new armStr();
                str_ins->rd = arm_ins->rd;
                str_ins->rs = forc_memShift(arm_ins->rd, gb);
                it=newBlock[b].insert(it+1,str_ins);
                str_ins->comm = "ttt";
            }

        }
    }

}

void addMemoryOperation(BasicBlock* gb)
{
    // 计算cost
    spillCost(gb);

    // 选出cost最小的dc
    double mincost = 1e18;
    for(auto node : RIG[gb]){
        if(node->dc==13)continue;
        int dc_vreg= node->dc;
        if(spilling_cost[dc_vreg]<mincost){
            mincost = spilling_cost[dc_vreg];
            chosenOne = dc_vreg;
        }
    }

    dbg(chosenOne);

    memoryDecl* memShift = new memoryDecl(nullptr,gb,gblock2spbias[gb]++);
    for(auto b : gb->domBlock){
        for(auto it = newBlock[b].begin();it!=newBlock[b].end();it++){
            auto arm_ins = *it;

            //是否要加ldr
            vector<Decl*> rs = arm_ins->getGen();
            for(auto dc : rs){
                if(VregNumofDecl(dc)==chosenOne){
                    armLdr* ldr_ins= new armLdr();
                    ldr_ins->rd = dc;
                    ldr_ins->rs = memShift;
                    it=newBlock[b].insert(it,ldr_ins)+1;

                    // 建立映射
                    spill_dc2memdc[dc] = memShift;
                }
            }

            //是否要加str: rd非空&&编号相等&&不能在一条str前加一个str指令
            if(arm_ins->rd != nullptr && VregNumofDecl(arm_ins->rd)==chosenOne && arm_ins->getType()!=armInstr::str){
                armStr* str_ins= new armStr();
                str_ins->rd = arm_ins->rd;
                str_ins->rs = memShift;
                it=newBlock[b].insert(it+1,str_ins);

                // 建立映射
                spill_dc2memdc[arm_ins->rd] = memShift;
            }
        }
    }
}

void changeVreg(BasicBlock *gb)
{
    for(auto rigN: colors)
    {
        if(rigN.first->dc==13)continue;
        int dc_vreg = rigN.first->dc;
        for(auto dc: Vreg2Decls[dc_vreg])
        {// 就将每一个decl的vreg批量改了
            if(dc->rawBlock->parent_ == gb)
            {//（0802改：只改对应gb里面的decl，其他的不要变）
                if(dc->gettype() == Decl::declType::var_decl)
                { // 变量 是存在register里面的
                    varDecl* var_dc = (varDecl*)dc;
                    var_dc->Vreg = rigN.second - 1;
                }
                else if(dc->gettype() == Decl::declType::addr_decl)
                { // 地址 也是存在register里面的
                    addrDecl* mem_dc = (addrDecl*)dc;
                    mem_dc->Vreg = rigN.second - 1;
                }
            }
        }
    }
}

void updateV2Ds()
{
     // init
    temp_Vreg2Decls.clear();

    // 存入temp_Vreg2Decls
    for(auto p: Vreg2Decls)
    {
        for(auto dc: p.second)
        {
            if(VregNumofDecl(dc)==13)continue;
            temp_Vreg2Decls[VregNumofDecl(dc)].push_back(dc);
        }
    }

    // deep copy
    Vreg2Decls.clear();
    Vreg2Decls.insert(temp_Vreg2Decls.begin(), temp_Vreg2Decls.end());
}


bool buildRIG(BasicBlock* gb)
{
    // srand(time(0));

    int times_deadCode = 10;
    while(times_deadCode--)
    {
        // 1 init clear out
        for(auto node:RIG[gb]){free(node);}
        RIG[gb].clear();
        blockVisited.clear();
        rigNodeCreated.clear();
        ins.clear();
        outs.clear();
//        dbg("neho -- init: clear sets and graph");

        // 2 开始从第一个domblock递归，填满in 和 out 集合
        int times_RIG = TIMES_RIG;
        while(times_RIG--){
            blockVisited.clear();
            fillInOut(gb->domBlock[0]);
        }

//         2.5 for debug 先linshi临时打印一下这些个in 和 out
//         cout << "\n\n**** IN&OUT set ****\n";
//         for(auto dr: DomRoot)
//             showSets(dr);

        // 3 利用填好的in、out集合，建立冲突图，也是一个递归的过程
        connectDecl(block2dom[gb->domBlock[0]], gb);

        // 4 deleting dead code
        deleteDC(block2dom[gb->domBlock[0]], gb);
    }
//    dbg("neho -- fill in/out sets");
    // 根本没有分配寄存器，直接返回真
    if(RIG[gb].size() == 0)return true;

    // for debug 打印整张图看看
     cout << "**** the RIG of " << gb->BlockName <<  "****\n";
     for(auto dnode: RIG[gb])
     {
         cout << ((dnode->dc_type == Decl::reg_decl) ? "r" : "") << dnode->dc << "\t";
         for(auto con_node: dnode->connectTo)
         {
             cout << ((con_node->dc_type == Decl::reg_decl) ? "r" : "") << con_node->dc << " ";
         }
         cout << "\n";
     }

    // 5. filling colors!
    trytimes = 1;
    while(trytimes--){
        init_color(gb);
        if(paintColor(gb)){

           dbg("color，该全局块染色情况");
            cout << "**** 该全局块染色情况 ****" << endl;
           for(auto node: RIG[gb]){
               cout << ((node->dc_type == Decl::reg_decl) ? "r" : "")  << node->dc << " " << colors[node]-1 << endl;
           }


            //如果成功了就break; 否则使用颜色过多就再试一次（最多5次）
            if(usedK <= K)break;
        }
    }

    // 遍历color map，修改Vreg
    changeVreg(gb);

    // 跟新Vreg2Decls
    updateV2Ds();

    // 此条不专门针对 mov r0, r0; TODO：之后可以在里面加上针对其他ir指令的优化
    specialInsDelete(block2dom[gb->domBlock[0]]);


#if 1
    // final show instruction agian, this time with limited k registers
    cout << "****Arm Instruction with limited Registers ****\n";
    for(auto dr: DomRoot)
        showDecl(dr);
#endif


    if(usedK>K){ // 染色失败
        cout<<"failed\n";
        return false;
    }
    dbg("染色成功！");
    return true;
}


void RigsterAlloc()
{
    // 对于每个顶层块（除了第一个全局模块），都应该对应一个RIG图
    for(auto gb: IR1->Blocks)
    {
        // 跳过第一个全局变量，core dump，可能有隐患
        if(gb->domBlock.size() == 0)continue;
        int whenToadd = 0;
        int temp_debug = 0;
        bool spill_failed = true;
#if 0
       while(!buildRIG(gb)){
           dbg("染色失败！");
           if(temp_debug++ > 4){
               spill_failed = true;
               break;
           }
            // 如果图着色失败了，add memory operation.
           if(whenToadd++ > WHENTOMO)
               addMemoryOperation(gb);
           // 打印cost
           for(auto p: spilling_cost)
           {
               cout << p.first <<"\t" << p.second <<endl;
           }

            for(auto dr: DomRoot)
                showDecl(dr);
       }

        if(spill_failed){
#endif
            dbg("全放内存");
            all2mem(gb);
            cout << "****add mem ****\n";
            for(auto dr: DomRoot)
                showDecl(dr);
            spill_failed = buildRIG(gb);
        // }
    }



    // final show instruction agian, this time with limited k registers
    cout << "****Arm Instruction with limited Registers ****\n";
    for(auto dr: DomRoot)
        showDecl(dr);
}