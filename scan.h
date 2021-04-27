#pragma once
#include <string>

typedef struct{
    bool isNum_f = false; //一个标记，false则表明它的值是string；true则为数字   union我搞不定
    std::string val_str;
    int num;
}TokenVal;

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
    INT, VOID, IF, ELSE, WHILE, BREAK, CONTINUE, RETURN, CONST,
    // 非运算符号 (         )    [         ]     {      }     =
    SEMI, COMM, RDBRAL, RDBRAR, SQBRAL, SQBRAR, BRAL, BRAR, ASSIGN,
    // 运算符号              ==   !=  ||   &&   !   <   <=   >   >=
    ADD, SUB, DIV, MUL, MOD, EQ, NEQ, OR, AND, NOT, LT, LQ, BG, BQ,
    // 文件结束, 错误
    ENDF, ERROR
} TokenType;
