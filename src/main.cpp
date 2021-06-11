#include"part.tab.hpp"
#include "sysy_node.hpp"
#include<bits/stdc++.h>

using namespace std;
extern FILE * yyin;
GrammaNode * Droot = new GrammaNode(0,"ROOT");

int main(int argc, char *argv[])
{
    FILE * f1 = fopen(argv[1], "r");
    yyin = f1;
    int ret=yyparse();
    if(ret == 0)
    {
        show_node(Droot,0);
    }
    return 0;
}