%{
#include <stdio.h>
#include <string>
#include <typeinfo>
#include "sysy_node.hpp"
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
/*注释？在这里处理吗*/
Comment1 "//".*
Comment2 \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
Comment {Comment1}|{Comment2}


%%
0+ {return ZERO;}

{space} {}//{printf("%s: space\n",yytext);}
{enter} {}//{printf("%s: enter\n",yytext);}
{zb}    {}//{printf("%s: zb\n",yytext);}
{Comment}  {}

";" {                yylval.no = new GrammaNode(SEMI_,yytext);return SEMI;}
"," {yylval.no = new GrammaNode(COMM_,yytext);return COMM;}
"(" {yylval.no = new GrammaNode(RDBRAL_,yytext);return RDBRAL;}
")" {yylval.no = new GrammaNode(RDBRAR_,yytext);return RDBRAR;}
"[" {yylval.no = new GrammaNode(SQBRAL_,yytext);return SQBRAL;}
"]" {yylval.no = new GrammaNode(SQBRAR_,yytext);return SQBRAR;}
"{" {yylval.no = new GrammaNode(BRAL_,yytext);return BRAL;}
"}" {yylval.no = new GrammaNode(BRAR_,yytext);return BRAR;}
"=" {yylval.no = new GrammaNode(ASSIGN_,yytext);return ASSIGN;}


"+" {yylval.no = new GrammaNode(ADD_,yytext);return ADD;}
"-" {yylval.no = new GrammaNode(SUB_,yytext);return SUB;}
"/" {yylval.no = new GrammaNode(DIV_,yytext);return DIV;}
"*" {yylval.no = new GrammaNode(MUL_,yytext);return MUL;}
"%" {yylval.no = new GrammaNode(MOD_,yytext);return MOD;}
"==" {yylval.no = new GrammaNode(EQ_,yytext);return EQ;}
"!" {yylval.no = new GrammaNode(NOT_,yytext);return NOT;}
"!=" {yylval.no = new GrammaNode(NEQ_,yytext);return NEQ;}
"||" {yylval.no = new GrammaNode(OR_,yytext);return OR;}
"&&" {yylval.no = new GrammaNode(AND_,yytext);return AND;}
"<" {yylval.no = new GrammaNode(LT_,yytext);return LT;}
">" {yylval.no = new GrammaNode(BG_,yytext);return BG;}
"<=" {yylval.no = new GrammaNode(LQ_,yytext);return LQ;}
">=" {yylval.no = new GrammaNode(BQ_,yytext);return BQ;}


"const" {
                yylval.no = new GrammaNode(CONST_,yytext);return CONST;}
"int" { yylval.no = new GrammaNode(INT_,yytext);return INT;}
"void" { yylval.no = new GrammaNode(VOID_,yytext);return VOID;}
"if" {  yylval.no = new GrammaNode(IF_,yytext);return IF;}
"else" {  yylval.no = new GrammaNode(ELSE_,yytext);return ELSE;}
"while" { yylval.no = new GrammaNode(WHILE_,yytext);return WHILE;}
"break" {yylval.no = new GrammaNode(BREAK_,yytext);return BREAK;}
"continue" {yylval.no = new GrammaNode(CONTINUE_,yytext);return CONTINUE;}
"return" {yylval.no = new GrammaNode(RETURN_,yytext);return RETURN;}



{octalConst}    {yylval.no = new GrammaNode(IntConst_O_,yytext);return IntConst_O;}
{decimalConst} {yylval.no = new GrammaNode(IntConst_D_,yytext);return IntConst_D;}
{hexadecimalConst} {yylval.no = new GrammaNode(IntConst_H_,yytext);return IntConst_H;}

{Ident} {yylval.no = new GrammaNode(Ident_,yytext);return Ident;}


%%


int yywrap()
{
        return 1;
}