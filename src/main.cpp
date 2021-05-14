// #include<bits/stdc++.h>
#include "scan.h"
#include"global.h"
#include"parser.h"

// using namespace std;
TokenRec * currToken; //实例化一个TokenRec对象 
GrammaNode* tree;
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
    parser_main(currToken, tree);
    show_tree(tree,0);
}