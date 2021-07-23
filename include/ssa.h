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
    map<Value*, vector<BasicBlock*> > AssbyBlock;
    map<BasicBlock*,set<BasicBlock*>> DF;
};

void getssa();
extern map<BasicBlock*, string> block2lb;
extern ssa* ssaIR;
extern set<BasicBlock*> phiPos;