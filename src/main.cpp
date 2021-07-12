#include "../include/sysy_node.hpp"
#include "../include/semanticAnalyze.h" //语义检查
#include "../include/BuildIR.h"
#include "part.tab.hpp"
#include"register.h"
#include "../include/debug.h"
#include "../include/ssa.h"
#include"CodeGeneration.h"

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE* yyin;
char *ir_file = strdup("../test_set/test.ll");

GrammaNode* Droot = new GrammaNode(lineno, 0, "ROOT");
idTable_struct* SymbolTable = new idTable_struct();
LinearIR* IR1 = new LinearIR();
BasicBlock* globalBlock= new BasicBlock(BasicBlock::Basic);

int main(int argc, char *argv[])
{
    FILE * f1 = fopen("../test_set/test.c", "r");
    if(argc == 2)
        f1 = fopen(argv[1], "r");

    yyin = f1;

    // 词法语法分析，无误返回0
    int ret = yyparse();
    if(ret == 0)
    {
        show_node(Droot, 0); //打印AST
        // 从ast语义检查 + 构建符号表
        semanticAnalyzer(Droot);
        show_SymbleTable(SymbolTable); // 打印符号表
        // 从ast：建立四元式 + 得出block的信息
        VisitAST(Droot, IR1);
        show_IR_ins(IR1); // 打印指令
        show_block(globalBlock,0); // 打印基本块 （写注释啊啊啊啊啊啊 --neho

        // 利用四元式和bb信息得出ssa_0
        dbg("convert to ssa");
        auto *ssa_0 = convert_ssa(IR1, globalBlock);
        std::ofstream(ir_file) << *ssa_0;


    }

    // post-precess
    free(Droot);
    free(SymbolTable);
    free(IR1);
    free(globalBlock);
    free(ir_file);


    return 0;
}