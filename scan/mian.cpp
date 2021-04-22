#include<bits/stdc++.h>
#include "scan.h"
#include"global.h"
using namespace std;
int errorcnt=0;
void print_eror(string msg)
{
    errorcnt++;
    cout<<"[Error] No."<<errorcnt<<'\n';
    cout<<msg<<'\n';
}
int main()
{
    OriFile wenjian("test.txt");
    TokenRec token;
    while(token.type!=ENDF)
    {
        token.get_token();
        if(token.type==ERROR)
        {
            print_eror(token.val.str);
        }
        token.show_token();
    }
}