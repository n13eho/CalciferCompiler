/*
语义检查
标识符作用域分析
标识符未定义和重定义

类型检查（？）
循环体内部语法break，continue
*/
#pragma once
#include "sysy_node.hpp"
#include"../include/Value.h"
#include<bits/stdc++.h>
using namespace std;

// multimap <标识符名称， 作用域> 变量名列表
multimap<string, string> idNameList;
// map <<标识符名称， 作用域>, 结点指针> 变量列表
map<pair<string, string>, GrammaNode* > idList;

struct idTable_struct
{
    map<GrammaNode*,Value*> table;
    int addItem(string name,string scope,Value* info);
    int addItem(GrammaNode* key,Value* info);
    int askItem(string name,string scope,Value* info);
    int askItem(GrammaNode* key,Value* info);
};

void semanticAnalyzer(GrammaNode* root);
