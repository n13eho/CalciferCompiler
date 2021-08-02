#include"CalciferCodeGen.h"

ofstream calout;

void printArm(DomTreenode* dn,BasicBlock* gb)
{
    BasicBlock* b = dn->block;
    calout<<block2lb[b]<<":\n";
    
    for(auto inst:newBlock[b]){
        if(inst->getType()==armInstr::call){
            armCall* call_ins = (armCall*)inst;

            //push 所有寄存器//TODO: 应该push用过的
            int rdNum = -1;
            if(call_ins->rd != NULL)
            {
                rdNum = VregNumofDecl(call_ins->rd);
                if(rdNum==0)calout<<"\tpush {r1-r12}"<<endl;
                else if(rdNum == 12)calout<<"\tpush {r0-r11}"<<endl;
                else{
                    calout<<"\tpush {r0-r"<<rdNum-1<<", r"<<rdNum+1<<"-r12}"<<endl;
                }
            }
            else
            {
                calout<<"\tpush {r0-r12}"<<endl;
            }
            
            //填写参数
            calout<<"@ mov params"<<endl;
            // 后5+个
            int tem_bias = 2; // bias初始值从2开始，是因为1处存着lr
            // 传参的参数倒着放
            for(int i=(int)call_ins->rs.size() - 1;i>=4;i--,tem_bias++){
                auto p =call_ins->rs[i];
                if(p->gettype()==Decl::const_decl){
                    //if const
                    calout<<"\tmov r6, "<<*p<<endl;
                    calout<<"\tstr r6, [sp, #-"<<tem_bias*4<<"]"<<endl;
                }
                else{
                    calout<<"\tstr "<<*p<<", [sp, #-"<<tem_bias*4<<"]"<<endl;
                }
            }
            // 前4个
            //FIXME:这里的操作暂时解决实参传递问题，可能要改

            for(int i=0;i<min(4,(int)call_ins->rs.size());i++){
                if(call_ins->rs[i]->gettype()==Decl::const_decl)
                    //如果是立即数的话
                    calout<<"\tmov r"<<i<<", "<<*(call_ins->rs[i])<<endl;
                else{
                    if(VregNumofDecl(call_ins->rs[i])==i)continue;
                    //如果是寄存器,需要移一下..
                    calout<<"\tmov r"<<i+7<<", "<<*(call_ins->rs[i])<<endl;
                    calout<<"\tmov r"<<i<<", r"<<i+7<<endl;
                }
            }

            //跳转
            calout<<"@ jmp"<<endl;
            calout<<"\tbl "<<call_ins->funcname<<endl;

            //处理返回值
            if(call_ins->rd != NULL)
            {
                calout<<"\tmov "<<*(call_ins->rd)<<", "<<"r0"<<endl;
            }

            //pop 所有寄存器//TODO: 应该pop用过的
            if(rdNum == -1)
            {
                calout<<"\tpop {r0-r12}"<<endl;
            }
            else
            {
                if(rdNum==0)calout<<"\tpop {r1-r12}"<<endl;
                else if(rdNum == 12)calout<<"\tpop {r0-r11}"<<endl;
                else{
                    calout<<"\tpop {r0-r"<<rdNum-1<<", r"<<rdNum+1<<"-r12}"<<endl;
                }
            }
        }
        else if(inst->getType()==armInstr::ret){
            //以下是return 语句干的事情
            //恢复栈帧
            calout<<"@ this is a ret"<<endl;
            if(gblock2spbias[gb])calout<<"\tadd sp, sp, #"<<gblock2spbias[gb]*4<<endl;
            //pop lr
            calout<<"\tpop {lr}"<<endl;
            //放返回值
            calout<<"\t"<<*inst<<endl;  
            calout<<"@ end of return "<<endl;
        }
        else if(inst->getType()==armInstr::mov){
            armMov *inst_mov = (armMov*)inst;
            if(VregNumofDecl(inst_mov->rd) == VregNumofDecl(inst_mov->rs)){
                //这里其实是专门为加载全局变量值而产生的ldr指令
                //tqy:如果能活到这里的mov，一定是mov r0, [r0]这样的指令
                calout<<"\tldr "<<*inst_mov->rd<<", "<<*inst_mov->rs<<endl;
            }
            else calout<<"\t"<<*inst<<endl;
        }
        else{
            calout<<"\t";
            calout<<*inst<<endl;
        }
    }
    
    for(auto son :dn->son)
    {
        printArm(son,gb);
    }
}

void transFunc(BasicBlock* node)
{
    calout<<"@ this is a start of function."<<endl;
    calout<<"\t.global "<<node->FuncV->VName<<"\n\t.type "<<node->FuncV->VName<<", \%function\n"<<node->FuncV->VName<<":\n";
    calout<<"\t.fnstart\n";

    //push lr
    calout<<"\tpush {lr}"<<endl;
    //修改sp
    if(gblock2spbias[node])calout<<"\tsub sp, sp, #"<<gblock2spbias[node]*4<<endl;
    //输出这个函数的指令
    printArm(block2dom[node->domBlock[0]],node);

    calout<<"\t.fnend"<<endl;
  
}

void CalciferCodeGen(char *output_file_path)
{

    string outputfile = output_file_path;
//    outputfile = outputfile.substr(0, outputfile.length()-2);
//    outputfile  = "../test_sets/outputS/" + outputfile;
//    outputfile = outputfile + "S";

    calout.open(outputfile, std::ifstream::out);
    calout<<"\t.data\n";
    for(auto fuhao : allValue)
    {
        if(fuhao == NULL)continue;
        //这里写.data
        if(fuhao->getType()==1)
        {
            IntegerValue* val=(IntegerValue*)fuhao;
            if(val->var_scope!="1"||val->isConst==1)continue;
            calout<<val->VName.data();
            calout<<":\n\t.word ";
            calout<<to_string(val->RealValue).data();
            calout<<endl;
        }
        else if(fuhao->getType() == 2 && fuhao->var_scope=="1")
        {//全局变量数组
            //判断是否为const int 数组
            ArrayValue* val=(ArrayValue*)fuhao;
            if(val->isConst == 1)
            {
                //常量数组
                calout<<val->VName.data()<<":";
                int repeat_cnt = 0;
                for(int j = 0;j<val->ArrayElement.size();j++)
                {
                    if(val->ArrayElement[j]!=0)
                    {
                        if(repeat_cnt>0)
                        {
                            calout<<"\n\t.zero ";
                            calout<<to_string(repeat_cnt).data();
                            repeat_cnt = 0;
                        }
                        calout<<"\n\t.word ";
                        calout<<to_string(val->ArrayElement[j]).data();
                    }
                    else
                    {
                        repeat_cnt++;
                    }
                }
                if(repeat_cnt>0)
                {
                    calout<<"\n\t.zero ";
                    calout<<to_string(repeat_cnt).data();
                    repeat_cnt = 0;
                }
                //后续多个0 采用.fill cnt 4 0格式 todo
                calout<<endl;
            }
            else
            {
                //变量数组
                calout<<val->VName.data()<<":";
                std::vector<Value*> ele = val->ArrayInitList;
                int repeat_cnt = 0;
                for(auto vv : ele)
                {
                    IntegerValue* tt = (IntegerValue*)vv;
                    // calout<<"\n\t.word ";
                    // calout<<to_string(tt->getValue()).data();

                    if(tt->getValue()!=0)
                    {
                        if(repeat_cnt>0)
                        {
                            calout<<"\n\t.zero ";
                            calout<<to_string(repeat_cnt).data();
                            repeat_cnt = 0;
                        }
                        calout<<"\n\t.word ";
                        calout<<to_string(tt->getValue()).data();
                    }
                    else
                    {
                        repeat_cnt++;
                    }
                }
                if(repeat_cnt>0)
                {
                    calout<<"\n\t.zero ";
                    calout<<to_string(repeat_cnt).data();
                    repeat_cnt = 0;
                }
                calout<<endl;
            }
        }
    }
    calout<<"\t.text\n";
    for(auto gb : IR1->Blocks){
        if(gb->domBlock.size()==0)continue;
        transFunc(gb);
    }
    calout.close();
}