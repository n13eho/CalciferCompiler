#pragma once
#include <string>

union TokenVal{
    std::string val_str;
    int num;
    TokenVal(){val_str.clear();}
    ~TokenVal(){val_str.clear();}
};

typedef struct
{//二元组记录token
    TokenVal val;
    int type;
    void show_token();
    void get_token();
}TokenRec;


typedef enum{
    // 标识符(除保留字), 注释信息, 常量
    Ident = 300, Comment, IntConst, 
    // 保留字
    INT, VOID, IF, ELSE, WHILE, BREAK, CONTINUE, RETURN, 
    // 非运算符号 (         )    [         ]     {      }     =
    SEMI, COMM, RDBRAL,RDBRAR, SQBRAL, SQBRAR, BRAL, BRAR, ASSIGN,
    // 运算符号              ==   !=  ||   &&   !   <   <=   >   >=
    ADD, SUB, DIV, MUL, MOD, EQ, NEQ, OR, AND, NOT, LT, LQ, BG, BQ,
    // 文件结束, 错误
    ENDF, ERROR
} TokenType;
