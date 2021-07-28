/*Register Interference Graph*/

#include"decl.h"
#include"ssa.h"
#include"liveSet.h"
#include"dbg.h"

struct RIGnode
{
    Decl* dc;
    vector<RIGnode*> connectTo;

    explicit RIGnode(Decl* x){dc = x;}
};


extern map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

// void buildRIG();
void RigsterAlloc();