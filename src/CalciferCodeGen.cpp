#include <fstream>
#include <iostream>
#include"CalciferCodeGen.h"

using namespace std;

std::ofstream calout;

void printArm(DomTreenode* dn,BasicBlock* gb)
{
    BasicBlock* b = dn->block;
    calout<<block2lb[b]<<":\n";

    // 遍历所有的call
    for(auto inst:newBlock[b]) {
        if (inst->getType() == armInstr::call) {
            armCall* call_ins = (armCall*)inst;

            // 第5+个
            int tem_bias = gblock2spbias[gb]+1; // bias初始值从gblock2spbias[gb]+1开始，是因为最上面存着lr

            // 传参的参数倒着放
            for(int i = (int)call_ins->rs.size() - 1;i>=4;i--,tem_bias--) {
                auto p = call_ins->rs[i];

                if(p->gettype() == Decl::addr_decl){
                    addrDecl* addr_p = (addrDecl*)p;
                    addr_p->bias = -1 * tem_bias * 4;
                }
            }
        }
    }

    for(auto inst:newBlock[b]){
        if(inst->getType()==armInstr::call){
            armCall* call_ins = (armCall*)inst;

            if(call_ins->funcname == "starttime"){
                calout << "\tbl _sysy_starttime\n";
            }
            else if(call_ins->funcname == "stoptime"){
                calout << "\tbl _sysy_stoptime\n";
            }
            else{
                calout<<"\tbl "<<call_ins->funcname<<endl;
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
            calout<<*inst<<endl;  
            calout<<"@ end of return "<<endl;
        }
        else if(inst->getType()==armInstr::mov){
            armMov *inst_mov = (armMov*)inst;
            if(VregNumofDecl(inst_mov->rd) == VregNumofDecl(inst_mov->rs)){
                //这里其实是专门为加载全局变量值而产生的ldr指令
                //tqy:如果能活到这里的mov，一定是mov r0, [r0]这样的指令
                calout<<"\tldr "<<*inst_mov->rd<<", "<<*inst_mov->rs<<endl;
            }
            else calout<<*inst<<endl;
        }
        else{
            // calout<<"\t";
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
    calout<<"\t.arch armv7a\n";
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