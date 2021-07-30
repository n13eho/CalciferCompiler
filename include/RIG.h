/*Register Interference Graph*/
#pragma once 
#include"decl.h"
#include"ssa.h"
#include"liveSet.h"
#include"dbg.h"

#define K 13

struct RIGnode
{
    int dc;
    vector<RIGnode*> connectTo;

    explicit RIGnode(int x){dc = x;}
};


extern map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

// void buildRIG();
void RigsterAlloc();
int VregNumofDecl(Decl* d);


#define WHENTOMO 2 // 多少次着色失败之后才进行spilling 操作