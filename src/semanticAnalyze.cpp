#include "semanticAnalyze.h" //语义检查
#include "sysy_node.hpp"

#include <string>
#include <map>

using namespace std;


// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode*> idList;

void semanticAnalyzer(GrammaNode* root)
{
#ifdef DEBUG_SCOPE
    cout << "idNameList:" << endl;
    for(auto iter = idNameList.begin(); iter != idNameList.end(); iter++)
    {
        cout << iter->first << " "<< iter->second << endl;
    }
    cout << "idList:" << endl;
    for(auto iter = idList.begin(); iter != idList.end(); iter++)
    {
        cout << iter->first.first << " " << iter->first.second << endl;
    }
#endif
}

