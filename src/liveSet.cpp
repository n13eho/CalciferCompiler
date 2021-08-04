#include"../include/liveSet.h"
#include"dbg.h"

/*
input: IR1 with phi
output: newIR
*/

map<BasicBlock*, string> block2lb;
map<BasicBlock*, int> gblock2spbias;
int Bcnt;
string lb=".LB";
int Rcnt=14;

map<int, vector<Decl*>> Vreg2Decls;

// because of array
map<ArrayValue*, Decl> arrayAddr;

///////////////
ostream& operator<<(ostream&out,const armInstr& a){
    return a.output(out);
}
ostream& operator<<(ostream&out,const Decl& a){
    return a.output(out);
}
///////////////

map<BasicBlock*, vector<armInstr*>> newBlock;
map<armInstr*,Instruction*> trance;

void strGlobal(Instruction* instr, BasicBlock* node, Decl* src)
{
    //src以前是个全局变量
    //添加load指令
    armLdr* load_arm = new armLdr();
    addrDecl *rdd = new addrDecl(src->rawValue,node,Rcnt++);
    load_arm->rd=rdd;
    globalDecl* gval = new globalDecl(src->rawValue,src->rawBlock,src->rawValue->VName);
    load_arm->rs=gval;

    newBlock[node].push_back(load_arm);
    trance[load_arm]=instr;
    
    //添加str指令
    armStr* str_arm = new armStr();
    str_arm->rd = src;
    str_arm->rs = rdd;
    newBlock[node].push_back(str_arm);
    trance[str_arm]=instr;
    
    //还需要更新寄存器中的全局变量, 再加一条load到本身的
    armLdr* ldr_arm = new armLdr();
    varDecl* gbnew = new varDecl(gval->rawValue,src->rawBlock,rdd->Vreg);
    ldr_arm->rd = gbnew;
    ldr_arm->rs = rdd;
    newBlock[node].push_back(ldr_arm);
    trance[ldr_arm]=instr;
    
}

void assignMov(Instruction* instr, BasicBlock* node)
{
    if(instr->getResult()->getType() ==2&&instr->getOp().size()<1)
        return;//屏蔽掉未初始化数组alloc后的第一句......

    armMov *ins=new armMov();
    newBlock[node].push_back(ins);
    trance[ins]=instr;
    if(instr->getResult()->getType()==1){
        IntegerValue* rd=(IntegerValue*)instr->getResult();
        varDecl *rdd = new varDecl(rd,node,Rcnt++);
        ins->rd=rdd;
        if(instr->getResult()->getScope()=="1"&&instr->getResult()!=instr->getOp()[0]){
            //目标如果是一个全局变量，那么应该在赋值完加入两条指令，用于更新全局段
            //否则，多个函数更新无法保存
            //第二个条件是跳过加载全局变量从地址到内容的assign
            strGlobal(instr,node,rdd);
        }
    }
    else{
        //如果是数组就用一个addrdecl
        ArrayValue* rd=(ArrayValue*)instr->getResult();
        addrDecl *rdd = new addrDecl(rd,node,Rcnt++);
        ins->rd=rdd;
    }
}
void assignAdd(Instruction* instr,BasicBlock *node)
{
    armAdd *ins=new armAdd();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    //这里只关心赋值.
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;
    //newblock多了一条指令
    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignMul(Instruction* instr,BasicBlock *node)
{
    armMul *ins=new armMul();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;
    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignDiv(Instruction* instr,BasicBlock *node)
{
    armCall *ins=new armCall();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;

    ins->funcname = "__aeabi_idiv";

    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignMod(Instruction* instr,BasicBlock *node)
{
    armCall *ins=new armCall();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;

    ins->funcname = "__aeabi_idivmod";

    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignSub(Instruction* instr,BasicBlock *node)
{
    IntegerValue* res=(IntegerValue*)instr->getResult();
    IntegerValue* r0=(IntegerValue*)instr->getOp()[0];
    varDecl *resd = new varDecl(res,node,Rcnt++);
    if(r0->isConst){
        armRsb *ins=new armRsb();
        ins->rd = resd;
        newBlock[node].push_back(ins);
        trance[ins]=instr;
    }
    else{
        armSub *ins=new armSub();
        ins->rd = resd;
        newBlock[node].push_back(ins);
        trance[ins]=instr;
    }
}
void assignPhi(Instruction* instr,BasicBlock*node)
{
    Value* val=instr->getOp()[0];    
    varDecl* rd = new varDecl(val, node, Rcnt++);
    for(auto pred : node->pioneerBlock){
        //有phi的block中,前驱不一定都存在着val的decl,先把没有的去掉
         int fl=0;
         for(auto b:ssaIR->AssbyBlock[val]){
             if(b==pred){fl=1;break;}
         }
         if(!fl)continue;
        //删掉不对啊..........
        armMov* ins = new armMov();
        ins->rd=rd;
        auto pos = newBlock[pred].end();
        //找到第一个不是跳转的指令.
        while(((*(--pos))->getType() >= armInstr::beq && (*(pos))->getType() <= armInstr::b || 
            (*(pos))->getType() == armInstr::ret || 
            (*(pos))->getType() == armInstr::call && (*(pos))->rd->rawValue!=val))
        {
            if(pos==newBlock[pred].begin())break;//防止RE
        }
        if(!((*(pos))->getType() >= armInstr::beq && (*(pos))->getType() <= armInstr::b ||
            (*(pos))->getType() == armInstr::ret ||
            (*(pos))->getType() == armInstr::call && (*(pos))->rd->rawValue!=val))pos++;
        newBlock[pred].insert(pos,ins);
        trance[ins]=instr;
    }
}
void assignLdr(Instruction* instr, BasicBlock* node)
{
    //TODO: 形参的数组,,, 先不写了.(可能碰巧能运行,也不知道为什么鲁棒性这么强~)
    Value *rdval = instr->getResult();
    armLdr* ins = new armLdr();
    if(rdval->getScope()=="1"&&rdval->getType()<=2){
        //全局变量(数组或者单个)的话, 目标寄存器就应该是个地址
        addrDecl *rd = new addrDecl(rdval,node,Rcnt++);
        ins->rd=rd;
        trance[ins]=instr;
    }
    else{
        //普通形参, 目标寄存器是var
        //数组的某个数, 目标寄存器是var
        varDecl *rd = new varDecl(rdval,node,Rcnt++);
        ins->rd=rd;
        trance[ins]=instr;
    }
    if(rdval->getScope()=="1"&&rdval->getType()<=2){
        // 全局变量就可以写全了
        globalDecl* rs = new globalDecl(rdval, node, rdval->VName);
        ins->rs=rs;
    }
    // else if(rdval->isPara>4){
    //     //形参也可以写全
    //     memoryDecl* rs = new memoryDecl(rdval, node);

    //     //第5个形参放在sp+4的位置, 第6个形参放在sp+8的位置, 依此类推...
    //     int id=rdval->isPara-4;
    //     rs->bias = id;
    //     ins->rs=rs;am
    // }
    newBlock[node].push_back(ins);
}
void assignStr(Instruction* instr, BasicBlock* node)
{
    Value *rdval = instr->getOp()[0];
    armStr* ins = new armStr();
    //str 比较特殊，创建好写rs就行
    if(rdval->getScope()=="1"&&rdval->getType()==1){
        globalDecl* rs = new globalDecl(rdval, node, rdval->VName);
        ins->rs=rs;
    }
    else if(rdval->getType() == 2){
        //这里应该用已经定义过的数组    array, index, 目标
        //应该增加一条 add index, 数组首地址, index 
        IntegerValue* index_val = (IntegerValue*)instr->getOp()[1];
        if(index_val->isConst==0){
            armAdd* calId = new armAdd();
            addrDecl* index = new addrDecl(index_val, node, Rcnt++);
            calId->rd = index;
            trance[calId]=instr;
            newBlock[node].push_back(calId);
        }
        
    }
    else if(rdval->isPara>4){
        memoryDecl* rs = new memoryDecl(rdval, node);
        int id=rdval->isPara-4;
        rs->bias = id*(-4);
        ins->rs=rs;
    }

    //如果要str的是一个立即数，需要先把立即数mov到寄存器中!
    IntegerValue* imm = (IntegerValue*)instr->getOp()[2];
    if(imm->isConst==1){
        armMov* immIns = new armMov();
        varDecl* imm_decl = new varDecl(instr->getOp()[2],node, Rcnt++);
        immIns->rd = imm_decl;
        constDecl* const_imm = new constDecl(instr->getOp()[2],node,imm->RealValue);
        immIns->rs = const_imm;
        trance[immIns]=instr;
        newBlock[node].push_back(immIns);
    }

    trance[ins]=instr;
    newBlock[node].push_back(ins);
}
void assignLogic(Instruction* instr, BasicBlock* node, BasicBlock* nex)
{
    // 一个cmp指令
    armCmp* ins = new armCmp();
    newBlock[node].push_back(ins);
    trance[ins]=instr;

    // 只要zyh加了短路就可以不赋值了,直接生成跳转指令
    if(instr->getOpType()==Instruction::ArithNeq)
    {
        armBne * insb = new armBne();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithEq)
    {
        armBeq * insb = new armBeq();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithLQ)
    {
        armBle * insb = new armBle();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithLT)
    {
        armBlt * insb = new armBlt();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithBG)
    {
        armBgt * insb = new armBgt();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    else if(instr->getOpType()==Instruction::ArithGQ)
    {
        armBge * insb = new armBge();
        newBlock[node].push_back(insb);
        insb->lb=block2lb[nex];
    }
    
}
void assignjmp(Instruction* instr, BasicBlock* node)
{
    armB* ins = new armB();
    newBlock[node].push_back(ins);
    ins->lb = block2lb[instr->jmpDestBlock];
}
void assignCall(Instruction* instr, BasicBlock* node)
{
    //TODO: 目前的想法时甩锅到代码生成, 这里就先沿用四元式的表示;如果发现可以解决记得回来改哦!
    armCall* ins = new armCall();
    newBlock[node].push_back(ins);
    trance[ins]=instr;
    ins->funcname = instr->getOp()[0]->VName;
    //返回值.
    IntegerValue* rd=(IntegerValue*)instr->getResult();
    varDecl *rdd = new varDecl(rd,node,Rcnt++);
    ins->rd=rdd;
}
void assignRet(Instruction* instr, BasicBlock* node)
{
    //TODO: ret有描述不出的锅 >.<;
    armRet* ins = new armRet();
    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignNeg(Instruction* instr, BasicBlock* node)
{
    armRsb* ins = new armRsb();
    IntegerValue* res=(IntegerValue*)instr->getResult();
    varDecl *resd = new varDecl(res,node,Rcnt++);
    ins->rd = resd;

    newBlock[node].push_back(ins);
    trance[ins]=instr;
}
void assignNot(Instruction* instr, BasicBlock* node)
{
    //翻译成一个比较指令和一个条件mov
    armCmp* ins = new armCmp();
    newBlock[node].push_back(ins);
    trance[ins]=instr;

    IntegerValue* res=(IntegerValue*)instr->getResult();
    varDecl *resd = new varDecl(res,node,Rcnt++);

    armMoveq* inseq =new armMoveq();
    inseq->rd = resd;
    armMovne* insne =new armMovne();
    insne->rd = resd;

    newBlock[node].push_back(inseq);
    trance[inseq]=instr;
    newBlock[node].push_back(insne);
    trance[insne]=instr;
}

void assignIns(Instruction* ins,BasicBlock* node)
{//依照不同类型的指令，计算赋值,同时填newblock, 分支指令除外
    if(ins->getOpType() == Instruction::Add)
    {
        assignAdd(ins,node);
    }
    if(ins->getOpType() == Instruction::Sub)
    {
        assignSub(ins,node);
    }
    else if(ins->getOpType() == Instruction::Mul)
    {
        assignMul(ins,node);
    }
    else if(ins->getOpType() == Instruction::Div)
    {
        assignDiv(ins,node);
    }
    else if(ins->getOpType() == Instruction::Mod)
    {
        assignMod(ins,node);
    }
    else if(ins->getOpType() == Instruction::Assign)
    {
        assignMov(ins,node);
    }
    else if(ins->getOpType() == Instruction::Jmp)
    {
        assignjmp(ins,node);
    }
    else if(ins->getOpType() == Instruction::Load)
    {
        assignLdr(ins,node);
    }
    else if(ins->getOpType() == Instruction::Store)
    {
        assignStr(ins,node);
    }
    else if(ins->getOpType() == Instruction::Call)
    {
        assignCall(ins,node);
    }
    else if(ins->getOpType() == Instruction::Ret)
    {
        assignRet(ins,node);
    }
    else if(ins->getOpType() == Instruction::UnaryNeg)
    {
        assignNeg(ins,node);
    }
    else if(ins->getOpType() == Instruction::UnaryNot)
    {
        assignNot(ins,node);
    }
    else if(ins->getOpType() == Instruction::Alloc){
        if(ins->getOp()[0]->getType() == 2){
            //只有alloc是数组的时候才需要处理
            ArrayValue* array =(ArrayValue*) ins->getOp()[0];//被声明的定义

            armAdd* calAddr = new armAdd();//用一个加指令计算数组首地址
            addrDecl* rd = new addrDecl(array, node, Rcnt++);
            calAddr->rd = rd;
            varDecl* r0 = new varDecl(nullptr, node, 13);//这是sp寄存器
            calAddr->r0=r0;
            constDecl* r1 = new constDecl(nullptr, node, (gblock2spbias[node->parent_]+1)*4);//这是数组首地址偏移，从低地址向高地址存
            calAddr->r1=r1;
            int size = ((IntegerValue*)ins->getOp()[1])->RealValue;
            gblock2spbias[node->parent_]+=size;
            
            newBlock[node].push_back(calAddr);
            trance[calAddr]=ins;//添加指令
        }
    }
}
void setDecl(BasicBlock *s)
{
    for(auto id=s->InstrList.begin();id!=s->InstrList.end();++id){
        int i = *id;
        auto ins =IR1->InstList[i];
        if(ins->getOpType() >= Instruction::ArithEq && ins->getOpType()<=Instruction::ArithGQ){
            auto insbT=IR1->InstList[i+1];
            assignLogic(ins,s,insbT->jmpDestBlock);
        }
        else assignIns(IR1->InstList[i],s);
    }
    DomTreenode* node=block2dom[s];
    for(auto son:node->son){
        setDecl(son->block);
    }    
}

map<BasicBlock*, set<Decl*>> reachin,reachout;
map<BasicBlock*, bool> visReach;
map< pair<Value*,BasicBlock*>, vector<Decl*> > Assign_rec;

void calReach(BasicBlock* s)
{
    visReach[s]=1;
    reachout[s]=reachin[s];
    for(auto ins:newBlock[s]){
        //减去这个语句定义的decl对应的val的decl
        Decl* dc=ins->rd;//这个语句对应的decl
        if(dc == nullptr)continue;
        Value* val=dc->rawValue;//要修改的val
        for(auto dead=reachout[s].begin();dead!=reachout[s].end(); ){
            Decl* deadDc=*dead;//当前在集合中的decl
            if(deadDc->rawValue==val){
                dead=reachout[s].erase(dead);
            }
            else
                dead++;
        }
        //加上这个语句定义的decl
        reachout[s].insert(dc);
    }
    for(auto suc:s->succBlock){
        //完善后继的reachin
        for(auto i : reachout[s]){
            reachin[suc].insert(i);
        }
        if(!visReach[suc])calReach(suc);
    }
}

void addAssign(Value* val, BasicBlock* node, Decl* dc)
{
    auto key=make_pair(val,node);
    Assign_rec[key].push_back(dc);
}

Decl* getDecl(Value* val, BasicBlock* node)
{
//    dbg(val->VName);
    if(val->getType()==1){
        IntegerValue* intval = (IntegerValue*)val;
        if(intval->isConst&&Assign_rec[make_pair(intval,node)].size()==0){
            //常数的话,直接新建一个返回
            constDecl* ret=new constDecl(intval,node,intval->RealValue);
            return ret;
        }
        else{
            //其他就返回上一次赋值
            return Assign_rec[make_pair(intval,node)].back();
        }
    }
    else if(val->getType() == 4){
        ImmValue* intval = (ImmValue*)val;
        constDecl* ret=new constDecl(intval,node,intval->RealValue);
        return ret;
    }
    else if(val->getType()==2)
    {
        return Assign_rec[make_pair(val,node)].back();
    }
    else {return NULL;}
}

void usedAdd(armAdd* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    if(raw->getOpType() == Instruction::Alloc){
        addAssign(ins->rd->rawValue,node, ins->rd);
        return ;
    }
    if(raw->getOpType() == Instruction::Store){
        //这是一条计算数组下标的语句
        ins->r0 = getDecl(raw->getOp()[0],node);
        ins->r1 = getDecl(raw->getOp()[1],node);
        addAssign(ins->rd->rawValue,node,ins->rd);
        ins->isAddr=1;
        return;
    }
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    if(r0->isConst)swap(r0,r1);
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedMul(armMul* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedDiv(armDiv* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedMod(armMod* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedSub(armSub* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
    if(r0->isConst)swap(r0,r1);
    ins->r0 = getDecl(r0,node);
    ins->r1 = getDecl(r1,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedRsb(armRsb* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0 = (IntegerValue*)raw->getOp()[0];
    if(raw->getOp().size()==1){
        // 说明这是个单目运算，-
        ins->r1 = new constDecl(nullptr,node,0);
    }
    else{
        IntegerValue* r1 = (IntegerValue*)raw->getOp()[1];
        if(r0->isConst)swap(r0,r1);
        ins->r1 = getDecl(r1,node);
    }
    ins->r0 = getDecl(r0,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
}
int usedMov(armMov* ins, BasicBlock* node)
{
    Instruction* raw = trance[ins];
    if(raw->getOpType() == Instruction::Store){
        //为了处理str立即数特别加上的一条mov指令
        addAssign(ins->rd->rawValue,node,ins->rd);
        return 0;
    }
    IntegerValue* rs ;
    if(raw->getOp().size())rs= (IntegerValue*)raw->getOp()[0];
    else {
        IntegerValue* temval = (IntegerValue*)ins->rd->rawValue;
        rs= new IntegerValue("tt",-1,"",1);//这里对于没有初值的变量的处理
        if(temval->isConst) rs->RealValue=temval->RealValue;//如果是常量初始化
    }
    if(raw->getOpType()==Instruction::Phi){
        if(Assign_rec[make_pair(rs,node)].size()==0){
            dbg("phi对这个块没意义");
            dbg(raw->getOp()[0]->VName);
            return -1;
        }
    }
    ins->rs = getDecl(rs,node);
    addAssign(ins->rd->rawValue,node,ins->rd);
    return 0;
}
void usedCmp(armCmp* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    IntegerValue* r0=(IntegerValue*)raw->getOp()[0];
    IntegerValue* r1=(IntegerValue*)raw->getOp()[1];
    if(r0->isConst)swap(r0,r1);
    ins->r1 = getDecl(r1,node);
    ins->r0 = getDecl(r0,node);
}
void usedLdr(armLdr* ins,BasicBlock* node)
{
    Instruction* raw = trance[ins];
    if(raw == nullptr){
        //raw对应的指令为空的话, 这就是一条为了加载多余形参而添加的load,只需要更新形参的assign_rec就行.
        addAssign(ins->rd->rawValue,node,ins->rd);
        return ;
    }
    Value* rawop = raw->getOp()[0];
    if(rawop->getType()==2){ // 2是数组
        if(rawop->isPara>4){ // 形参第5+是数组
            ins->rs = getDecl(rawop,node);
            ins->bias = ((IntegerValue*)raw->getOp()[1])->RealValue+1;
        }
        else if(raw->getOp().size()<2){ // 是因为要使用全局数组，加载进来
        }
        else{
            ins->rs = getDecl(rawop,node);
            ins->bias = ((IntegerValue*)raw->getOp()[1])->RealValue+1;
        }
    }
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedStr(armStr* ins,BasicBlock* node)
{
    //str 应该没有需要链接的目的操作数
    //源操作数是rd！！！！(至少global是这样)
    Instruction* raw = trance[ins];
    if(raw->getOp().size()>1){
        //这说明是一个数组的str
        IntegerValue* r2=(IntegerValue*)raw->getOp()[2]; //这个是要存的数
        IntegerValue* r1=(IntegerValue*)raw->getOp()[1]; //这个是数据的index
        ArrayValue* r0=(ArrayValue*)raw->getOp()[0]; //将存入的数组
        ins->rd = getDecl(r2,node);

        if(r1->isConst){
            ins->bias = r1->RealValue+1;
            ins->rs = getDecl(r0,node);
        }
        else{
            ins->rs = getDecl(r1,node);
        }
    }
    else if(raw->getResult()&& raw->getResult()->getScope()=="1"){
        //这是一个为了更新全局变量而诞生的指令, rd已经填过了，但是rs还是没有填。
        IntegerValue* r0=(IntegerValue*)ins->rd->rawValue;
        ins->rs = getDecl(r0,node);
    }
    else{
        // 这说明是一个局部变量和形参
        IntegerValue* r0=(IntegerValue*)raw->getResult();
        ins->rd = getDecl(r0,node);
    }
}
void usedCall(armCall* ins, BasicBlock* node)
{
    Instruction* raw =trance[ins];
    for( auto val :raw->getOp()){
        Decl* r = getDecl(val,node);
        if(r)ins->rs.push_back(r);
    }
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedRet(armRet* ins, BasicBlock* node)
{
    Instruction* raw =trance[ins];
    if(raw->getOp().size()==0)return ;
    IntegerValue* r0=(IntegerValue*)raw->getOp()[0];
    ins->rs = getDecl(r0,node);
}
void usedMoveq(armMoveq* ins, BasicBlock* node)
{
    addAssign(ins->rd->rawValue,node,ins->rd);
}
void usedMovne(armMovne* ins, BasicBlock* node)
{
    addAssign(ins->rd->rawValue,node,ins->rd);
}

int usedIns(armInstr* ins,BasicBlock* node)
{
    if(ins->getType()==armInstr::mov){
        return usedMov((armMov*)ins,node);
    }
    else if(ins->getType() == armInstr::add){
        usedAdd((armAdd*)ins,node);
    }
    else if(ins->getType() == armInstr::mul){
        usedMul((armMul*)ins,node);
    }
    else if(ins->getType() == armInstr::div){
        usedDiv((armDiv*)ins,node);
    }
    else if(ins->getType() == armInstr::mod){
        usedMod((armMod*)ins,node);
    }
    else if(ins->getType() == armInstr::sub){
        usedSub((armSub*)ins,node);
    }
    else if(ins->getType() == armInstr::rsb){
        usedRsb((armRsb*)ins,node);
    }
    else if(ins->getType() == armInstr::cmp){
        usedCmp((armCmp*)ins,node);
    }
    else if(ins->getType() == armInstr::str){
        usedStr((armStr*)ins,node);
    }
    else if(ins->getType() == armInstr::ldr){
        usedLdr((armLdr*)ins,node);
    }
    else if(ins->getType() == armInstr::call){
        usedCall((armCall*)ins,node);
    }
    else if(ins->getType() == armInstr::ret){
        usedRet((armRet*)ins,node);
    }
    else if(ins->getType() == armInstr::moveq){
        usedMoveq((armMoveq*)ins,node);
    }
    else if(ins->getType() == armInstr::movne){
        usedMovne((armMovne*)ins,node);
    }
    return 0;
}

void setUsed(BasicBlock* s)
{
    //init:把reachin里的定义建立好
    for(auto dc : reachin[s]){
        if(s->BlockName=="ifNext"){
            dbg(*dc);
        }
        addAssign(dc->rawValue,s,dc);
    } 
    
    //对于每一条语句填used
    for(auto ins=newBlock[s].begin();ins!=newBlock[s].end();){
        if(usedIns(*ins,s)==-1){
            ins=newBlock[s].erase(ins);
        }
        else ins++;
    }

}

void showDecl(DomTreenode* sd)
{
    BasicBlock* s=sd->block;
    cout<<endl;
    cout<<block2lb[s]<<':'<<endl;
    for(auto ins:newBlock[s]){
        // cout<<'\t';
        cout<<*ins<<endl;
    }
    for(auto nx:sd->son){
        showDecl(nx);
    }
}

void liveSets()
{
    //0. 添加label
    for(auto b:IR1->Blocks){
        for(auto eb: b->domBlock){
            block2lb[eb]=lb+to_string(Bcnt++);
            newBlock[eb]={};
        }
    }
//    dbg("syy -- add label win!");
    // 1. 转换Decl
    for(auto rt:DomRoot){
        setDecl(rt->block);
    }
//    dbg("syy -- set Decl win!");
    //1.1 最后才能考虑phi
    for(auto b:phiPos){
        for(auto i:b->InstrList){
            if(IR1->InstList[i]->getOpType()==Instruction::Phi){
                assignPhi(IR1->InstList[i],b);
            }
        }
    }
//    dbg("syy -- work phi win!");
    //2. 计算reachin和reachout,这里先迭代5次
    
    //2.0 添加形参load指令
    for(auto rt:DomRoot){
        auto b1=rt->block;
        FunctionValue* func=rt->func;
        for(auto i=4;i<func->FuncParams.size();i++){
            //后面的参数需要从mem里load出来使用
            armLdr* ldr_ins = new armLdr();
            varDecl* rd = new varDecl(func->FuncParams[i],b1,Rcnt++);
            ldr_ins->rd = rd;
            memoryDecl* rs = new memoryDecl(func->FuncParams[i],b1,i-3);
            ldr_ins->rs = rs;
            //把这条指令加到这个函数调用的入口
            trance[ldr_ins]=nullptr;//代表形参特有的ldr
            newBlock[b1].insert(newBlock[b1].begin(),ldr_ins);
        }
    }

    int MAXiter=reachset_times;
    while(MAXiter--){
        for(auto rt:DomRoot){
            visReach.clear();
            //刚进入函数的时候已有的形参需要首先加入进 reachin
            BasicBlock* b1=rt->block;
            FunctionValue* func=rt->func;
            for(auto i=0;i<min(4,(int)func->FuncParams.size());i++){
                //直接为前4个寄存器分配参数
                varDecl* xc = new varDecl(func->FuncParams[i],b1,Rcnt++);
                reachin[b1].insert(xc);
            }  
            calReach(rt->block);
        }
    }
//    dbg("syy -- reach sets win!");
    //3. 填每条语句的used和计算<value,block>到decl的映射...(也不知道有什么用,先算出来吧...)
    for(auto gb:IR1->Blocks){
        for(auto blk : gb->domBlock){
            setUsed(blk);
        }
    }
    dbg("syy -- add used win!");
    //4. 输出用
    cout << "**** Arm Instruction with Unlimited Registers ****\n";
    for(auto rt:DomRoot){
        showDecl(rt);
    }
//    dbg("syy -- show super arm win!");

    for(auto gb:IR1->Blocks){
        if(gb->domBlock.size()==0)continue;
        FunctionValue* func = gb->FuncV;
        if(func->getParamCnt()>4)gblock2spbias[gb]=(func->getParamCnt()-4); //TODO：数组的话,  再说
    }
}