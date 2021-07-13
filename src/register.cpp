/*
处理寄存器分配
*/
#include<bits/stdc++.h>
#include"../include/register.h"
#include"BuildIR.h"
#include"semanticAnalyze.h"
using namespace std;

vector<int>R(13);//每个寄存器存的的值。
map<Value*,int> VReg;//符号表的每一个变量都应该有一个对应的寄存器。
int VReg_cnt;
void getRister(Value* val, int &Rid)
{
    //看不到~
}

void RegisterDistr()
{
    //分配寄存器的外部接口
    for(auto valRecord : SymbolTable->table)
    {
        Value* val=valRecord.second;
        if(val->getType()==3)continue;
        if(val->getType()==2)continue;
        IntegerValue* intval=(IntegerValue*)val;
        if(intval->isConst==1)continue;
        if(!VReg[intval])VReg[intval]=VReg_cnt++;
    }
    // debug用
    for(auto allocation : VReg)
    {
        IntegerValue* tem=(IntegerValue*)allocation.first;
        cout<<tem->RealValue<<' '<<tem->isConst<<' '<<tem->var_scope<<' ';
        cout<<allocation.first->VName<<' '<<allocation.second<<endl;
    }
    return ;
}