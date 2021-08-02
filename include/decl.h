#pragma once
#include "Value.h"
#include<bits/stdc++.h>

#include "BuildIR.h" // for LinearIR
#include"dbg.h"
#include "BasicBlock.h" // for BasicBlock
using namespace std;
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
    virtual int gettype(){return 0;}
};


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
    virtual int gettype(){return 1;}
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
    virtual int gettype(){return 2;}
};

class globalDecl: public Decl{
    public:
    string dataPos;
    globalDecl(Value *_rawValue, BasicBlock *_rawBlock, string _dataPos):Decl(_rawValue,_rawBlock),dataPos(_dataPos){};
    virtual ostream& output(ostream&out)const{
        out<<"="<<dataPos;
        return out;
    }
    virtual int gettype(){return 3;}
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
    virtual int gettype(){return 4;}
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
    virtual int gettype(){return 5;}
};

class armInstr{
    public:
    Decl* rd;
    enum armInsType{add=1,sub,rsb,mul,div,mod,mov,push,pop,cmp,beq,bne,blt,ble,bgt,bge,blr,b,movlt,movle,movge,movgt,moveq,movne,ldr,str,call,ret};
    virtual ostream& output(ostream&out)const{
        out<<"@ NULL"<<endl;
        return out;
    }
    virtual int getType(){return 0;}
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
        out<<"moveq "<<*rd<<", #1";
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
        out<<"movne "<<*rd<<", #0";
        return out;
    }
};

class armAdd:public armInstr//ok
{
    public:
    Decl *r1,*r0;
    virtual int getType(){return add;}
    virtual ostream& output(ostream&out)const
    {
        out<<"add "<<*rd<<", "<<*r0<<", "<<*r1;
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

class armSub:public armInstr//ok
{
    public:
    Decl *r0,*r1;
    virtual int getType(){return sub;}
    virtual ostream& output(ostream&out)const
    {
        out<<"sub "<<*rd<<", "<<*r0<<", "<<*r1;
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
        out<<"rsb "<<*rd<<", "<<*r0<<", "<<*r1;
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
        out<<"mul "<<*rd<<", "<<*r0<<", "<<*r1;
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
        out << "div " << *rd << ", " << *r0 << ", " << *r1;
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
        out << "mod " << *rd << ", " << *r0 << ", " << *r1;
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
        if(rs!=nullptr)out<<"mov r0, "<<*rs<<endl;
        //TODO: 这里要求每个函数都需要有个一return指令..
        //TODO：或许还有一些堆栈操作..
        out<<"\tbx lr";
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rs);
        return tem;
    }
};
class armCall:public armInstr{//ok
    public:
    vector<Decl*>rs;
    string funcname;
    virtual int getType(){return call;}
    virtual ostream& output(ostream&out)const
    {
        out<<"call ";
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
    Decl *bias;
    virtual int getType(){return ldr;}
    virtual ostream& output(ostream&out)const
    {
        if(rd->gettype() == Decl::addr_decl){
            out<<"ldr r"<<((addrDecl*)rd)->Vreg<<", "<<*rs;
        }
        else 
            out<<"ldr "<<*rd<<", "<<*rs;
        if(bias){
            out<<"\t@ this is array....";//TODO: 这里以后要改.
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
    Decl *bias;
    virtual int getType(){return str;}
    virtual ostream& output(ostream&out)const
    {
        out<<"str "<<*rd<<", "<<*rs;
        if(bias){
            out<<"\t@ this is array....";//TODO: 这里以后要改.
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
    virtual ostream& output(ostream&out)const
    {
        out<<"b "<<lb;
        return out;
    }
};
class armBeq:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"beq "<<lb;
        return out;
    }
};
class armBne:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bne "<<lb;
        return out;
    }
};
class armBlt:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"blt "<<lb;
        return out;
    }
};
class armBgt:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bgt "<<lb;
        return out;
    }
};
class armBle:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"ble "<<lb;
        return out;
    }
};
class armBge:public armInstr{//no need for RIG trans of IN/OUT set
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bge "<<lb;
        return out;
    }
};

class armCmp:public armInstr{//ok
    public:
    Decl *r1,*r0;
    virtual int getType(){return cmp;}
    virtual ostream& output(ostream&out)const
    {
        out<<"cmp "<<*r0<<", "<<*r1;
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
    virtual int getType(){return mov;}
    virtual ostream& output(ostream&out)const
    {
        out<<"mov "<<*rd<<", "<<*rs;
        return out;
    }
    virtual vector<Decl*> getGen()
    {
        vector<Decl*> tem;
        tem.push_back(rs);
        return tem;
    }
};

