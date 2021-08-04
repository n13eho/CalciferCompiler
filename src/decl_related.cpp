//
// Created by Neho on 2021/8/4.
//

#include "decl_related.h"

std::map<int, IntegerValue*> imm2immV;

bool isValid8bit(int num)
{ // 该立即数是否是合法的arm立即数
    // back doors
    if(num == 0)return true;

    auto ror = [](int val, int r_bits, int max_bits){
        return ((val & ( (1LL<<max_bits) - 1)) >> r_bits%max_bits) | (val << (max_bits-(r_bits%max_bits)) & ((1LL<<max_bits)-1));
    };

    for(int i = 1; i < 256; i++)
    {
        for(int j = 0; j < 31; j = j + 2)
        {
            int rotated = ror(i, j, MAX_BITS);
            if(rotated == num)return true;
        }
    }
    return false;
}

IntegerValue* findimmValue(int num)
{ // 找到或者new一个立即数对应的IntegerValue
    for(auto iter: imm2immV)
    {
        if(iter.first == num){
            return iter.second;
        }
    }
    // 否则就是没找见，新new一个扔到allValue里面，然后建立这个映射
    IntegerValue* imm_value = new IntegerValue(imm_vname+std::to_string(imm_cnt++), 999, "1", num, 0);
    allValue.insert(imm_value);
    imm2immV[num] = imm_value;
    return imm_value;
}