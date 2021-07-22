#pragma once
#include "Value.h"
#include<bits/stdc++.h>

#include "BuildIR.h" // for LinearIR
#include "BasicBlock.h" // for BasicBlock
using namespace std;
class armInstr;

class Decl {
    public:
    Value* rawValue; //which variable
    BasicBlock* rawBlock;//which block
    vector<armInstr*> usesd; //which instruction uses it; 不知道是不是有用...
    Decl(){}
    ~Decl(){}
    Decl(Value *_rawValue, BasicBlock *_rawBlock) : rawValue(_rawValue), rawBlock(_rawBlock){};
    // friend ostream & operator << (ostream &out,const Decl &A){
    //     out<<"@ NULL";
    //     return out;
    // }
    virtual ostream& output(ostream&out)const{
        out<<"@NULL"<<endl;
        return out;
    }
    virtual int gettype(){return 0;}
};

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
    varDecl(Value *_rawValue, BasicBlock *_rawBlock,int _Vreg):Decl(_rawValue,_rawBlock),Vreg(_Vreg){};
    virtual ostream& output(ostream&out)const{
        out<<"r"<<Vreg;
        return out;
    }
    virtual int gettype(){return 2;}
};

class armInstr{
    public:
    Decl* rd;
    enum type{add=1,sub,mul,div,mod,andd,orr,mov,ldr,str,push,pop,cmp,beq,bne,blt,ble,bgt,bge,blr,movlt,movle,movge,movgt,moveq,movne} ;
    virtual ostream& output(ostream&out)const{
        out<<"@ NULL"<<endl;
        return out;
    }
    virtual int getType(){return 0;}
};
ostream& operator<<(ostream&out,const armInstr& a);

class armAdd:public armInstr
{
    public:
    Decl *r1,*r0;
    virtual int getType(){return add;}
    virtual ostream& output(ostream&out)const
    {
        out<<"add "<<*rd<<", "<<*r0<<", "<<*r1;
        return out;
    }
};

class armSub:armInstr{};
class armMul:armInstr{};
class armDiv:armInstr{};
class armMod:armInstr{};
class armAnd:armInstr{};
class armOrr:armInstr{};
class armBeq:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"beq "<<lb;
        return out;
    }
};
class armBne:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bne "<<lb;
        return out;
    }
};
class armBlt:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"blt "<<lb;
        return out;
    }
};
class armBgt:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bgt "<<lb;
        return out;
    }
};
class armBle:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"ble "<<lb;
        return out;
    }
};
class armBge:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"bge "<<lb;
        return out;
    }
};

class armCmp:public armInstr{
    public:
    Decl *r1,*r0;
    virtual int getType(){return cmp;}
    virtual ostream& output(ostream&out)const
    {
        out<<"cmp "<<*r1<<", "<<*r0;
        return out;
    }
};

class armMov:public armInstr{
    public:
    Decl *rs;
    virtual int getType(){return mov;}
    virtual ostream& output(ostream&out)const
    {
        out<<"mov "<<*rd<<", "<<*rs;
        return out;
    }
};

