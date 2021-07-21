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
    armInstr* birth; //which instruction has the value;不知道是不是有用...
    vector<armInstr*> usesd; //which instruction uses it; 不知道是不是有用...
    Decl(){}
    ~Decl(){}
    Decl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth) : rawValue(_rawValue), rawBlock(_rawBlock), birth(_birth){};
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
    constDecl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth,int _value):Decl(_rawValue,_rawBlock,_birth),value(_value){};
    virtual ostream& output(ostream&out)const{
        out<<"#"<<value;
        return out;
    }
    virtual int gettype(){return 1;}
};

class varDecl:public Decl{
    public:
    int Vreg;
    varDecl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth,int _Vreg):Decl(_rawValue,_rawBlock,_birth),Vreg(_Vreg){};
    virtual ostream& output(ostream&out)const{
        out<<"r"<<Vreg;
        return out;
    }
    virtual int gettype(){return 2;}
};

class armInstr{
    public:
    enum type{add=1,sub,mul,div,mod,andd,orr,mov,ldr,str,push,pop,cmp,beq,blr} ;
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
    Decl *rd,*r0;
    Decl *r1;
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
class armBeq:armInstr{
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"beq "<<lb;
        return out;
    }
};

class armCmp:armInstr{
    Decl *r1,*r0;
    virtual int getType(){return cmp;}
    virtual ostream& output(ostream&out)const
    {
        out<<"cmp "<<*r1<<", "<<*r0;
        return out;
    }
};

class armMov:armInstr{
    public:
    Decl *rd;
    Decl *rs;
    virtual int getType(){return mov;}
    virtual ostream& output(ostream&out)const
    {
        out<<"mov "<<*rd<<", "<<*rs;
        return out;
    }
};

