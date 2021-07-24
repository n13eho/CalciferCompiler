#include"decl.h"
#include"RIG.h"
#include"ssa.h"
#include"liveSet.h"

// input at liveSet.h: map<BasicBlock*, vector<armInstr*>> newBlock;

// output
//map<Decl*, RIGnode*> decl2node;
vector<RIGnode*> RIG; // THE graph

void buildRIG()
{
    
}