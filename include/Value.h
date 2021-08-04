#pragma once

#include "util.h"

#include <string>
#include <vector>

enum VType{
    VInteger=0,
    VArray,
    VFunction,
    //立即数
    VImm
};


class Value
{
    public:
    //考虑立即数不需要scope
    virtual int getType(){return 0;}
    //1.整数
    //2.数组
    //3.函数
    Value(std::string name_){VName=name_;}
    Value(std::string name_,int line,std::string scope)
    {
        VName=name_;
        lineno=line;
        var_scope=scope;
    }

    ~Value() = default;//默认的析构函数

    std::string getName(){return VName;}
    int getLine(){return lineno;}
    std::string getScope(){return var_scope;}
    
    //为减少冲突，标识名称改为VName
    std::string VName;
    //对应行号
    int lineno;
    // 变量作用域标识符
    std::string var_scope;
    // Value类型
    int valueType;
    int isPara=0; // 代表他是第几个参数
};

class IntegerValue:public Value
{
    public:
    DEFINE_CLASSOF(Value, p->valueType == VType::VInteger);
    virtual int getType(){return 1;}
    IntegerValue(std::string name_,int line,std::string scope,int _isConst):Value(name_,line,scope){isConst=_isConst;}
    IntegerValue(std::string name_,int line,std::string scope,int intValue,int _isConst):Value(name_,line,scope)
    {
        isConst = _isConst;
        RealValue=intValue;
        valueType = VType::VInteger;
    }

    int getValue(){return RealValue;}
    void setValue(int intValue){RealValue=intValue;}
    int RealValue=0;
    int isConst=-1; // 0代表它不是一个cosnt，1代表是。初值为-1
    

};

class ArrayValue:public Value
{
    public:
    DEFINE_CLASSOF(Value, p->valueType == VType::VArray);
    virtual int getType(){return 2;}
    ArrayValue(std::string name_,int line,std::string scope, int isConst_):Value(name_,line,scope)
    {
        isConst = isConst_;
        valueType = VType::VArray;
    }

    void setDimen(std::vector<unsigned> dimen){NumOfDimension.assign(dimen.begin(), dimen.end());}
    //重新数组赋值（用于归零）
    void setArray(std::vector<int> ele){ArrayElement.assign(ele.begin(), ele.end());}
    //赋值
    void setValue(int index,int ele){ArrayElement[index]=ele;}
    //访问
    int getValue(int index){return ArrayElement[index];}
    //获取数组各维信息
    std::vector<unsigned> getDimen(){return NumOfDimension;}


    //store the dimension of array
    std::vector<unsigned> NumOfDimension;
    //具体值
    std::vector<int> ArrayElement;
    
    //变量数组的初始值
    std::vector<Value*> ArrayInitList;
    int isConst;

};

class FunctionValue:public Value
{
    public:
    DEFINE_CLASSOF(Value, p->valueType == VType::VFunction);
    virtual int getType(){return 3;}
    //int returnType是返回值的类型，1为int，0为void
    FunctionValue(std::string name_,int line,std::string scope,int paramcnt, int returnType)
    :Value(name_,line,scope)
    {
        Result=returnType;
        ParamsNum=paramcnt;
        valueType = VType::VFunction;
    }

    //设置函数参数列表
    void setParam(std::vector<Value *> params){FuncParams.assign(params.begin(),params.end());}
    //获取函数返回值类型
    int getResult(){return Result;}
    //获取函数参数个数
    int getParamCnt(){return ParamsNum;}
    //获取函数参数列表
    std::vector<Value *> getParams(){return FuncParams;}

    // private:
    //函数返回值类型，1为int，0为void
    int Result;
    //参数个数
    int ParamsNum;
    //函数参数列表
    std::vector<Value *> FuncParams;
};

class ImmValue:public Value
{
    public:
    DEFINE_CLASSOF(Value, p->valueType == VType::VImm);
    virtual int getType(){return 4;}
    //立即数必须给值,行号和scope没必要？---要的吧。。
    ImmValue(std::string name_,int intValue):Value(name_)
    {
        RealValue=intValue;
        valueType = VType::VImm;
    }
    //获取立即数的值
    int getValue(){return RealValue;}

    // private:
    //立即数的值
    int RealValue;
};
