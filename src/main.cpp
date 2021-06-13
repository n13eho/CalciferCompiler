#include "part.tab.hpp"
#include "sysy_node.hpp"
#include "semanticAnalyze.h" //语义检查
#include <bits/stdc++.h>

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE* yyin;
GrammaNode* Droot = new GrammaNode(lineno, 0, "ROOT");

int main(int argc, char *argv[])
{
    FILE * f1 = fopen(argv[1], "r");
    yyin = f1;
    int ret = yyparse();
    if(ret == 0)
    {
        semanticAnalyzer(Droot);
        show_node(Droot, 0);
    }
    return 0;
}