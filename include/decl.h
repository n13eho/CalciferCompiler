#pragma once

#include "Value.h"
#include "BuildIR.h" // for LinearIR
#include "dbg.h"
#include "BasicBlock.h" // for BasicBlock

#include "decl_related.h"


class armInstr;


/*
Decl的type:
1. const
2. var
3. global
4. memory
5. addr
*/
class Decl {
    public:
    Value* rawValue; //which variable
    BasicBlock* rawBlock;//which block
    vector<armInstr*> gen_used; // 记录该decl出现在那些指令的gen集合中
    double spill_cost = 0.0; // 记录该decl的spill cost，是将其移出寄存器的依据

    Decl(){}
    ~Decl(){}

    enum declType{const_decl=1, var_decl, global_decl, memory_decl, addr_decl};

    Decl(Value *_rawValue, BasicBlock *_rawBlock) : rawValue(_rawValue), rawBlock(_rawBlock){};
    virtual ostream& output(ostream&out)const{
        out<<"@NULL"<<endl;
        return out;
    }
    virtual int gettype()const{return 0;}


//    virtual ostream & output(ostream &out,bool fl)const{
//        return output(out);
//    }
};



int VregNumofDecl(Decl* d);

extern map<int, vector<Decl*>> Vreg2Decls; // 寄存器编号对应的Decl*


ostream& operator<<(ostream&out,const Decl& a);

class constDecl:public Decl{
    public:    
    int value;
    constDecl(Value *_rawValue, BasicBlock *_rawBlock,int _value):Decl(_rawValue,_rawBlock),value(_value){};
    virtual ostream& output(ostream&out)const{
        out<<"#"<<value;
        return out;
    }
    virtual int gettype()const{return 1;}
};

class varDecl:public Decl{
    public:
    int Vreg;
    varDecl(Value *_rawValue, BasicBlock *_rawBlock,int _Vreg):Decl(_rawValue,_rawBlock),Vreg(_Vreg){
        Vreg2Decls[Vreg].push_back(this);
    };
    virtual ostream& output(ostream&out)const{
        out<<"r"<<Vreg;
        return out;
    }
    virtual int gettype()const{return 2;}
};

class globalDecl: public Decl{
    public:
    string dataPos;
    globalDecl(Value *_rawValue, BasicBlock *_rawBlock, string _dataPos):Decl(_rawValue,_rawBlock),dataPos(_dataPos){};
    virtual ostream& output(ostream&out)const{
        out<<"="<<dataPos;
        return out;
    }
    virtual int gettype()const{return 3;}
};
class memoryDecl: public Decl{
    public:
    int bias;//以sp为标准, 有正负;
    memoryDecl(Value *_rawValue, BasicBlock *_rawBlock):Decl(_rawValue,_rawBlock){};
    memoryDecl(Value *_rawValue, BasicBlock *_rawBlock,int _bias):Decl(_rawValue,_rawBlock),bias(_bias){};
    virtual ostream& output(ostream&out)const{
        out<<"[sp, #"<<bias*4<<']';
        return out;
    }
    virtual int gettype()const{return 4;}
};
class addrDecl: public Decl{
    public:
    int Vreg;
    int bias=0;
    addrDecl(Value *_rawValue, BasicBlock *_rawBlock):Decl(_rawValue,_rawBlock){};
    addrDecl(Value *_rawValue, BasicBlock *_rawBlock,int _Vreg):Decl(_rawValue,_rawBlock),Vreg(_Vreg){
        Vreg2Decls[Vreg].push_back(this);
    };
    virtual ostream& output(ostream&out)const{
        if(bias==0)out<<"[r"<<Vreg<<']';
        else out<<"[r"<<Vreg<<", #"<<bias<<"]";
        return out;
    }
//    ostream & output(ostream &out,bool fl)const{
//        if(fl)out<<*this;//输出带括号的
//        else{
//            out<<"r"<<Vreg;
//        }
//        return out;
//    }

    virtual int gettype()const{return 5;}
};

class armInstr{
    public:
    Decl* rd;
    string comm;
    enum armInsType{add=1,sub,rsb,mul,div,mod,mov,push,pop,cmp,beq,bne,blt,ble,bgt,bge,blr,b,movlt,movle,movge,movgt,moveq,movne,ldr,str,call,ret,lsl};
    virtual ostream& output(ostream&out)const{
        out<<"@ NULL"<<endl;
        return out;
    }
    virtual int getType(){return 0;}
    virtual string getDest(){return nullptr;}
    virtual vector<Decl*> getGen(){vector<Decl*> tem;return tem;}
};
ostream& operator<<(ostream&out,const armInstr& a);

class armMoveq: public armInstr//ok
{
    public:
    Decl* rs;
    virtual int getType(){return moveq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tmoveq "<<*rd<<", #1";
        return out;
    }
};
class armMovne: public armInstr//ok
{
    public:
    Decl* rs;
    virtual int getType(){return movne;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tmovne "<<*rd<<", #0";
        return out;
    }
};

class armAdd:public armInstr//ok
{
    public:
    Decl *r1,*r0;
    int isAddr=0;
    virtual int getType(){return add;}
    virtual ostream& output(ostream&out)const
    {
        if(isAddr==0){
            // 处理全局变量的时候，r0和r1可能是变成了地址，所以先判断一下，如果是地址就再多输出一条ldr指令
            // r0 处理
            if(r0->gettype() == Decl::addr_decl)
                out << "\tldr r" << ((addrDecl*)r0)->Vreg << ", " << *r0 << endl;
            // r1 处理
            if(r1->gettype() == Decl::addr_decl)
                out << "\tldr r" << ((addrDecl*)r1)->Vreg << ", " << *r1 << endl;
        }

        // rd 有在数组处理的时候会变成地址，因此不输出方括号
        out << "\tadd ";
        if(rd->gettype() == Decl::addr_decl)
            out << "r" << ((addrDecl*)rd)->Vreg;
        else out << *rd;
        out << ", ";

        if(r0->gettype() == Decl::addr_decl)
            out << "r" << ((addrDecl*)r0)->Vreg;
        else out << *r0;
        out << ", ";

        if(r1->gettype() == Decl::addr_decl)
            out << "r" << ((addrDecl*)r1)->Vreg;
        else out << *r1;

//        out<<"add "<< ((rd->gettype() == Decl::addr_decl) ? (((addrDecl*)rd, false) : (*rd))) <<", "<<*r0<<", "<<*r1;

        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};

class armLsl:public armInstr//ok
{
    public:
    Decl *sh,*rs;
    int isaddr = 0 ;
    virtual int getType(){return lsl;}
    virtual ostream& output(ostream&out)const
    {
        if(isaddr == 1){
            out<<"\tlsl r"<<((addrDecl*)rd)->Vreg<<", r"<<((addrDecl*)rs)->Vreg<<", "<<*sh;
        }
        else{
            // out<<"\tlsl "<<*rd<<", "<<*rs<<", "<<*sh;
            //TODO: 向add学习!
            out<<"zhe bu ke neng ";
        }
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rs);
        return tem;
    }
};
class armSub:public armInstr//ok
{
    public:
    Decl *r0,*r1;
    virtual int getType(){return sub;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tsub "<<*rd<<", "<<*r0<<", "<<*r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};
class armRsb:public armInstr//ok
{// r1 maybe imm/const, but r0 is var_decl for sure
    public:
    Decl *r0,*r1;
    virtual int getType(){return rsb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\trsb "<<*rd<<", "<<*r0<<", "<<*r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};

class armMul:public armInstr{//ok
    public:
    Decl *r0,*r1;
    virtual int getType(){return mul;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tmul "<<*rd<<", "<<*r0<<", "<<*r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }

};
class armDiv:public armInstr{//ok   In this ir, leave it like this
public:
    Decl *r0, *r1;
    virtual int getType(){return div;}
    virtual ostream& output(ostream&out)const
    {
        out << "\tdiv " << *rd << ", " << *r0 << ", " << *r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};
class armMod:public armInstr{//ok   In this ir, leave it like this
public:
    Decl *r0, *r1;
    virtual int getType(){return mod;}
    virtual ostream& output(ostream&out)const
    {
        out << "\tmod " << *rd << ", " << *r0 << ", " << *r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};
class armRet:public armInstr//ok
{
    public:
    Decl *rs;
    virtual int getType(){return ret;}
    virtual ostream& output(ostream&out)const
    {
        if(rs!=nullptr)out<<"\tmov r0, "<<*rs<<endl;
        //TODO: 这里要求每个函数都需要有个一return指令..
        //TODO：或许还有一些堆栈操作..
        out<<"\tbx lr";
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        if(rs!=nullptr)tem.push_back(rs);
        return tem;
    }
};

class armPush:public armInstr{
    //这个push是专门针对函数调用的
public:
    Decl* exp=nullptr;//这个不需要push
    virtual int getType(){return push;}
    virtual ostream& output(ostream&out)const
    {
        int rdNum = -1;  //函数返回值
        if(exp!= NULL)
        {
            rdNum = VregNumofDecl(exp);
            if(rdNum==0)out<<"\tpush {r1-r12}";
            else if(rdNum == 12)out<<"\tpush {r0-r11}";
            else if(rdNum == 11)out << "\tpush {r0-r10, r12}";
            else{
                out<<"\tpush {r0-r"<<rdNum-1<<", r"<<rdNum+1<<"-r12}";
            }
        }
        else
        {
            out<<"\tpush {r0-r12}";
        }
        return out;
    }
};
class armCall:public armInstr{//ok
    public:
    vector<Decl*>rs;
    string funcname;

    armPush* push_ins = NULL; // 这条call指令对应的push指令指针

    virtual int getType(){return call;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tcall ";
        out<<funcname<<' ';
        for(auto r : rs){
            out<<*r<<" ";
        }
        if(rd!=nullptr)out<<*rd;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        return rs;
    }
};
class armLdr:public armInstr{//ok??????????? //TODO: now array is different!
    public:
    Decl *rs;
    int bias;
    virtual int getType(){return ldr;}
    virtual ostream& output(ostream&out)const
    {
        if(rd->gettype() == Decl::addr_decl){
            out<<"\tldr r"<<((addrDecl*)rd)->Vreg<<", "<<*rs;
        }
        else{
            out<<"\tldr "<<*rd;
            if(bias){
                out<<", [r"<<((addrDecl*)rs)->Vreg<<", #"<<bias*4<<"]"<<"\t@ this is array....";//TODO: 这里以后要改.
            }
            else{
                out<<", "<<*rs;
            }
        }
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rs); // 因为rs可以能还是[=a]这种情况
        return tem;
    }
};
class armStr:public armInstr{//ok
    public:
    Decl *rs;//str中rs其实是目的位置！！！！！！！！！
    int bias;
    virtual int getType(){return str;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tstr "; //<<*rd;
        if(rd->gettype() == Decl::addr_decl){ // 只需要存储地址，把壳脱了
            addrDecl* addr_rd = (addrDecl*)rd;
            out << "r" << addr_rd->Vreg;
        }
        else{
            out << *rd;
        }
        if(bias){
            
            out<<", [r"<<((addrDecl*)rs)->Vreg<<", #"<<bias*4<<"]"<<"\t@ this is array....";//TODO: 这里以后要改.
        }
        else{
            out<<", "<<*rs;
        }
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rd);
        tem.push_back(rs);
        return tem;
    }
};
class armB:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    
    virtual ostream& output(ostream&out)const
    {
        out<<"\tb "<<lb;
        return out;
    }
};
class armBeq:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tbeq "<<lb;
        return out;
    }
};
class armBne:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tbne "<<lb;
        return out;
    }
};
class armBlt:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tblt "<<lb;
        return out;
    }
};
class armBgt:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tbgt "<<lb;
        return out;
    }
};
class armBle:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tble "<<lb;
        return out;
    }
};
class armBge:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual string getDest(){return lb;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tbge "<<lb;
        return out;
    }
};

class armCmp:public armInstr{//ok
    public:
    Decl *r1,*r0;
    virtual int getType(){return cmp;}
    virtual ostream& output(ostream&out)const
    {
        out<<"\tcmp "<<*r0<<", "<<*r1;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(r0);
        tem.push_back(r1);
        return tem;
    }
};

class armMov:public armInstr{//ok
    public:
    Decl *rs;
    bool isaddress = 0; // 就是需要地址，不要翻译成ldr进来的值了！！！！！
    virtual int getType(){return mov;}
    virtual ostream& output(ostream&out)const
    {
        if(comm.length())out<<comm<<endl;
        if(rd->gettype() == Decl::addr_decl)
        { // rd是addr_decl
            if(rs->gettype() == Decl::addr_decl){
                out<<"@ This is possible??????I have no idea. ----hsyy04\n";
                out<<"@ 我先临时乱写一下. ----neho\n";
                out << "\tmov r" << ((addrDecl*)rd)->Vreg << ", r" << ((addrDecl*)rs)->Vreg;
            }
            else if(rs->gettype()==Decl::memory_decl)
            {
                out<<"@ This is possible??????I have no idea. ----hsyy04\n";
            }
            else{
                out<<"\tstr "<<*rs<<", "<<*rd;
            }
        }
        else if(rd->gettype() == Decl::memory_decl)
        { // rd是memory_decl
            if(rs->gettype() == Decl::addr_decl){
                out<<"@ This is possible??????I have no idea. ----hsyy04\n";
            }
            else if(rs->gettype()==Decl::memory_decl){
                out<<"@ This is possible??????I have no idea. ----hsyy04\n";
            }
            else{
                out<<"\tstr "<<*rs<<", "<<*rd;
            }
        }
        else
        { // rd就是var_decl
            if(rs->gettype() == Decl::addr_decl && !isaddress){ // ldr 进来值
                out << "@@mov trans to ldr to get it's value\n";
                out<<"\tldr "<<*rd<<", "<<*rs;
            }
            else if(rs->gettype() == Decl::addr_decl && isaddress){ // address is exactly what i want
                out << "@@address is exactly what i want\n";
                out<<"\tmov "<<*rd<<", r"<<((addrDecl*)rs)->Vreg;
            }

            else if(rs->gettype()==Decl:: memory_decl){
                dbg("不可能出现");
            }
            else if(rs->gettype() == Decl::const_decl){ // rs是立即数的话要分为三种情况讨论
                constDecl* const_rs = (constDecl*)rs;

                if(isValid8bit(const_rs->value)){// 1. 8-bits范围内的，合法，直接输出
                    out<<"\tmov "<<*rd<<", "<<*rs;
                }
                else if(!isValid8bit(const_rs->value) && (const_rs->value < 0xffff && const_rs->value >= 0)){ // 2. 不合法8-bit但是小于0xffff
//                    dbg(const_rs->value);
                    out<<"\tmovw "<<*rd<<", "<<*rs;
                }
                else{ // 这里得用个什么字面池了，可能就有4096偏移的限制，并不知道怎么处理，先用 FIXME: limitation of 4096
//                    dbg(const_rs->value);
                    // 1 先往allValue里面扔一个新的integerValue，要么扔，要么从原先的找出来对应的
//                    IntegerValue* imm_valuew = new IntegerValue(imm_vname+to_string(imm_cnt++), 999, "1", const_rs->value, 0);
//                    allValue.insert(imm_valuew);

                    IntegerValue* imm_value = findimmValue(const_rs->value);

                    // 2 这里的mov要变成ldr，然后再ldr一遍获得它的值
                    out << "@@@ the mov turn to ldr cause the illegal immediate integer\n";
                    out << "\tldr " << *rd << ", " << "=" << imm_value->VName << "\n";
                    out << "\tldr " << *rd << ", [" << *rd << "]";
                }

            }
            else{
                out<<"\tmov "<<*rd<<", "<<*rs;
            }
        }
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rs);
        return tem;
    }
};