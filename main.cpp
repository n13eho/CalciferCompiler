// #include<bits/stdc++.h>
#include "scan.h"
#include"global.h"

// using namespace std;

FILE* targetFile;

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        std::cout << "usage: ..." << '\n';
        exit(EXIT_FAILURE);
    }
    
    std::cout << "Hello, Calcifer." << '\n';
    // string arg1(argv[1]); // convert argv[1] to string
    targetFile = fopen(std::string(argv[1]).c_str(), "r");
    
    //开始做语法分析；但由于只先写了词法分析，故就先只写个get_token()的调用
    
    TokenRec currToken; //实例化一个TokenRec对象 
    while(true)
    {
        currToken.get_token();
        currToken.show_token();
        if(currToken.type == ENDF)
            break;
    }

}