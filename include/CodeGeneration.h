#include<bits/stdc++.h>
#include"../include/Instruction.h"
#include"../include/BasicBlock.h"
#include"../include/BuildIR.h"
#include"../include/values.h"

void transGlobal(BasicBlock* node);
void transBlock(BasicBlock* node);
//翻译每个四元式
void transAdd(Instruction* instr);
void transSub(Instruction* instr);
void transMul(Instruction* instr);
void transDiv(Instruction* instr);
void transMod(Instruction* instr);
void transUnaryPos(Instruction* instr);
void transUnaryNeg(Instruction* instr);
void transUnaryNot(Instruction* instr);
void transAssign(Instruction* instr);
void transLogicAnd(Instruction* instr);
void transLogicOr(Instruction* instr);
void transLogicEq(Instruction* instr);
void transLogicNeq(Instruction* instr);
void transLogicLT(Instruction* instr);
void transLogicBG(Instruction* instr);
void transLogicLQ(Instruction* instr);
void transLogicGQ(Instruction* instr);
void transLogicJmp(Instruction* instr);
void transConBr(Instruction* instr);
void transCall(Instruction* instr);
void transRet(Instruction* instr);
void transLoad(Instruction* instr);
void transStore(Instruction* instr);
void transBreak(Instruction* instr);

void codegeneration();
