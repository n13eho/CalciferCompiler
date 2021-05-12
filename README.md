# calcifercompiler
## Lexer
Simple code in `src/scan.cpp`. We can get a token streaming.
If we use `get_token()`, TokenRec will record update token.
If we use `show_token()`, TokenRec will print it.
## Passer
1. 我们稍微改变了文法，见[Gramma](SysY文法分析.xlsx)
    * 去掉无用的非终结符：ConstExp、Btype、Exp
    * 调整左递归，因为我们想要基于LL进行文法分析
2. 