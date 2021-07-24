#pragma once
#include"decl.h"
#include "Value.h"
#include<bits/stdc++.h>
using namespace std;
/*
input: IR1 without phi
output: IR1 with phi
*/

#include "BuildIR.h" // for LinearIR
#include "BasicBlock.h" // for BasicBlock

struct DomTreenode
{
    //支配树节点
    vector<DomTreenode*> son;//son
    BasicBlock* block;//这个节点对应的block
    DomTreenode *idom;// 这个节点的直接支配节点
};
extern map<BasicBlock*,DomTreenode*> block2dom;
extern vector<DomTreenode*> DomRoot;//所有支配树的根

class ssa
{
    public:
    vector<armInstr*> newIR;
    map<Value*, vector<BasicBlock*> > AssbyBlock;//对val赋值过的block
    map<BasicBlock*,set<BasicBlock*>> DF;
};

void getssa();
extern map<BasicBlock*, string> block2lb;
extern ssa* ssaIR;
extern set<BasicBlock*> phiPos;
extern set<Value*> allValue;