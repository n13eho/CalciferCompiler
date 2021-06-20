/*
语义检查
标识符作用域分析
标识符未定义和重定义

类型检查（？）
循环体内部语法break，continue
*/
#pragma once

#include "sysy_node.hpp"
#include "../include/Value.h"

#include <map>
using namespace std;

struct idTable_struct
{ //符号表的结构声明
    map<GrammaNode *, Value *> table;

    // 突然想到，这两个方法有必要吗
    // int addItem(string name,string scope,Value* info);
    void addItem(GrammaNode *key, Value *info);
    // Value* askItem(string name,string scope,Value* info);
    Value *askItem(GrammaNode *key);
};

void semanticAnalyzer(GrammaNode *root);
void printIdMap();