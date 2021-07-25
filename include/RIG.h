/*Register Interference Graph*/

#include"decl.h"
#include"ssa.h"
#include"liveSet.h"
#include"dbg.h"

struct RIGnode
{
    Decl* dc;
    vector<RIGnode*> connect;
};


extern map<BasicBlock*, vector<RIGnode*>> RIG; // THE graph

void buildRIG();