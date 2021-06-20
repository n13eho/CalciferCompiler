#include "semanticAnalyze.h" //语义检查
#include "sysy_node.hpp"

#include <string>
#include <map>
#include <stdexcept>

using namespace std;


// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode*> idList;

//循环体栈，用于标记continue，break
GrammaNode* cycleStack[10]; // 10 for 十层循环MAX
//该栈顶
int cycleStackTop = -1;

void printIdMap()
{//这里输出的是作用域检查的结果，打印idNameList和idList的内容
#ifdef DEBUG_SCOPE
    cout << "idNameList:" << endl;
    for(auto iter = idNameList.begin(); iter != idNameList.end(); iter++)
    {
        cout << iter->first << " "<< iter->second << endl;
    }
    cout << "idList:" << endl;
    for(auto iter = idList.begin(); iter != idList.end(); iter++)
    {
        cout << iter->first.first << " " << iter->first.second <<" " << iter->second->type<<endl;
    }
#endif
}



void semanticAnalyzer(GrammaNode* root)
{
    //随时记录循环层数，检查break和continue在循环外使用的检查
    if(root->type == Stmt_While_) cycleStackTop++;

    // 针对每一个节点的类型进行语义判断和检查
    switch(root->type)
    {
        //----------------语义检查【2】----------------
        case UnaryExp_func_:
            
            break;

    }
}

