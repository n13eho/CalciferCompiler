#pragma once
#include <iostream>
#include <vector>
#include <string>
// #ifndef _SYS_NODE_HPP_
// #define _SYS_NODE_HPP_



#define MAX_SCOPE_STACK 32 // 最大的深度
#define SCOPT_ID_BASE '1'

typedef enum{
    // 标识符(除保留字), 注释信息, 常量十进制，八进制，十六进制
    Ident_ = 300, Comment_, IntConst_D_,IntConst_O_, IntConst_H_,
    // 保留字
    INT_, VOID_, IF_, ELSE_, WHILE_, BREAK_, CONTINUE_, RETURN_, CONST_,MAIN_,
    // 非运算符号 (         )    [         ]     {      }     =
    SEMI_, COMM_, RDBRAL_, RDBRAR_, SQBRAL_, SQBRAR_, BRAL_, BRAR_, ASSIGN_,
    // 运算符号              ==   !=  ||   &&   !   <   <=   >   >=
    ADD_, SUB_, DIV_, MUL_, MOD_, EQ_, NEQ_, OR_, AND_, NOT_, LT_, LQ_, BG_, BQ_,
    // 文件结束, 错误
    ENDF_, ERROR_
} TokenType;

typedef enum{
    // 常量声明语句
    ConstDefs_ = 400,
    UnaryExp_,Exps_,LVal_,
    ConstExps_,
    InitVals_,InitVal_,VarDefs_,
    FuncRParams_,FuncFParams_,
    LOrExp_,LAndExp_,Cond_,
    Block_,Stmt_Assign_,Stmt_Exp_,Stmt_If_,Stmt_IfElse_,Stmt_While_,Stmt_Return_,
    MulExp_Mul_,MulExp_Div_,MulExp_Mod_,AddExp_Sub_,AddExp_Add_,RelExp_LT_,RelExp_BG_,RelExp_BQ_,RelExp_LQ_,
    EqExp_EQ_,EqExp_NEQ_,UnaryExp_func_,LVal_Array_,VarDef_array_init_,VarDef_array_,VarDef_single_,
    VarDef_single_init_,FuncFParam_array_,FuncFParam_single_,FuncFParam_singleArray_,FuncDef_int_,
    FuncDef_void_,FuncDef_int_para_,FuncDef_void_para_,InitVal_EXP,InitVal_NULL,ConstDef_array_,
    ConstDef_single_
} GrammaType;


struct position_t{
    char *file;
    int line;
    int column;
};

struct GrammaNode
{
    int type;
    int lineno;
    std::string str; // 变量名称（如果是个ident或这函数名字或者保留字的话）
    std::string var_scope; // 变量标识符's作用域
    std::vector<GrammaNode*> son;
    GrammaNode(){son.clear();}
    GrammaNode(int l, int x){lineno = l; type=x; son.clear();}
    GrammaNode(int l, int x, std::string y){lineno = l; type=x; str = y; son.clear();}
};

// #endif
// GrammaNode* Exp_Add_new(GrammaNode* a,GrammaNode* b);

// GrammaNode* Exp_Sub_new(GrammaNode* a,GrammaNode* b);
void show_node(GrammaNode* root, int layer);
extern GrammaNode* Droot;
