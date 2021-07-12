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

// 语义部分调试信息打印
#define DEBUG_SEMANTIC

struct idTable_struct
{ //符号表的结构声明
    map<GrammaNode *, Value *> table;

    // 突然想到，这两个方法有必要吗
    // int addItem(string name,string scope,Value* info);
    void addItem(GrammaNode *key, Value *info);
    // Value* askItem(string name,string scope,Value* info);
    Value *askItem(GrammaNode *key);
};

// SemanticError to raise
class SemanticError : public std::exception {
public:
	SemanticError(int ln, string& name, const string& msg)
    {  
        msg_ ="\n\033[31m[SemanticError]\033[0m line " + to_string(ln) + "： " + name + " " + msg;
    }
	SemanticError(int ln, const string& msg)
    {  
        msg_ ="\n\033[31m[SemanticError]\033[0m line " + to_string(ln) + "： " + msg;
    }
	const char* what() const throw() override { return msg_.c_str(); }
private:
	string msg_;
};

// 建表+语义分析
void semanticAnalyzer(GrammaNode *root);

// 打印idLIst
void printIdMap();

// 打印符号表
void show_SymbleTable(idTable_struct* SymbolTable);