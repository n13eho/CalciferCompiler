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

void getRister(Value* val, int &Rid)
{
    // 先这样吧,每次用的时候都给第6号寄存器
    Rid = 6;
}

void RegisterDistr()
{
    // 分配寄存器过程的外部接口
    // TODO:...
    return ;
}