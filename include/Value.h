#include <string>
#include <vector>
enum VType {VInteger=0,VArray,VFunction};//,VPointer};

//类似于符号表中的value，还需考虑是基于树节点还是利用新建结构
class Value
{
    public:
    Value(std::string Name_);
    //~Type() = default; default啥意思
    ~Value();

    private:
    std::string Name;
};

class IntegerValue: Value
{
    public:
    IntegerValue(unsigned intValue);

    private:
    //Value Type
    VType Type_=VInteger;
    //real value
    unsigned Result;
};

class ArrayValue:Value
{
    public:
    ArrayValue();

    private:
    VType Type_ = VArray;
    //store the dimession of array
    std::vector<int> NumOfDimesson;
};

class FunctionValue:Value
{
    public:
    FunctionValue();

    private:
    VType Type_=VFunction;
    //函数返回值
    Value *Result;
    //函数参数列表
    std::vector<Value *> FuncParams;
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