/*Register Interference Graph*/

#include"decl.h"
#include"ssa.h"
#include"liveSet.h"
using namespace std;

struct RIGnode
{
    Decl* dc;
    vector<RIGnode*> next;
};

void buildRIG();