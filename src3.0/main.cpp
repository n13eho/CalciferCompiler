#include"part.tab.hpp"
#include "sysy_node.hpp"
#include<bits/stdc++.h>

using namespace std;
extern FILE * yyin;
extern GrammaNode * Droot = new GrammaNode(0,"ROOT");

int main()
{
    FILE * f1 = fopen("./test.sy","r");
    yyin = f1;
    int ret=yyparse();
    if(ret == 0)
    {
        show_node(Droot,0);
    }
    return 0;
}