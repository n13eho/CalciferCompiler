#include"part.tab.hpp"
#include<bits/stdc++.h>

using namespace std;
extern FILE * yyin;
int main()
{
    FILE * f1 = fopen("./test.sy","r");
    yyin = f1;
    int ret=yyparse();
    // cout<<yylval<<endl;
    return 0;
}