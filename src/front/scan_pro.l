%{
int lineno = 1; // 行号


#include <stdio.h>
#include <string>
#include <typeinfo>
#include "../include/sysy_node.hpp"
#include "part.tab.hpp"

%}

letter [a-zA-Z]
digit  [0-9]
space  " "
enter  \n
zb     \t

/*数值常量*/
octalConst 0[0-7]+
decimalConst [1-9]{digit}*
hexadecimalConst 0[xX][0-9a-fA-F]+

/*IntConst {octalConst}|{hexadecimalConst}|{decimalConst}|{zeroo}*/
/*Ident,标识符*/
Ident [_a-zA-Z][_a-zA-Z0-9]*
/*单行注释*/
Comment1 "//".*

%x Comment


%%

"/*" {BEGIN(Comment);}
<Comment>"*/" {BEGIN(INITIAL);}
<Comment>([^*]|\n+|.)
<Comment><<EOF>> {printf("What comment?\n");return 0;}


0+ {yylval.no = new GrammaNode(lineno, IntConst_D_,yytext);return ZERO;}

{space} {}
{enter} {lineno++;} // 遇见\n，行号++
{zb}    {}

{Comment1} {}

";" {yylval.no = new GrammaNode(lineno, SEMI_, yytext);return SEMI;}
"," {yylval.no = new GrammaNode(lineno, COMM_,yytext);return COMM;}
"(" {yylval.no = new GrammaNode(lineno, RDBRAL_,yytext);return RDBRAL;}
")" {yylval.no = new GrammaNode(lineno, RDBRAR_,yytext);return RDBRAR;}
"[" {yylval.no = new GrammaNode(lineno, SQBRAL_,yytext);return SQBRAL;}
"]" {yylval.no = new GrammaNode(lineno, SQBRAR_,yytext);return SQBRAR;}
"{" {yylval.no = new GrammaNode(lineno, BRAL_,yytext);return BRAL;}
"}" {yylval.no = new GrammaNode(lineno, BRAR_,yytext);return BRAR;}
"=" {yylval.no = new GrammaNode(lineno, ASSIGN_,yytext);return ASSIGN;}


"+" {yylval.no = new GrammaNode(lineno, ADD_,yytext);return ADD;}
"-" {yylval.no = new GrammaNode(lineno, SUB_,yytext);return SUB;}
"/" {yylval.no = new GrammaNode(lineno, DIV_,yytext);return DIV;}
"*" {yylval.no = new GrammaNode(lineno, MUL_,yytext);return MUL;}
"%" {yylval.no = new GrammaNode(lineno, MOD_,yytext);return MOD;}
"==" {yylval.no = new GrammaNode(lineno, EQ_,yytext);return EQ;}
"!" {yylval.no = new GrammaNode(lineno, NOT_,yytext);return NOT;}
"!=" {yylval.no = new GrammaNode(lineno, NEQ_,yytext);return NEQ;}
"||" {yylval.no = new GrammaNode(lineno, OR_,yytext);return OR;}
"&&" {yylval.no = new GrammaNode(lineno, AND_,yytext);return AND;}
"<" {yylval.no = new GrammaNode(lineno, LT_,yytext);return LT;}
">" {yylval.no = new GrammaNode(lineno, BG_,yytext);return BG;}
"<=" {yylval.no = new GrammaNode(lineno, LQ_,yytext);return LQ;}
">=" {yylval.no = new GrammaNode(lineno, BQ_,yytext);return BQ;}


"const" {yylval.no = new GrammaNode(lineno, CONST_,yytext);return CONST;}
"int" { yylval.no = new GrammaNode(lineno, INT_,yytext);return INT;}
"void" { yylval.no = new GrammaNode(lineno, VOID_,yytext);return VOID;}
"if" {  yylval.no = new GrammaNode(lineno, IF_,yytext);return IF;}
"else" {  yylval.no = new GrammaNode(lineno, ELSE_,yytext);return ELSE;}
"while" { yylval.no = new GrammaNode(lineno, WHILE_,yytext);return WHILE;}
"break" {yylval.no = new GrammaNode(lineno, BREAK_,yytext);return BREAK;}
"continue" {yylval.no = new GrammaNode(lineno, CONTINUE_,yytext);return CONTINUE;}
"return" {yylval.no = new GrammaNode(lineno, RETURN_,yytext);return RETURN;}



{octalConst}    {yylval.no = new GrammaNode(lineno, IntConst_O_,yytext);return IntConst_O;}
{decimalConst} {yylval.no = new GrammaNode(lineno, IntConst_D_,yytext);return IntConst_D;}
{hexadecimalConst} {yylval.no = new GrammaNode(lineno, IntConst_H_,yytext);return IntConst_H;}
{Ident} {yylval.no = new GrammaNode(lineno, Ident_,yytext);return Ident;}

%%


int yywrap()
{
        return 1;
}