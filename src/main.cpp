#include "part.tab.hpp"
#include "sysy_node.hpp"
#include "semanticAnalyze.h" //语义检查
#include <bits/stdc++.h>
#include "../include/Value.h"
#include "../include/BuildIR.h"

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE* yyin;
GrammaNode* Droot = new GrammaNode(lineno, 0, "ROOT");
idTable_struct* SymbolTable = new idTable_struct();
LinearIR* IR1 = new LinearIR();

int main(int argc, char *argv[])
{
    FILE * f1 = fopen(argv[1], "r");
    yyin = f1;
    int ret = yyparse(); // 词法语法分析，无误返回0
    if(ret == 0)
    {
        // printIdMap(); // 打印idList和idNameList的信息
        show_node(Droot, 0); //打印AST
        semanticAnalyzer(Droot); // 语义检查
        showSymbleTable(SymbolTable); // 打印符号表
        VisitAST(Droot,IR1);//建立四元式
    }
    return 0;
}