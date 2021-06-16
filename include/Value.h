#include <string>
#include <vector>
enum VType {
    VInteger=0,
    VArray,
    VFunction,
    //立即数
    VImm};//,VPointer};


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
    //~Type() = default; default啥意思
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
    IntegerValue(std::string name_,int line,std::string scope,int intValue):Value(name_,line,scope)
    {
        
        RealValue=intValue;
    }

    int getValue(){return RealValue;}
    void setValue(int intValue){RealValue=intValue;}

    private:
    //real value
    int RealValue=0;
};

class ArrayValue:public Value
{
    public:
    ArrayValue(std::string name_,int line,std::string scope):Value(name_,line,scope){}

    void setDimen(std::vector<int> dimen){NumOfDimension.assign(dimen.begin(), dimen.end());}
   
    //重新数组赋值
    void setArray(std::vector<int> ele){ArrayElement.assign(ele.begin(), ele.end());}
    //设置row行col列元素值
    void setValue(int row,int col,int ele)
    {
        int index = col;
        for(int i=0;i<row;i++)
        {
            index+=(NumOfDimension[i]);
        }
        ArrayElement[index]=ele;
    }
    //获取row行col列的元素
    int getEle(int row,int col)
    {
        int index = col;
        for(int i=0;i<row;i++)
        {
            index+=(NumOfDimension[i]);
        }
        return ArrayElement[index];
    }
    //获取数组各维信息
    std::vector<int> getDimen(){return NumOfDimension;}
    // //获取数组维数
    // int getArrayDim()
    // {
    //     return NumOfDimension.size();
    // }
    // //获取数组第row行维数
    // int getArrayDim(int row)
    // {
    //     if(row<NumOfDimension.size())
    //     {
    //         return NumOfDimension[row];
    //     }
    //     else
    //     {
    //         //error
    //         return -1;
    //     }
    // }


    private:
    //store the dimension of array
    std::vector<int> NumOfDimension;
    //具体值
    std::vector<int> ArrayElement;
};

class FunctionValue:public Value
{
    public:
    FunctionValue(std::string name_,int line,std::string scope,Value* ret,int paramcnt):Value(name_,line,scope)
    {
        Result=ret;
        ParamsNum=paramcnt;
    }
    
    //设置函数参数列表
    void setParam(std::vector<Value *> params){FuncParams.assign(params.begin(),params.end());}
    //获取函数返回值
    Value* getResult(){return Result;}
    //获取函数参数个数
    int getParamCnt(){return ParamsNum;}
    //获取函数参数列表
    std::vector<Value *> getParams(){return FuncParams;}
    

    private:
    //函数返回值
    Value *Result;
    //参数个数
    int ParamsNum;
    //函数参数列表
    std::vector<Value *> FuncParams;
};

class ImmValue:public Value
{
    public:
    //立即数必须给值,行号和scope没必要？
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