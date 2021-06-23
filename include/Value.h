#pragma once

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
    Value(std::string name_){VName=name_;}
    Value(std::string name_,int line,std::string scope)
    {
        VName=name_;
        lineno=line;
        var_scope=scope;
    }
    //~Type() = default; default啥意思：就是默认的析构函数的意思（neho留，不过为啥不用呢
    ~Value(){}

    std::string getName(){return VName;}
    int getLine(){return lineno;}
    std::string getScope(){return var_scope;}
    
    //为减少冲突，标识名称改为VName
    std::string VName;
    //对应行号
    int lineno;
    // 变量作用域标识符
    std::string var_scope;
    
};

class IntegerValue:public Value
{
    public:
    IntegerValue(std::string name_,int line,std::string scope,int _isConst):Value(name_,line,scope){isConst=_isConst;}
    IntegerValue(std::string name_,int line,std::string scope,int intValue,int _isConst):Value(name_,line,scope)
    {
        isConst = _isConst;
        RealValue=intValue;
    }

    int getValue(){return RealValue;}
    void setValue(int intValue){RealValue=intValue;}
    int RealValue=0;
    int isConst=-1; // 0代表它不是一个cosnt，1代表是。初值为-1
    

};

// 即将被废除
class ConstArrayValue:public Value
{
    public:
    ConstArrayValue(std::string name_, int line, std::string scope,std::vector<unsigned> demen,std::vector<int> value_):Value(name_,line,scope)
    {
        ArrayElement.clear();
        ArrayElement.insert(ArrayElement.end(),value_.begin(),value_.end());
        NumOfDimension.clear();
        NumOfDimension.insert(demen.end(),demen.begin(),demen.end());
    }
    int getValue(int index){return ArrayElement[index];}
    // vector get
    private:
    std::vector<unsigned> NumOfDimension;
    std::vector<int> ArrayElement;
};

class ArrayValue:public Value
{
    public:
    ArrayValue(std::string name_,int line,std::string scope, int isConst_):Value(name_,line,scope)
    {
        isConst = isConst_;
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
    //
    int isConst;

};

class FunctionValue:public Value
{
    public:
    //int returnType是返回值的类型，1为int，0为void
    FunctionValue(std::string name_,int line,std::string scope,int paramcnt, int returnType)
    :Value(name_,line,scope)
    {
        Result=returnType;
        ParamsNum=paramcnt;
    }

    //设置函数入口
    void setEntrance(int idx){Entrance=idx;}    
    //设置函数参数列表
    void setParam(std::vector<Value *> params){FuncParams.assign(params.begin(),params.end());}
    //获取函数返回值类型
    int getResult(){return Result;}
    //获取函数参数个数
    int getParamCnt(){return ParamsNum;}
    //获取函数参数列表
    std::vector<Value *> getParams(){return FuncParams;}
    //获取函数入口
    int getEntrance(){return Entrance;}

    private:
    //函数返回值类型
    int Result;
    //参数个数
    int ParamsNum;
    //函数参数列表
    std::vector<Value *> FuncParams;
    //函数入口指令索引
    int Entrance;
    //函数出口指令索引
    int Exitance;

    
};

// 即将废弃
class ImmValue:public Value
{
    public:
    //立即数必须给值,行号和scope没必要？---要的吧。。
    ImmValue(std::string name_,int intValue):Value(name_)
    {
        RealValue=intValue;
    }
    //获取立即数的值
    int getValue(){return RealValue;}

    private:
    //立即数的值
    int RealValue;
};

// class PointerValue:Value
// {
//     public:
//     PointerValue();

//     private:
//     VType Type_=VPointer;
//     //指针指向的对象
//     Value *Contained;

// };