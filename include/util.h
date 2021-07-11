//
// Created by Neho on 2021/7/11.
//

#ifndef CALCIFER_UTIL_H
#define CALCIFER_UTIL_H

#endif //CALCIFER_UTIL_H

#define DEFINE_ILIST(cls) cls *prev; cls *next;

#define DEFINE_CLASSOF(cls, cond) static bool classof(const cls *p) { return cond; }