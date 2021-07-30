#include"RIG.h"
#include"op_cfgFrequency.h"
// input at liveSet.h
   /*map<BasicBlock*, vector<armInstr*>> newBlock;*/

// output
map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph
map<armInstr*, set<int>> ins; // 每条arm指令对应的in集合，要记得清空
map<armInstr*, set<int>> outs; // 公用复用的out集合

// visited block 每个顶层模块内的block
map<BasicBlock*, bool> blockVisited;
// created RIGnode 该decl(现在是这个寄存器编号int)是否已经创建了对应的RIGnode
map<int, bool> rigNodeCreated;
// vregNumber 到 使用这个编号的decl 的集合，用于找到这些decl，来自LiveSet.cpp
// 这是个临时用于转存的map
map<int, vector<Decl*>> temp_Vreg2Decls;

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
    return 789;
}

void ArmI2InOut(armInstr* ai)
{//根据类型，找出每一条语句的in集合
    if(ai->getType() == armInstr::armInsType::add)
    {
        armAdd* add_ai = (armAdd*)ai; // 向子类塑性
        // out[s] - kill[s]
        ins[ai].erase(VregNumofDecl(add_ai->rd));
        // gen[s] U (out[s] - kill[s])
        ins[ai].insert(VregNumofDecl(add_ai->r0));
        add_ai->r0->gen_used.push_back(ai); // 图着色溢出的1.2
        // 当它只有是var register的时候才insert，否则就不insert
        if(notConst(add_ai->r1))
        {
            ins[ai].insert(VregNumofDecl(add_ai->r1));
            add_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::sub)
    {
        armSub* sub_ai = (armSub*)ai;
        ins[ai].erase(VregNumofDecl(sub_ai->rd));
        ins[ai].insert(VregNumofDecl(sub_ai->r0));
        sub_ai->r0->gen_used.push_back(ai);
        if(notConst(sub_ai->r1))
        {
            ins[ai].insert(VregNumofDecl(sub_ai->r1));
            sub_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::mul)
    {
        armMul* mul_ai = (armMul*)ai;
        ins[ai].erase(VregNumofDecl(mul_ai->rd));
        ins[ai].insert(VregNumofDecl(mul_ai->r0));
        ins[ai].insert(VregNumofDecl(mul_ai->r1)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mul_ai->r0->gen_used.push_back(ai);
        mul_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::div)
    {
        armDiv* div_ai = (armDiv*)ai;
        ins[ai].erase(VregNumofDecl(div_ai->rd));
        ins[ai].insert(VregNumofDecl(div_ai->r0));
        ins[ai].insert(VregNumofDecl(div_ai->r1)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        div_ai->r0->gen_used.push_back(ai);
        div_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::mod)
    {
        armMod* mod_ai = (armMod*)ai;
        ins[ai].erase(VregNumofDecl(mod_ai->rd));
        ins[ai].insert(VregNumofDecl(mod_ai->r0));
        ins[ai].insert(VregNumofDecl(mod_ai->r1)); // 由于ssa处已经将三个操作数都确保成了寄存器，因此这里就不判断是否为立即数了
        mod_ai->r0->gen_used.push_back(ai);
        mod_ai->r1->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::mov)
    {
        armMov* mov_ai = (armMov*)ai;
        ins[ai].erase(VregNumofDecl(mov_ai->rd));
        if(notConst(mov_ai->rs))
        {
            ins[ai].insert(VregNumofDecl(mov_ai->rs));
            mov_ai->rs->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::cmp)
    {
        armCmp* cmp_ai = (armCmp*)ai;
        // cmp 指令没有kill集合，因此没有decl来erase，只有两个操作数来进行insert
        ins[ai].insert(VregNumofDecl(cmp_ai->r0));
        cmp_ai->r0->gen_used.push_back(ai);
        if(notConst(cmp_ai->r1))
        {
            ins[ai].insert(VregNumofDecl(cmp_ai->r1));
            cmp_ai->r1->gen_used.push_back(ai);
        }
    }
    else if(ai->getType() == armInstr::armInsType::str)
    {
        armStr* str_ai = (armStr*)ai;
        //str指令是的rd是gen集
        ins[ai].insert(VregNumofDecl(str_ai->rd));
        str_ai->rd->gen_used.push_back(ai);
    }
    else if(ai->getType() == armInstr::armInsType::ldr)
    {
        armLdr* ldr_ai = (armLdr*)ai;
        //ldr指令是的rd是kill集
        ins[ai].erase(VregNumofDecl(ldr_ai->rd));
    }
    else if(ai->getType() == armInstr::armInsType::call)
    {
        armCall* call_ai = (armCall*)ai;
        // call 有返回值，需要kill掉
        if(call_ai->rd != NULL)
            ins[ai].erase(VregNumofDecl(call_ai->rd));

        // rs内全是gen
        for(auto r: call_ai->rs)
        {
            if(notConst(r))
            {
                ins[ai].insert(VregNumofDecl(r));
                r->gen_used.push_back(ai);
            }
        }

    }
    else if(ai->getType() == armInstr::armInsType::ret)
    {
        armRet* ret_ai = (armRet*)ai;

        // rs is gen
        if(ret_ai->rs != NULL)
            if(notConst(ret_ai->rs))
            {
                ins[ai].insert(VregNumofDecl(ret_ai->rs));
                ret_ai->rs->gen_used.push_back(ai);
            }
    }
    else if(ai->getType() == armInstr::rsb)
    {// r1 maybe imm/const, but r0 is var_decl for sure
        armRsb* rsb_ai = (armRsb*)ai;
        ins[ai].erase(VregNumofDecl(rsb_ai->rd));
        ins[ai].insert(VregNumofDecl(rsb_ai->r0));
        rsb_ai->r0->gen_used.push_back(ai);
        if(notConst(rsb_ai->r1))
        {
            ins[ai].insert(VregNumofDecl(rsb_ai->r1));
            rsb_ai->r1->gen_used.push_back(ai);
        }
    }



}

void fillInOut(BasicBlock* bb)
{// 不断访问后继，直到访问到最后一个没有没有后继的block，一步一步算in 和 out

//    dbg(block2lb[bb]);
    if(blockVisited[bb]) return; // 若已经访问过，则跳过
    blockVisited[bb] = true; // 标记访问

    // 若根本没有这个block的键值，直接返回（其实是出错了）；若当前block下根本没有指令，直接返回
    if(newBlock.count(bb) == 0 || newBlock[bb].size() == 0) return;

    armInstr* last_b_ins=newBlock[bb][newBlock[bb].size() - 1];
//    dbg(*last_b_ins);
    outs[last_b_ins]={};
    for(auto succ: bb->succBlock)
    {// 先不断访问后继，递归下去
        fillInOut(succ);
        // out[s] = U in[p] 把后继的第一条指令对应的 in 集合 放入当前指令的out集合

        // 如果它后继也一行代码也没有，也直接?????了，否则core dump
        if(newBlock.count(succ) == 0 || newBlock[succ].size() == 0) continue;
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
//        dbg(ins[arm_ins].size());
        cout << "\tins: ";
        for(auto in_decl: ins[arm_ins])
            cout << "r" << in_decl << " ";
        cout << "\touts: ";
        for(auto out_decl: outs[arm_ins])
            cout << "r"  << out_decl << " ";
        cout << "\n";
    }
    // 递归打印剩下的
    for(auto nx: dn->son)
    {
        showSets(nx);
    }
}

RIGnode* ForCnode(int d, BasicBlock* gb)
{
    RIGnode* ret_n;
    if(rigNodeCreated[d])
    {//建立过，在已有的graph中找出来
        for(auto existNode: RIG[gb])
        {
            if(existNode->dc == d)
            {
                ret_n = existNode;
                break;
            }
        }
    }
    else
    {//没建立过，new出来
        ret_n = new RIGnode(d);
        rigNodeCreated[d] = true;
        RIG[gb].push_back(ret_n);
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
map<RIGnode*, int> colors;
queue<RIGnode*> que;//queue of filling color with BFS

const int K = 3;// number of Rigster
int usedK;

void init_color()
{
    usedK =0;
    colors.clear();
}

vector<RIGnode*> s_point; // 起点

bool check_ok(RIGnode* n, int c)
{
    for(auto con: n->connectTo){
        if(!colors[con])continue;
        if(colors[con]==c)return false;
    }
    return true;
}

bool paintColor(BasicBlock* gb){
    //1. 找到所有起点;
    int maxdu=-1;
    s_point.clear();
    for(auto node: RIG[gb]){
        if(colors[node])continue;

        if((int)node->connectTo.size()>maxdu){
            s_point.clear();
            s_point.push_back(node);
            maxdu=node->connectTo.size();
        }
        else if(node->connectTo.size()==maxdu)s_point.push_back(node);
    }
    //1.1random
    random_shuffle(s_point.begin(),s_point.end());
    //1.2 add s_point
    colors[s_point[0]]=usedK == 0 ? ++usedK : 1; // 非联通的图可以重新使用1
    que.push(s_point[0]);
    //2. BFS coloring
    while(!que.empty()){
        RIGnode* now = que.front();
        que.pop();
        // 随机的访问now所连的点
        random_shuffle(now->connectTo.begin(),now->connectTo.end());
        for(auto nx:now->connectTo){
            //对nx尝试每一种颜色
            if(colors[nx])continue;
            for(int i=1;i<=usedK;i++){
                if(check_ok(nx,i)){
                    colors[nx]=i;
                    que.push(nx);
                    break;
                }
            }
            if(colors[nx]==0){
                colors[nx]=++usedK;
            }
        }
    }
    for(auto node: RIG[gb]){
        if(colors[node]==0)return paintColor(gb);
    }
    return true;
}

void deleteDC(DomTreenode* dn, BasicBlock* gb)
{
    bool findDc;
    BasicBlock* b = dn->block;
    for(auto it = newBlock[b].begin(); it != newBlock[b].end(); it++)
    {
        if((*it)->rd != NULL)
        {
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
                newBlock[b].erase(it--);
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
            if(VregNumofDecl(mov_ai->rd) == VregNumofDecl(mov_ai->rs))
            {// 两个寄存器的number一样的话就删除
                newBlock[s].erase(it--);
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

void addMemoryOperation(BasicBlock* gb)
{
    // 计算cost
    spillCost(gb);

    // 选出cost最小的dc
    double mincost = 1e18;
    for(auto node : RIG[gb]){
        int dc_vreg= node->dc;
        if(spilling_cost[dc_vreg]<mincost){
            mincost = spilling_cost[dc_vreg];
            chosenOne = dc_vreg;
        }
    }
    memoryDecl* memShift = new memoryDecl(nullptr,gb,++gblock2spbias[gb]);
    for(auto b : gb->domBlock){
        for(auto it = newBlock[b].begin();it!=newBlock[b].end();it++){
            dbg(**it);
            auto arm_ins = *it;

            //是否要加ldr
            vector<Decl*> rs = arm_ins->getGen();
            for(auto dc : rs){
                if(VregNumofDecl(dc)==chosenOne){
                    armLdr* ldr_ins= new armLdr();
                    ldr_ins->rd = dc;
                    ldr_ins->rs = memShift;
                    it=newBlock[b].insert(it,ldr_ins)+1;
                    dbg(**it);
                }
            }

            //是否要加str
            if(arm_ins->rd != nullptr && VregNumofDecl(arm_ins->rd)==chosenOne && arm_ins->getType()!=armInstr::str){
                armStr* str_ins= new armStr();
                str_ins->rd = arm_ins->rd;
                str_ins->rs = memShift;
                it=newBlock[b].insert(it+1,str_ins);
               dbg(**it);

            }
        }
    }
}

void changeVreg()
{
    for(auto rigN: colors)
    {
        int dc_vreg = rigN.first->dc;

        for(auto dc: Vreg2Decls[dc_vreg])
        {// 就将每一个decl的vreg批量改了
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

void updateV2Ds()
{
     // init
    temp_Vreg2Decls.clear();

    // 存入temp_Vreg2Decls
    for(auto p: Vreg2Decls)
    {
        for(auto dc: p.second)
        {
            temp_Vreg2Decls[VregNumofDecl(dc)].push_back(dc);
        }
    }

    // deep copy
    Vreg2Decls.clear();
    Vreg2Decls.insert(temp_Vreg2Decls.begin(), temp_Vreg2Decls.end());
}


bool buildRIG(BasicBlock* gb)
{
    srand(time(0));
    // 1 init: clear the ins and outs sets
    dbg("neho -- init: clear sets and graph");

    int times_deadCode = 10;
    while(times_deadCode--)
    {
        // 1.5 init clear out
        for(auto node:RIG[gb]){free(node);}
        RIG[gb].clear();
        blockVisited.clear();
        rigNodeCreated.clear();
        ins.clear();
        outs.clear();

        // 2 开始从第一个domblock递归，填满in 和 out 集合
        int times_RIG = 5;
        while(times_RIG--)
            fillInOut(gb->domBlock[0]);

        // 2.5 for debug 先临时打印一下这些个in 和 out
//            cout << "**** IN&OUT set of every armIns ****\n";
//            for(auto dr: DomRoot)
//                showSets(dr);

        // 3 利用填好的in、out集合，建立冲突图，也是一个递归的过程
        connectDecl(block2dom[gb->domBlock[0]], gb);

        // 4 deleting dead code
        deleteDC(block2dom[gb->domBlock[0]], gb);
//        dbg("---------------------------------------");
//        for(auto dr: DomRoot)
//            showDecl(dr);
    }
    dbg("neho -- fill in/out sets");
    dbg("neho -- RIG created");
    // 3.5 for debug 打印整张图看看
    cout << "**** the RIG of " << gb->BlockName <<  "****\n";
    for(auto dnode: RIG[gb])
    {
        cout << "r" << dnode->dc << "\t";
        for(auto con_node: dnode->connectTo)
        {
            cout << "r" << con_node->dc << " ";
        }
        cout << "\n";
    }
    dbg("neho -- show RIG win");

    // 5. filling colors!
    int success=0;
    trytimes = 5;
    while(trytimes--){
        init_color();
        if(paintColor(gb)){
            //如果成功了就break; 否则使用颜色过多就再试一次（最多5次）
            if(usedK <= K)break;
        }
    }

    // 4.1 遍历color map，修改Vreg
    changeVreg();

    // 跟新Vreg2Decls
    updateV2Ds();

    // 此条不专门针对 mov r0, r0; TODO：之后可以在里面加上针对其他ir指令的优化
    specialInsDelete(block2dom[gb->domBlock[0]]);
    dbg("specialIns Deleted");

    if(usedK>K){ // 染色失败
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
//        int temp_debug = 0;
        while(!buildRIG(gb)){
//            if(temp_debug++ > 6)break;
            dbg("染色失败！");
            //TODO: 如果图着色失败了，add memory operation.
            if(whenToadd++ > WHENTOMO)
                addMemoryOperation(gb);
            dbg(chosenOne);
            // 打印cost
            for(auto p: spilling_cost)
            {
                cout << p.first <<"\t" << p.second <<endl;
            }

            for(auto dr: DomRoot)
                showDecl(dr);
        }
    }

    // final show instruction agian, this time with limited k registers
    cout << "****winwin Arm Instruction with limited Registers ****\n";
    for(auto dr: DomRoot)
        showDecl(dr);
}