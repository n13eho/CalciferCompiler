#include<bits/stdc++.h>
#include "scan.h"
#include"global.h"

using namespace std;

static FILE* targetFile;

int errorcnt=0;
void print_eror(string msg)
{
    errorcnt++;
    cout<<"[Error] No."<<errorcnt<<'\n';
    cout<<msg<<'\n';
}

int main(int argc, char *argv[])
{
    cout << "Hello, Calcifer." << endl;
    if(argc != 2)
    {
        cout << "usage: ..." << endl;
        exit(EXIT_FAILURE);
    }
    // string arg1(argv[1]); // convert argv[1] to string
    targetFile = fopen(string(argv[1]).c_str(), "r");

    // OriFile wenjian("test.txt");
    // TokenRec token;
    // while(token.type!=ENDF)
    // {
    //     token.get_token();
    //     if(token.type==ERROR)
    //     {
    //         print_eror(token.val.str);
    //     }
    //     token.show_token();
    // }
    
    //开始做语法分析；但由于只先写了词法分析，故就先只写个get_token()的调用
    // static int currentToken;
    static TokenRec currToken; //实例化一个TokenRec对象,该对象在栈中（？）
    // TokenRec *currToken = new TokenRec();
    while(true)
    {
        get_token();
        currToken.show_token();
        if(currToken.type == ENDF)
            break;
    }

}