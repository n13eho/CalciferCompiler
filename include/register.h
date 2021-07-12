/*
这里是处理寄存器分配的头文件
*/
#pragma once
#include<bits/stdc++.h>
#include"BasicBlock.h"
#include"BuildIR.h"
#include"Instruction.h"
#include"Value.h"
using namespace std;

extern vector<int> R;
extern map<Value*,int> VReg;
void getRister(Value* val, int &Rid);
void RegisterDistr();
