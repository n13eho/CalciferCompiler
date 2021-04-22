#pragma once

#include<bits/stdc++.h>
using namespace std;
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


class OriFile
{
    public:
    static char getBuff;
    string path;
    OriFile(){getBuff=0;path.clear();};
    OriFile(string _path)
    {
        getBuff=0;
        path=_path;
        freopen(path.c_str(),"r",stdin);
    } 
    ~OriFile(){fclose(stdin);}
    static char getOneChar();
};