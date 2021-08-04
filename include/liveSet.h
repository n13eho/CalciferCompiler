#pragma once
#include"decl.h"
#include"BasicBlock.h"
#include"../include/ssa.h"
#include "decl_related.h"

#define reachset_times 5 //计算reachset时迭代的次数，主要是为了之后能更方便得到形参的Decl

void liveSets();
void showDecl(DomTreenode* sd);

extern map<BasicBlock*, vector<armInstr*>> newBlock;
extern map<BasicBlock*, int> gblock2spbias;
extern map< pair<Value*,BasicBlock*>, vector<Decl*> > Assign_rec;