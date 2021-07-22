#pragma once
#include"decl.h"
#include"BasicBlock.h"
#include<bits/stdc++.h>
using namespace std;

extern map<BasicBlock*, list<armInstr*>> newBlock;
void liveSets();