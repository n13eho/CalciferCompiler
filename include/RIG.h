/*Register Interference Graph*/
#pragma once 
#include"decl.h"
#include"ssa.h"
#include"liveSet.h"
#include"dbg.h"

#define K 13

struct RIGnode
{
    int dc = 0; // 该node的编号（颜色）
    bool typeIsREG = 0; // 这个node的type是不是reg_decl
    int du = -1; // 这个node的度的大小
    int node_spilled = 0; // 这个node是不是溢出放进mem的node（？还没想清楚这个因该在哪里加，它应该和它统治的decl的spill相同

    vector<RIGnode*> connectTo; // 连边

    RIGnode(int x, bool isreg){dc = x; typeIsREG = isreg; connectTo.clear();}
};


extern map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

// void buildRIG();
void RigsterAlloc();


#define WHENTOMO 2 // 多少次着色失败之后才进行spilling 操作
