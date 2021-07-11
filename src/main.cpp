#include "../include/sysy_node.hpp"
#include "../include/semanticAnalyze.h" //语义检查
#include "../include/BuildIR.h"
#include "part.tab.hpp"
#include "../include/debug.h"

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE* yyin;

GrammaNode* Droot = new GrammaNode(lineno, 0, "ROOT");
idTable_struct* SymbolTable = new idTable_struct();
LinearIR* IR1 = new LinearIR();
BasicBlock* globalBlock= new BasicBlock(BasicBlock::Basic);

int main(int argc, char *argv[])
{
//    FILE * f1 = fopen(argv[1], "r");
    FILE * f1 = fopen("../test_set/test.c", "r");
    yyin = f1;
    int ret = yyparse(); // 词法语法分析，无误返回0
    if(ret == 0)
    {
//        show_node(Droot, 0); //打印AST
        semanticAnalyzer(Droot); // 语义检查 + 构建符号表
        show_SymbleTable(SymbolTable); // 打印符号表
        VisitAST(Droot, IR1); // 建立四元式
        show_IR_ins(IR1); // 打印指令


        dbg("Blocks:");
        show_block(globalBlock,0); // 打印基本块 （写注释啊啊啊啊啊啊 --neho
    }
    return 0;
}