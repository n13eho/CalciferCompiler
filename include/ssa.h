#pragma once
#include"decl.h"
#include "Value.h"
#include<bits/stdc++.h>
using namespace std;
/*
input: CFG with lowIR
output: CFG with newIR

note:
    1. What is newIR?
    ----将之前四元式中的指令替换为汇编指令，暂不处理寄存器，使用decel（每一个变量被赋值都会多一个decel，在多个变量合并的时候，需要插入phi节点）
    2. 是否复用instrion类?
    ----还是重新来吧.
*/

#include "BuildIR.h" // for LinearIR
#include "BasicBlock.h" // for BasicBlock

struct DomTreenode
{
    vector<DomTreenode*> son;
    BasicBlock* block;
    DomTreenode *idom;
};
extern map<BasicBlock*,DomTreenode*> block2dom;
extern vector<DomTreenode*> DomRoot;

class ssa
{
    public:
    vector<armInstr*> newIR;
    map< pair<Value*,BasicBlock*>, vector<Decl*> > Assign_rec;
    map<Value*, vector<BasicBlock*> > AssbyBlock;
    map<BasicBlock*, vector<armInstr*> > newBlock;
    map<BasicBlock*,set<BasicBlock*>> DF;
};

extern void getssa();
extern map<BasicBlock*, string> block2lb;
extern ssa* ssaIR;