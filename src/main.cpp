#include "../include/sysy_node.hpp"
#include "../include/semanticAnalyze.h" //语义检查
#include "../include/BuildIR.h"
#include "part.tab.hpp"
#include "../include/debug.h"
#include "CodeGeneration.h"
#include "../include/detetedeadblock.h"
#include"../include/ssa.h"
#include"../include/liveSet.h"
#include "../include/RIG.h"

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE *yyin;
char *testfilename;
char *ir_file = strdup("../test_set/test.ll");

GrammaNode *Droot = new GrammaNode(lineno, 0, "ROOT");
idTable_struct *SymbolTable = new idTable_struct();
LinearIR *IR1 = new LinearIR();
BasicBlock *globalBlock = new BasicBlock(BasicBlock::Basic);

int main(int argc, char *argv[])
{
    if (argc == 2)
    {
        testfilename = argv[1];
    }
    else
    {
        testfilename = (char*)"../test_sets/test.sy";
    }
    FILE *f1 = fopen(testfilename, "r");


    yyin = f1;

    // 词法语法分析，无误返回0
    // freopen("../test_sets/debug.out","w",stdout);
    int ret = yyparse();
    if (ret == 0)
    {
        show_node(Droot, 0); //打印AST
        semanticAnalyzer(Droot); // 从ast语义检查 + 构建符号表
//        show_SymbleTable(SymbolTable); // 打印符号表
        VisitAST(Droot, IR1); // 从ast：建立四元式 + 得出block的信息
        // cout << "\n\n"; show_block(globalBlock, 0);
        // Visitblock(IR1); // 删除空结点
//        show_IR_ins(IR1); // 打印指令
    //    cout << "\n\n"; show_block(globalBlock, 0); // 打印基本块 （写注释啊啊啊啊啊啊 --neho

        // SSA
        show_cfg();
        getssa();//建立支配树以及支配边界 -->
        cout << "\n\n"; show_block(globalBlock, 0,nullptr,0); // 打印基本块，查看phi结点
        liveSets();//重命名

        // 寄存器分配：虚拟寄存器->realj寄存器。变量活性分析，建立冲突图；
        buildRIG();

        // codegeneration();
        // 利用四元式和bb信息得出ssa_0
        // dbg("convert to ssa");
        // auto *ssa_0 = convert_ssa(IR1, globalBlock);
        // std::ofstream(ir_file) << *ssa_0;
    }

    // post-precess
    free(Droot);
    free(SymbolTable);
    free(IR1);
    free(globalBlock);

    return 0;
}