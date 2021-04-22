#include "global.h"
#pragma once

union TokenVal{
    string str;
    int num;
    TokenVal(){str.clear();}
    ~TokenVal(){str.clear();}
};
class TokenRec
{
    //二元组记录token
    public:
        TokenVal val;
        int type;
    
        void get_token();
        void show_token();
};