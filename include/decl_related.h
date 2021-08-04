//
// Created by Neho on 2021/8/4.
//

#ifndef CALCIFER_DECL_RELATED_H
#define CALCIFER_DECL_RELATED_H

#endif //CALCIFER_DECL_RELATED_H

#include "Value.h"
#include "map"
#include "set"
#include "string"

#define MAX_BITS 32

// 立即数数字到imm_value的映射
//extern std::map<int, IntegerValue*> imm2immV;

// 这是外部（ssa.h）中的所有value存放的地方，最终在代码生成那里输出的
extern std::set<Value*> allValue;


// 给decl.h中加的立即数处理
extern std::string imm_vname;
extern int imm_cnt;


bool isValid8bit(int num);

IntegerValue* findimmValue(int num);
