#include <iostream>
#include <vector>
#include <string>
#pragma once
// #ifndef _SYS_NODE_HPP_
// #define _SYS_NODE_HPP_

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
    RT=400,Decl_,CompUnit_,
    ConstDecl_,ConstDef_,ConstDefs_,ConstInitVal_,ConstInitVals_,
    UnaryExp_,UnaryOp_,PrimaryExp_,MulExp_,AddExp_,Exp_,Exps_,LVal_,
    IntConst_,ConstExp_,ConstExps_,FuncType_,FuncDef_,
    InitVals_,InitVal_,VarDef_,VarDefs_,VarDecl_,
    FuncRParams_,FuncRParamse_,FuncFParam_,FuncFParams_,
    LOrExp_,LAndExp_,EqExp_,RelExp_,Cond_,Stmt_,BlockItems_,
    BlockItem_,Block_,
} GrammaType;

struct position_t{
    char *file;
    int line;
    int column;
};

struct GrammaNode
{ 
    int type;
    std::string str;
    std::vector<GrammaNode*> son;
    //struct position_t from;
    //struct position_t to;
    GrammaNode(){son.clear();}
    GrammaNode(int x){type=x;son.clear(); }
    //GrammaNode(int x, std::string y){std::cout<<y<<" ";type=x;str = y;son.clear();std::cout<<str<<std::endl;}
    GrammaNode(int x, std::string y){type=x;str = y;son.clear();}
};
// #endif
// GrammaNode* Exp_Add_new(GrammaNode* a,GrammaNode* b);

// GrammaNode* Exp_Sub_new(GrammaNode* a,GrammaNode* b);
void search_node(GrammaNode* root);
void show_node(GrammaNode* root,int layer);



