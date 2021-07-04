/*
处理寄存器分配
*/
#include<bits/stdc++.h>
#include"../include/register.h"
using namespace std;

vector<int>R(12); 
//12个通用寄存器
// R0~R3 存函数的前4个参数

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