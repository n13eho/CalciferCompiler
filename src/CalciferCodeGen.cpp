#include"CalciferCodeGen.h"

ofstream calout;

void printArm(DomTreenode* dn)
{
    BasicBlock* b = dn->block;
    calout<<block2lb[b]<<":\n";
    
    for(auto inst:newBlock[b]){
        //TODO：call，ret等。。。
        if(inst->getType()==armInstr::call){
            
        }
        else if(inst->getType()==armInstr::ret){

        }
        else 
            calout<<*inst<<endl;
    }
    
    for(auto son :dn->son)
    {
        printArm(son);
    }
}

void transFunc(BasicBlock* node)
{
    calout<<"\t.global "<<node->FuncV->VName<<"\n\t.type "<<node->FuncV->VName<<", \%function\n"<<node->FuncV->VName<<":\n";
    calout<<"\t.fnstart\n";

    //push lr
    calout<<"\tpush {lr}"<<endl;
    //修改sp
    if(gblock2spbias[node])calout<<"\tsub sp, sp, #"<<gblock2spbias[node]<<endl;
    //输出这个函数的指令
    printArm(block2dom[node->domBlock[0]]);
    // //以下是return 语句干的事情
    // //恢复栈帧
    // if(gblock2spbias[node])calout<<"\tadd sp, sp, #"<<gblock2spbias[node]<<endl;
    // //pop lr
    // calout<<"\tpush {lr}"<<endl;
    // calout<<*ret;    
}

void CalciferCodeGen()
{
    string outputfile = basename(testfilename);
    outputfile = outputfile.substr(0, outputfile.length()-2);
    outputfile  = "../test_sets/outputS/" + outputfile;
    outputfile = outputfile + "S";

    calout.open(outputfile, std::ifstream::out);
    calout<<"\t.data\n";
    for(auto fuhao : allValue)
    {
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
                for(int j = 0;j<val->ArrayElement.size();j++)
                {
                    calout<<"\n\t.word ";
                    calout<<to_string(val->ArrayElement[j]).data();
                }
                //后续多个0 采用.fill cnt 4 0格式 todo
                calout<<endl;
            }
            else
            {
                //变量数组
                calout<<val->VName.data()<<":";
                std::vector<Value*> ele = val->ArrayInitList;
                for(auto vv : ele)
                {
                    calout<<"\n\t.word ";
                    calout<<to_string(((IntegerValue*)vv)->getValue()).data();
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