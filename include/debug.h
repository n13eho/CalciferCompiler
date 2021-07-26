#pragma once
#include<bits/stdc++.h>
#include"BasicBlock.h"
#include"BuildIR.h"
#include"Instruction.h"
#include"Value.h"
#include"../include/semanticAnalyze.h"
#include "dbg.h"

using namespace std;

extern map<int,string> DEBUG_blkOP;
extern map<int, std::string> DEBUG_insOP;
extern LinearIR* IR1;
void show_block(BasicBlock* node,int dep,BasicBlock* father, int way);
void show_cfg();

