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
    int dc_type;
    vector<RIGnode*> connectTo;

    RIGnode(int x, int decl_type){dc = x; dc_type = decl_type;}
};


extern map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

// void buildRIG();
void RigsterAlloc();


#define WHENTOMO 2 // 多少次着色失败之后才进行spilling 操作
#define TIMES_RIG 10