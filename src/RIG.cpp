#include"../include/RIG.h"
#include"../include/op_cfgFrequency.h"
// input at liveSet.h
/*map<BasicBlock*, vector<armInstr*>> newBlock;*/

// output
map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

map<armInstr*, set<pair<int, bool> >> ins; // 每条arm指令对应的in集合，要记得清空
map<armInstr*, set<pair<int, bool> >> outs; // 公用复用的out集合

map<armInstr*, set<pair<int, bool> >> old_ins;


// visited block 每个顶层模块内的block
map<BasicBlock*, bool> blockVisited;
// created RIGnode 该decl(现在是这个寄存器编号int)是否已经创建了对应的RIGnode
map<pair<int, bool>, RIGnode*> rigNodeCreated;
// 用于记录这个pair对应的node（此时还没有node，是不是spill的
map<pair<int, bool>, int> nodeSpillMap;

// 这是个临时用于转存的map
map<int, vector<Decl*>> temp_Vreg2Decls;

map<RIGnode*, int> colors; // 着色color 一个rignode（其实是vreg）对应新的颜色

// 记录每一个寄存器编号（颜色）对应的spilling cost
map<int, double> spilling_cost;


int spill_times = 1;

bool notConst(Decl* d)
{
    return d->gettype() != Decl::declType::const_decl;
}

int VregNumofDecl(Decl* d)
{// 主要是返回这个decl对应的寄存器变化vreg；有vreg的只有两中decl，分别是var和address
    if(d == nullptr) return 789;
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
        ins[ai].erase(make_pair(VregNumofDecl(add_ai->rd), add_ai->rd->gettype() == Decl::reg_decl));
        // gen[s] U (out[s] - kill[s])
        // ban掉13寄存器
        if(VregNumofDecl(add_ai->r0) != 13){
            // 不是13号再往gen集合里面加
            ins[ai].insert(make_pair(VregNumofDecl(add_ai->r0), add_ai->r0->gettype() == Decl::reg_decl));
        }
        add_ai->r0->gen_used.push_back(ai); // 图着色溢出的1.2
        // 当它只有是var register的时候才insert，否则就不insert
        if(notConst(add_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(add_ai->r1), add_ai->r1->gettype() == Decl::reg_decl));
            add_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::moveq)
    {
        armMoveq* moveq_ai = (armMoveq*)ai;

        // moveq的rd是kill集合,只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(moveq_ai->rd), moveq_ai->rd->gettype() == Decl::reg_decl));
    }
    else if(ai->getType() == armInstr::armInsType::movne)
    {
        armMovne* movne_ai = (armMovne*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype() == Decl::reg_decl));
    }
    else if(ai->getType() == armInstr::armInsType::movle)
    {
        armMovle* movne_ai = (armMovle*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype() == Decl::reg_decl));
    }
    else if(ai->getType() == armInstr::armInsType::movlt)
    {
        armMovlt* movne_ai = (armMovlt*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype() == Decl::reg_decl));
    }
    else if(ai->getType() == armInstr::armInsType::movge)
    {
        armMovge* movne_ai = (armMovge*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype() == Decl::reg_decl));
    }
    else if(ai->getType() == armInstr::armInsType::movgt)
    {
        armMovgt* movne_ai = (armMovgt*)ai;

        // 只需要erase
        ins[ai].erase(make_pair(VregNumofDecl(movne_ai->rd), movne_ai->rd->gettype() == Decl::reg_decl));
    }
    // TODO: new comers
    else if(ai->getType() == armInstr::armInsType::sub)
    {
        armSub* sub_ai = (armSub*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(sub_ai->rd), sub_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(sub_ai->r0), sub_ai->r0->gettype() == Decl::reg_decl));
        sub_ai->r0->gen_used.push_back(ai);
        if(notConst(sub_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(sub_ai->r1), sub_ai->r1->gettype() == Decl::reg_decl));
            sub_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::mul)
    {
        armMul* mul_ai = (armMul*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(mul_ai->rd), mul_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(mul_ai->r0), mul_ai->r0->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(mul_ai->r1), mul_ai->r1->gettype() == Decl::reg_decl)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mul_ai->r0->gen_used.push_back(ai);
        mul_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::div)
    {
        armDiv* div_ai = (armDiv*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(div_ai->rd), div_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(div_ai->r0), div_ai->r0->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(div_ai->r1), div_ai->r1->gettype() == Decl::reg_decl)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        div_ai->r0->gen_used.push_back(ai);
        div_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::mod)
    {
        armMod* mod_ai = (armMod*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(mod_ai->rd), mod_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(mod_ai->r0), mod_ai->r0->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(mod_ai->r1), mod_ai->r1->gettype() == Decl::reg_decl)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mod_ai->r0->gen_used.push_back(ai);
        mod_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::and_)
    {
        armAnd* and_ai = (armAnd*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(and_ai->rd), and_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(and_ai->r0), and_ai->r0->gettype() == Decl::reg_decl));
        and_ai->r0->gen_used.push_back(ai);
        if(notConst(and_ai->r1)){
            ins[ai].insert(make_pair(VregNumofDecl(and_ai->r1), and_ai->r1->gettype() == Decl::reg_decl)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
            and_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::mov)
    {
        armMov* mov_ai = (armMov*)ai;
        if(mov_ai->rs->gettype() != Decl::reg_decl){
            // 这里专门处理函数开头形参的移动到临时变量的mov指令
            // 如果rs的类型是reg_decl，那么这个时候就不用kill掉rd，专门让他产生冲突
            ins[ai].erase(make_pair(VregNumofDecl(mov_ai->rd), mov_ai->rd->gettype() == Decl::reg_decl));
        }
        if(notConst(mov_ai->rs))
        {
            ins[ai].insert(make_pair(VregNumofDecl(mov_ai->rs), mov_ai->rs->gettype() == Decl::reg_decl));
            mov_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::cmp)
    {
        armCmp* cmp_ai = (armCmp*)ai;
        // cmp 指令没有kill集合，因此没有decl来erase，只有两个操作数来进行insert
        ins[ai].insert(make_pair(VregNumofDecl(cmp_ai->r0), cmp_ai->r0->gettype() == Decl::reg_decl));
        cmp_ai->r0->gen_used.push_back(ai);
        if(notConst(cmp_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(cmp_ai->r1), cmp_ai->r1->gettype() == Decl::reg_decl));
            cmp_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::str)
    {
        armStr* str_ai = (armStr*)ai;
        //str指令是的rd是gen集
        ins[ai].insert(make_pair(VregNumofDecl(str_ai->rd), str_ai->rd->gettype() == Decl::reg_decl));
        str_ai->rd->gen_used.push_back(ai);

        // str 的rs是[r0]这种情况的话，r0也是他的gen。PS:rs处只有可能是addr_decl和mem_decl
        if(str_ai->rs->gettype() == Decl::addr_decl)
        {
            addrDecl* addr = (addrDecl*)str_ai->rs;
            if(addr->biasR!=nullptr){
                //如果偏移是一个decl也需要变
                ins[ai].insert(make_pair(VregNumofDecl(addr->biasR),addr->biasR->gettype() == Decl::reg_decl));
                addr->biasR->gen_used.push_back(ai);
            }

            ins[ai].insert(make_pair(VregNumofDecl(str_ai->rs), str_ai->rs->gettype() == Decl::reg_decl));
            str_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::ldr)
    {
        armLdr* ldr_ai = (armLdr*)ai;
        //ldr指令是的rd是kill集
        ins[ai].erase(make_pair(VregNumofDecl(ldr_ai->rd), ldr_ai->rd->gettype() == Decl::reg_decl));

        //ldr 的rs是[r0]这种情况，r0是他的gen。PS：rs处只有可能是 global_decl, memory_decl, addr_decl
        if(ldr_ai->rs->gettype() == Decl::addr_decl)
        {
            addrDecl* addr = (addrDecl*)ldr_ai->rs;
            if(addr->biasR!=nullptr){
                //如果偏移是一个decl也需要变
                ins[ai].insert(make_pair(VregNumofDecl(addr->biasR),addr->biasR->gettype() == Decl::reg_decl));
                addr->biasR->gen_used.push_back(ai);
            }
            ins[ai].insert(make_pair(VregNumofDecl(ldr_ai->rs), ldr_ai->rs->gettype() == Decl::reg_decl));
            ldr_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::call)
    {
        armCall* call_ai = (armCall*)ai;
        // call 有返回值，需要kill掉
        if(call_ai->rd != NULL)
            ins[ai].erase(make_pair(VregNumofDecl(call_ai->rd), call_ai->rd->gettype() == Decl::reg_decl));

        // 0-3号全部kill掉
        ins[ai].erase(make_pair(0, true));
        ins[ai].erase(make_pair(1, true));
        ins[ai].erase(make_pair(2, true));
        ins[ai].erase(make_pair(3, true));

        // 0-3号再全部gen出来
        ins[ai].insert(make_pair(0, true));
        ins[ai].insert(make_pair(1, true));
        ins[ai].insert(make_pair(2, true));
        ins[ai].insert(make_pair(3, true));

    }
    else if(ai->getType() == armInstr::armInsType::ret)
    {
        armRet* ret_ai = (armRet*)ai;

        // rs is gen
        if(ret_ai->rs != NULL)
            if(notConst(ret_ai->rs))
            {
                ins[ai].insert(make_pair(VregNumofDecl(ret_ai->rs), ret_ai->rs->gettype() == Decl::reg_decl));
                ret_ai->rs->gen_used.push_back(ai);
            }
    }
    else if(ai->getType() == armInstr::rsb)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armRsb* rsb_ai = (armRsb*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(rsb_ai->rd), rsb_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(rsb_ai->r0), rsb_ai->r0->gettype() == Decl::reg_decl));
        rsb_ai->r0->gen_used.push_back(ai);
        if(notConst(rsb_ai->r1))
        {
            ins[ai].insert(make_pair(VregNumofDecl(rsb_ai->r1), rsb_ai->r1->gettype() == Decl::reg_decl));
            rsb_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::lsl)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armLsl* lsl_ai = (armLsl*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(lsl_ai->rd), lsl_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(lsl_ai->rs), lsl_ai->rs->gettype() == Decl::reg_decl));
        lsl_ai->rs->gen_used.push_back(ai);
        if(notConst(lsl_ai->sh))
        {
            ins[ai].insert(make_pair(VregNumofDecl(lsl_ai->sh), lsl_ai->sh->gettype() == Decl::reg_decl));
            lsl_ai->sh->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::asr)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armAsr* asr_ai = (armAsr*)ai;
        ins[ai].erase(make_pair(VregNumofDecl(asr_ai->rd), asr_ai->rd->gettype() == Decl::reg_decl));
        ins[ai].insert(make_pair(VregNumofDecl(asr_ai->rs), asr_ai->rs->gettype() == Decl::reg_decl));
        asr_ai->rs->gen_used.push_back(ai);
        if(notConst(asr_ai->sh))
        {
            ins[ai].insert(make_pair(VregNumofDecl(asr_ai->sh), asr_ai->sh->gettype() == Decl::reg_decl));
            asr_ai->sh->gen_used.push_back(ai);
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
    std::cout << block2lb[b] << endl;
    for(auto arm_ins: newBlock[b])
    {
        std::cout << *arm_ins;
        std::cout << "\tins: ";
        for(auto in_decl: ins[arm_ins])
            std::cout << (in_decl.second == 1 ? "r" : "") << in_decl.first << " ";
        std::cout << "\touts: ";
        for(auto out_decl: outs[arm_ins])
            std::cout << (out_decl.second == 1 ? "r" : "") << out_decl.first << " ";
        std::cout << "\n";
    }
    // 递归打印剩下的
    for(auto nx: dn->son)
    {
        showSets(nx);
    }
}

RIGnode* ForCnode(pair<int, bool> d_p, BasicBlock* gb)
{// find or create a new RIGnode
    RIGnode* ret_n;
    if(d_p.second == true)
    {// 就要返回一个reg_decl类型的node
        if(rigNodeCreated[make_pair(d_p.first, true)] != nullptr
        && rigNodeCreated[make_pair(d_p.first, true)]->typeIsREG == true
        && d_p.first == rigNodeCreated[make_pair(d_p.first, true)]->dc){
            ret_n = rigNodeCreated[make_pair(d_p.first, true)];
            //            dbg(d_p.first);
        }
        else{
            ret_n = new RIGnode(d_p.first, d_p.second); // d_p.second=true
            rigNodeCreated[make_pair(d_p.first, true)] = ret_n;
            RIG[gb].push_back(ret_n);
        }
    }
    else
    {// 返回一个不是reg_decl类型的node
        if(rigNodeCreated[make_pair(d_p.first, false)] != nullptr
        && rigNodeCreated[make_pair(d_p.first, false)]->typeIsREG == false
        && d_p.first == rigNodeCreated[make_pair(d_p.first, false)]->dc){
            ret_n = rigNodeCreated[make_pair(d_p.first, false)];
        }
        else{
            ret_n = new RIGnode(d_p.first, d_p.second); // d_p.second=false
            rigNodeCreated[make_pair(d_p.first, false)] = ret_n;
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
            // 及时更新这个pair对应的是否spill的信息，将其传递到node这一层
            n->node_spilled = nodeSpillMap[in_decl];


            // 2 和其他都在ins集合里面的，建立connectTo的连边
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

            // 计算这个node的度
            n->du = n->connectTo.size(); // unsigned --> int
        }
    }

    // 递归连接剩下的
    for(auto nx: dn->son)
        connectDecl(nx, gb);
}
//filling colors data structure.

struct spill_cmp
{
    bool operator () (RIGnode* a, RIGnode* b) const
    {
        if(a->node_spilled == b->node_spilled){
            return a->du < b->du;
        }
        else return a->node_spilled < b->node_spilled;
    }
};


queue<RIGnode*> que;//queue of filling color with BFS


int usedK;

void init_color(BasicBlock* gb)
{
    // 别的需要用到寄存器的，从参数个数开始染色
    colors.clear();

    usedK = 5;

}

vector<RIGnode*> s_point; // 起点

bool cmp_spill(RIGnode* a, RIGnode* b){
    if(a->node_spilled == b->node_spilled)return a->du > b->du;
    else return a->node_spilled > b->node_spilled;
}

bool check_ok(RIGnode* n, int c)
{
    for(auto con: n->connectTo){
        if(con->typeIsREG == true){ // 如果连接的node是reg_decl的话
//            dbg(n->dc, c, con->dc); // 当前node的number，向然的颜色，相连reg 的颜色
            if(c == con->dc + 1)return false;
        }
        else if(!colors[con]){
            continue;
        }
        else if(colors[con]==c){
            return false;
        }
    }

#if 0
    if(n->dc == 34){
        dbg(c);
    }
#endif

    return true;
}

void paintColor(BasicBlock* gb){
    //1. 找到所有起点
    int maxdu=-1;
    int maxnode_spilled = 0;
    s_point.clear();
    for(auto node: RIG[gb]){
        if(colors[node])continue;
        if(node->dc==13)continue; // 开后门: 不给13染
        if(node->node_spilled == maxnode_spilled){
            if((int)node->du>maxdu){
                s_point.clear();
                s_point.push_back(node);
                maxdu=node->du;
            }
            else if(node->du==maxdu)s_point.push_back(node);
        }
        else if(node->node_spilled > maxnode_spilled){
            s_point.clear();
            s_point.push_back(node);
            maxdu = node->du;
            maxnode_spilled = node->node_spilled;
        }

    }
    if(s_point.size() == 0)return;// 表示这个函数只用了参数分到的寄存器，没用其他的寄存器，因此直接返回
#ifdef DEBUG_ON
    cout<<"是否先选了spill的点"<<s_point[0]->node_spilled<<endl;
    cout<<"我选的是"<<s_point[0]->dc<<endl;
    cout<<"它的度是"<<s_point[0]->du<<endl;
#endif

    //给起点染色
    for(int i=1;i<=usedK;i++){
        if(i==14)continue;
        if(check_ok(s_point[0],i)){
            colors[s_point[0]]=i;
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
        //选择spill的、度大的先染
        sort(now->connectTo.begin(),now->connectTo.end());
        for(auto nx:now->connectTo){
            //对nx尝试每一种颜色
            if(colors[nx] || nx->dc==13)continue;

            //update 下一个点的度
            nx->du--;

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

#ifdef DEBUG_ON
                if(usedK == 15){
                    cout<<"14号寄存器怎么还在啊(node_spilled)"<<nx->node_spilled<<endl;
                    cout<<"14号寄存器怎么还在啊(dc)"<<nx->dc<<endl;
                    cout<<"14号寄存器怎么还在啊(du)"<<nx->du<<endl;
                }
#endif
            }
        }
    }
    for(auto node: RIG[gb]){
        if(node->dc==13)continue;
        if(colors[node]==0) paintColor(gb);
    }
    return;
}

void deleteDC(DomTreenode* dn, BasicBlock* gb)
{
    BasicBlock* b = dn->block;
    for(auto it = newBlock[b].begin(); it != newBlock[b].end(); it++)
    {
        // 遍历指令
        auto arm_ins = *it;

        // 忽略到存内存的指令
        if(arm_ins->getType() == armInstr::str || (arm_ins->getType() >= armInstr::movlt && arm_ins->getType() <= armInstr::movne))continue;

        if(arm_ins->rd != NULL)
        {
            auto pair = make_pair(VregNumofDecl(arm_ins->rd), arm_ins->rd->gettype() == Decl::reg_decl);

            if(outs[arm_ins].count(pair) == 0)
            {
                // 如果这条指令的rd不在对应的out集合中，就删去这条指令
                // 如果是改变全局变量，这里就不能删去这个call
                if((*it)->getType()==armInstr::call){ // 害怕这个call函数修改了全局变量
                    armCall* call_ins = (armCall*)(*it); // 先suxing
                    call_ins->rd = nullptr; // 再解决这条call_ins的rd的指针
                }
                else{
#ifdef DEBUG_ON
                    cout << "insdeleted: " << **it <<endl;
#endif
                    newBlock[b].erase(it--);
                    gbarmCnt[gb]--;
                }
            }
        }
    }

    // 递归删除剩下后继块的死代码
    for(auto nx: dn->son)
        deleteDC(nx, gb);
}

void specialInsDelete(DomTreenode* sd, BasicBlock* gb)
{
    BasicBlock* s=sd->block;
    for(auto it = newBlock[s].begin(); it != newBlock[s].end(); it++){
        if((*it)->getType() == armInstr::mov)
        {
            armMov* mov_ai = (armMov*)(*it);

            if(VregNumofDecl(mov_ai->rd) == VregNumofDecl(mov_ai->rs)
                && (mov_ai->rd->gettype() == mov_ai->rs->gettype())){ // 如果两者是同样类型的才删去
                if(mov_ai->rs->gettype() == Decl::addr_decl){ // 如果rs是地址类型的，就不删
                    continue; // ldr r0, r0
                }
                else{ // 如果rs不是地址类型的，那么任意mov的rd 和 rs number相同的话就都能删，管你是不是regdecl
                    newBlock[s].erase(it--);
                    gbarmCnt[gb]--;
                }
            }
        }

    }

    //递归
    for(auto nx:sd->son){
        specialInsDelete(nx,gb);
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

map<RIGnode*, memoryDecl*> spill_node2memdc; // spilling失败之后，记录每个node对应放在哪里的memdecl

memoryDecl* forc_memShift(RIGnode* d, BasicBlock* gb){
    // 找得到就返回已经有了的, 没找到就new一个回去

    memoryDecl* ret_m = spill_node2memdc[d];
    if(ret_m == nullptr){
        ret_m = new memoryDecl(nullptr,gb,gblock2spbias[gb]++);
        spill_node2memdc[d] = ret_m; // 更新node到memdecl的映射
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
                && dc->gettype() != Decl::memory_decl
                && dc->gettype() != Decl::global_decl){
                    
                    if(VregNumofDecl(dc) < K-3)continue;//留三个吧,(凭直觉)
                    if(VregNumofDecl(dc) == 13)continue;//跳过r13的spill
                    armLdr* ldr_ins= new armLdr();
                    ldr_ins->rd = dc;
                    ldr_ins->rs = forc_memShift(ForCnode(make_pair(VregNumofDecl(dc),dc->gettype() == Decl::reg_decl),gb), gb);
                    it=newBlock[b].insert(it,ldr_ins)+1;
                    gbarmCnt[gb]++;
                    ldr_ins->comm = "ldr-all2mem " + to_string(spill_times);

                    // 新加出来的ldr的rd, rs都是内存变量，都需要做上标记
                    dc->decl_spill = 1; // 原来选出来的变量 TODO：是否考虑成dc->decl_spill++

                    // update nodeSpillMap
                    auto p = make_pair(VregNumofDecl(dc), dc->gettype() == Decl::reg_decl);
                    nodeSpillMap[p] = dc->decl_spill;
                }
            }

            //是否要加str: rd非空&&编号相等&&不能在一条str前加一个str指令
            if(arm_ins->rd != nullptr 
            && arm_ins->getType() != armInstr::str
            && arm_ins->rd->gettype() != Decl::reg_decl){
                
                if(VregNumofDecl(arm_ins->rd) < K-3)continue;//留三个吧,(凭直觉)
                if(VregNumofDecl(arm_ins->rd) == 13)continue;
                if(VregNumofDecl(arm_ins->rd) == 789){
                    dbg("789error");
                }
                armStr* str_ins= new armStr();
                str_ins->rd = arm_ins->rd;
                str_ins->rs = forc_memShift(ForCnode(make_pair(VregNumofDecl(arm_ins->rd),arm_ins->rd->gettype() == Decl::reg_decl),gb), gb);
                it=newBlock[b].insert(it+1,str_ins);
                gbarmCnt[gb]++;
                str_ins->comm = "str-all2mem " + to_string(spill_times);

                // 新加出来的str的rd rs，加上spill标记
                arm_ins->rd->decl_spill = 1; // 原来语句的rd

                auto p = make_pair(VregNumofDecl(arm_ins->rd), arm_ins->rd->gettype() == Decl::reg_decl);
                nodeSpillMap[p] = arm_ins->rd->decl_spill;
            }

        }
    }

}


void changeVreg(BasicBlock *gb)
{

    for(auto rigN: colors)
    {
        if(rigN.first->dc==13)continue;
        if(rigN.first->typeIsREG == true)
        { // TODO: is this right?
            continue;
        }

        int dc_vreg = rigN.first->dc;

        for(auto dc: Vreg2Decls[dc_vreg]) // 当前每一个使用这个寄存器编号的dc
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

// 比较old_in和in；判断In/Out集合是否改变
/*
map<armInstr*, set<pair<int, bool> >> ins;
map<armInstr*, set<pair<int, bool> >> old_ins;*/
bool InOutChanged()
{
    for(auto p: ins){
        if(p.second.size() != old_ins[p.first].size()){
            // 如果大小不相等，返回真
            return true;
        }
    }
    return false; // 没有改变过
}

// 创建冲突图、并判断是否能染色染出来
bool buildRIG(BasicBlock* gb)
{
    //解决常量池问题
    constpool(block2dom[gb->domBlock[0]]);

    int old_gb_ins_count = -1; // 记录上一次这个gb全局块的指令数量
    while(true)
    {
        // 0 首先记录这个gb当前的指令个数
        old_gb_ins_count = gbarmCnt[gb]; // FIXME:这里是一个map，gb对应的键值

        // 1 init clear out
        for(auto node:RIG[gb]){free(node);}
        RIG[gb].clear();
        blockVisited.clear();
        rigNodeCreated.clear();
        ins.clear();
        outs.clear();

        // 2 开始从第一个domblock递归，填满in 和 out 集合
        while(true){
            // 清空
            blockVisited.clear();

            // 把old存起来
            old_ins.clear();
            old_ins.insert(ins.begin(), ins.end());

            // 计算新的
            fillInOut(gb->domBlock[0]);

            // 对比，看是否没变了
            if(!InOutChanged())
                break;
        }

#ifdef DEBUG_ON
        // 2.5 for debug 先linshi临时打印一下这些个in 和 out
        cout << "\n\n**** IN&OUT set of " << gb->BlockName << " ****\n";
        for(auto dr: DomRoot)
            showSets(dr);     
#endif

        // 4 deleting dead code
        deleteDC(block2dom[gb->domBlock[0]], gb);

        // 5 判断，指令数量书否相同，相同就跳出去，否则就继续
        if(old_gb_ins_count == gbarmCnt[gb]) // FIXME:改为map中，gb对应的键值
            break;
    }

    //            cout << "查看int-->decls->decl_spill" << endl;
    //            cout << in_decl.first <<": ";
    //            for(auto d: Vreg2Decls[in_decl.first])
    //            {
    //                cout << d->decl_spill <<" ";
    //            }
    //            cout << endl;

    // 3 利用填好的in、out集合，建立冲突图，也是一个递归的过程
    // 在这里算出了每个node的度，以及更新这个node是否是spill的node
    connectDecl(block2dom[gb->domBlock[0]], gb);

    // 根本没有分配寄存器，直接返回真
    if(RIG[gb].size() == 0)return true;

#ifdef DEBUG_ON
    // for debug 打印整张图看看
    std::cout << "**** the RIG of " << gb->BlockName <<  "****\n";
    for(auto dnode: RIG[gb])
    {
        std::cout << ((dnode->typeIsREG) ? "r" : "") << dnode->dc << "\t";
        for(auto con_node: dnode->connectTo)
        {
            std::cout << ((con_node->typeIsREG) ? "r" : "") << con_node->dc << " ";
        }
        std::cout << "\n";
    }          
#endif
    

    // 5. filling colors!
    init_color(gb);
    paintColor(gb);

#ifdef DEBUG_ON
        std::cout << "**** Coloring information of " << gb->BlockName << " ****" << endl;
        for(auto node: RIG[gb]){
        std::cout << ((node->typeIsREG) ? "r" : "")  << node->dc << " " << colors[node]-1 << endl;
        }
#endif

    // 遍历color map，修改Vreg
    changeVreg(gb);

    // 跟新Vreg2Decls
    updateV2Ds();

    // 此条不专门针对 mov r0, r0; TODO：之后可以在里面加上针对其他ir指令的优化
    specialInsDelete(block2dom[gb->domBlock[0]],gb);


#ifdef DEBUG_ON_
    // final show instruction agian, this time with limited k registers
    std::cout << "****Arm Instruction with limited Registers ****\n";
    for(auto dr: DomRoot)
        showDecl(dr);
#endif


    if(usedK>K){ // 染色失败
#ifdef DEBUG_ON
        std::cout << gb->BlockName <<  ": Coloring failed\n";
#endif
        return false;
    }
#ifdef DEBUG_ON
        std::cout << gb->BlockName << ": Coloring OK\n";
#endif
    return true;
}

void op_ld_st(){
    //传说中的窥孔优化?
    //产出str / ldr 对
    
}

fstream debugout;
void RigsterAlloc()
{
    debugout.open("debug.txt", std::ifstream::out);

    // 对于每个顶层块（除了第一个全局模块），都应该对应一个RIG图
    for(auto gb: IR1->Blocks)
    {
        spill_times = 1;
        // 跳过第一个全局变量，core dump，可能有隐患
        if(gb->domBlock.size() == 0)continue;
        bool spill_failed = false;

        int try_times = 1;
        while(try_times <= 2){

            spill_failed = buildRIG(gb);
            if(!spill_failed) { // 染色失败
                spill_node2memdc.clear();
                all2mem(gb);
                spill_times++;
#ifdef DEBUG_ON
            std::cout << "**** add mem ****\n";
            for(auto dr: DomRoot)
                showDecl(dr);
#endif
            }
            else{ // 染色成功
                break;
            }
            try_times ++;
        }
#ifdef DEBUG_ON
        if(try_times > 2)
            cout << gb->BlockName <<" 两次强制跳出\n";
        else
            cout << gb->BlockName <<" 染色成功跳出来的\n";
#endif
        if(try_times > 2){
            spill_failed = buildRIG(gb);
        }
    }

#ifdef DEBUG_ON_
    // final show instruction agian, this time with limited k registers
    std::cout << "****Arm Instruction with limited Registers --- final ****\n";
    for(auto dr: DomRoot)
        showDecl(dr);           
#endif

    

}