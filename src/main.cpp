#include "../include/sysy_node.hpp"
#include "../include/semanticAnalyze.h" //语义检查
#include "../include/BuildIR.h"
#include "./front/part.tab.hpp"
#include "../include/debug.h"
#include "../include/detetedeadblock.h"
#include"../include/ssa.h"
#include"../include/liveSet.h"
#include "../include/RIG.h"
#include"op_cfgFrequency.h"
#include"CalciferCodeGen.h"

//外部的lineno，行号信息
extern int lineno;

using namespace std;
extern FILE *yyin;

GrammaNode *Droot = new GrammaNode(lineno, 0, "ROOT");
idTable_struct *SymbolTable = new idTable_struct();
LinearIR *IR1 = new LinearIR();
BasicBlock *globalBlock = new BasicBlock(BasicBlock::Basic);

int main(int argc, char *argv[])
{
    // 初始参数文件
    char *input_file = nullptr, *output_file = nullptr;
    for(int ch; (ch = getopt(argc, argv, "So:")) != -1;)
    {
        switch(ch)
        {
            case 'S':
                break; // 啥也不干，为了测评机
            case 'o':
                output_file = strdup(optarg);
                dbg(output_file);
                break;
            default:
                break;
        }
    }
    // 处理input_file
    input_file = argv[argc-1];

    // 处理output_file: 这里处理成传参

    // show in/out put info
    dbg(input_file, output_file);

    // 输入提醒
    if (input_file == nullptr)
    {
        fprintf(stderr, "Usage: %s [-S] [-o output_file] [input_file]\n", argv[0]);
        return -1;
    }


    yyin = fopen(input_file, "r");
    // 词法语法分析，无误返回0
    // freopen("../test_sets/debug.out","w",stdout);
    int ret = yyparse();
    if (ret == 0)
    {
//        show_node(Droot, 0); //打印AST
        semanticAnalyzer(Droot); // 从ast语义检查 + 构建符号表
//        show_SymbleTable(SymbolTable); // 打印符号表
        VisitAST(Droot, IR1); // 从ast：建立四元式 + 得出block的信息
//       show_IR_ins(IR1); // 打印指令
//        show_cfg();
        // cout << "\n\n"; show_block(globalBlock, 0);
        // Visitblock(IR1); // 删除空结点
        // SSA
        getssa();//建立支配树以及支配边界 -->

        // 计算每个block的frequency， 可以和上面一步的SSA并行
        getFrequency(); // 是addMemoryOperation(RIG.cpp)的1.1

        // cout << "\n\n"; show_block(globalBlock, 0,nullptr,0); // 打印基本块，查看phi结点
        liveSets();//重命名

//        dbg("neho's start");
        // 寄存器分配：虚拟寄存器->real寄存器。变量活性分析，建立冲突图；
        RigsterAlloc();

        //代码生成
        CalciferCodeGen(output_file);
    }

    // post-precess
    free(Droot);
    free(SymbolTable);
    free(IR1);
    free(globalBlock);

    return 0;
}

// ASan config
extern "C" [[maybe_unused]] const char *__asan_default_options() { return "alloc_dealloc_mismatch=0, detect_leaks=0"; }