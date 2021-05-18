%{
#include <stdio.h>
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
{space} {}//{printf("%s: space\n",yytext);}
{enter} {}//{printf("%s: enter\n",yytext);}
{zb}    {}//{printf("%s: zb\n",yytext);}
{Comment}  {printf("%s: Comment\n",yytext);}

";" {printf("%s: SEMI\n",yytext);}
"," {printf("%s: COMM\n",yytext);}
"(" {printf("%s: RDBRAL\n",yytext);}
")" {printf("%s: RDBRAR\n",yytext);}
"[" {printf("%s: SQBRAL\n",yytext);}
"]" {printf("%s: SQBRAR\n",yytext);}
"{" {printf("%s: BRAL\n",yytext);}
"}" {printf("%s: BRAR\n",yytext);}
"=" {printf("%s: ASSIGN\n",yytext);}

"+" {printf("%s: ADD\n",yytext);}
"-" {printf("%s: SUB\n",yytext);}
"/" {printf("%s: DIV\n",yytext);}
"*" {printf("%s: MUL\n",yytext);}
"%" {printf("%s: MOD\n",yytext);}
"==" {printf("%s: EQ\n",yytext);}
"!" {printf("%s: NOT\n",yytext);}
"!=" {printf("%s: NEQ\n",yytext);}
"||" {printf("%s: OR\n",yytext);}
"&&" {printf("%s: AND\n",yytext);}
"<" {printf("%s: LT\n",yytext);}
">" {printf("%s: BG\n",yytext);}
"<=" {printf("%s: LQ\n",yytext);}
">=" {printf("%s: BQ\n",yytext);}

"const" {printf("%s: RSWord_CONST\n",yytext);}
"int" {printf("%s: RSWord_INT\n",yytext);}
"void" {printf("%s: RSWord_VOID\n",yytext);}
"if" {printf("%s: RSWord_IF\n",yytext);}
"else" {printf("%s: RSWord_ELSE\n",yytext);}
"while" {printf("%s: RSWord_WHILE\n",yytext);}
"break" {printf("%s: RSWord_BREAK\n",yytext);}
"continue" {printf("%s: RSWord_CONTINUE\n",yytext);}
"return" {printf("%s: RSWord_RETURN\n",yytext);}
"main" {printf("%s: RSWord_MAIN\n",yytext);}
 

{octalConst}    {printf("%s: IntConst_octalConst\n",yytext);}
{decimalConst} {printf("%s: IntConst_decimalConst\n",yytext);}
{hexadecimalConst} {printf("%s: IntConst_hexadecimalConst\n",yytext);}

{Ident} {printf("%s: Ident\n",yytext);}
%%

int main()
{
        yyin = fopen("test.sy","r");
        yylex();
        fclose(yyin);
}
int yywrap()
{
        return 1;
}