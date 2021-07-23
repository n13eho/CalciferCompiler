#pragma once
#include"decl.h"
#include"BasicBlock.h"
#include<bits/stdc++.h>
using namespace std;

void liveSets();
extern map<BasicBlock*, list<armInstr*>> newBlock;