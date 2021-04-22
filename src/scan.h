#pragma once

#include "global.h"

union TokenVal{
    string str;
    int num;
    // TokenVal(){str.clear();}
    // ~TokenVal(){str.clear();}
};

class TokenRec
{//二元组记录token
    TokenVal val;
    int type;
    void show_token();
};

void get_token();
