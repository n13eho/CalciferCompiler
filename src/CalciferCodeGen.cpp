#include"CalciferCodeGen.h"

ofstream calout;
map<Value*, BasicBlock*> func2block;

void printArm(DomTreenode* dn,BasicBlock* gb)
{
    BasicBlock* b = dn->block;
    calout<<block2lb[b]<<":\n";
    
    for(auto inst:newBlock[b]){

        if(inst->getType()==armInstr::call){
            armCall* call_ins = (armCall*)inst;

            //跳转
            calout<<"@ jmp"<<endl;
            if(call_ins->funcname == "starttime"){
                calout << "\tbl _sysy_starttime\n";
            }
            else if(call_ins->funcname == "stoptime"){
                calout << "\tbl _sysy_stopti    me\n";
            }
            else{
                calout<<"\tbl "<<call_ins->funcname<<endl;
            }

            //处理返回值
            if(call_ins->rd != NULL)
            {
                if(call_ins->funcname == "__aeabi_idivmod"){
                    calout<<"\tmov "<<*(call_ins->rd)<<", "<<"r1"<<endl;
                }
                else{
                    calout<<"\tmov "<<*(call_ins->rd)<<", "<<"r0"<<endl;
                }
            }
        }
        else if(inst->getType()==armInstr::ret){
            //以下是return 语句干的事情
            //恢复栈帧
            calout<<"@ this is a ret"<<endl;
            //pop lr //FIXME: 现在加到了ret的输出中
//            calout<<"\tpop {r4-r12, lr}"<<endl;

            if(gblock2spbias[gb]){
                if(!isValid8bit(((gblock2spbias[gb]+1)*4))){
                    int lucky = 7;
                    if(VregNumofDecl((((armRet*)inst)->rs))==7)lucky++;
                    calout << "\tmovw r" << lucky << ", #" << (gblock2spbias[gb])*4 << endl;
                    calout << "\tadd sp, sp, r" << lucky << endl;
                }
                else{
                    calout<<"\tadd sp, sp, #"<<(gblock2spbias[gb])*4<<endl;
                }
                
            }
            //放返回值
            calout<<*inst<<endl;  
            calout<<"@ end of return "<<endl;
        }
        else if(inst->getType()==armInstr::mov && trance[inst]!=nullptr && trance[inst]->getOpType()!=Instruction::Call){
            armMov *inst_mov = (armMov*)inst;
            if(VregNumofDecl(inst_mov->rd) == VregNumofDecl(inst_mov->rs)){
                //这里其实是专门为加载全局变量值而产生的ldr指令
                //tqy:如果能活到这里的mov，一定是mov r0, [r0]这样的指令
                calout<<"\tldr "<<*inst_mov->rd<<", "<<*inst_mov->rs<<endl;
            }
            else calout<<*inst<<endl;
        }
        else if(inst->getType() == armInstr::str && trance[inst]!=nullptr && trance[inst]->getOpType()==Instruction::Call){
            //加上不为空的判断是为了跳过spill产生的str指令
            memoryDecl* str_param = (memoryDecl*) ((armStr*)inst)->rs;
            BasicBlock* func_node = func2block[(trance[inst])->getOp()[0]];
            str_param->bias += -(gblock2spbias[func_node]+10)-5;//+1是将来要lr//FIXME:+9是还有保存现场//因为形参load是从sp+4开始,这个bias以前存的是他是第几个参数
            calout<<*inst<<endl;
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
    calout<<"\tpush {r4-r12, lr}"<<endl;
    //修改sp
    
    if(gblock2spbias[node]){
        // 这里的sub常量也需要像mov那样考虑,如果不是合法的话,就是用movw; 但是还有一种它大得过分的情况,这里先不考虑 // FIXME
        if(!isValid8bit((gblock2spbias[node])*4)){
            calout << "\tmovw r7, #" << (gblock2spbias[node])*4 << endl;
            calout << "\tsub sp, sp, r7" << endl;
        }
        else{
            calout<<"\tsub sp, sp, #"<<(gblock2spbias[node])*4<<endl;
        }
    }
    //输出这个函数的指令
    printArm(block2dom[node->domBlock[0]],node);

    calout<<"\t.fnend"<<endl;
  
}


void CalciferCodeGen(char *output_file_path)
{

    //我需要funcv到gb的映射
    for(auto i :IR1->Blocks){
        if(i==IR1->Blocks.front())continue;
        func2block[i->FuncV]=i;
    }

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
                            calout<<to_string(repeat_cnt*4).data();
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
                    calout<<to_string(repeat_cnt*4).data();
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
                // dbg("全局变量数组：",ele.size());
                // for(auto v :ele)
                // {
                //     dbg(((IntegerValue*)v)->getValue());
                // }

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
                            calout<<to_string(repeat_cnt*4).data();
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
                    calout<<to_string(repeat_cnt*4).data();
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