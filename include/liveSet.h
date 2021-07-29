#pragma once
#include"decl.h"
#include"BasicBlock.h"
// #include<bits/stdc++.h>
#include"../include/ssa.h"
// using namespace std;

void liveSets();
void showDecl(DomTreenode* sd);

extern map<BasicBlock*, vector<armInstr*>> newBlock;
extern map<BasicBlock*, int> gblock2spbias;
