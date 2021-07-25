#pragma once
#include "Value.h"
#include<bits/stdc++.h>

#include "BuildIR.h" // for LinearIR
#include "BasicBlock.h" // for BasicBlock
using namespace std;
class armInstr;

/*
Decl的type:
1. const
2. var
3. global
4. memory
*/
class Decl {
    public:
    Value* rawValue; //which variable
    BasicBlock* rawBlock;//which block
    vector<armInstr*> usesd; //which instruction uses it; 不知道是不是有用...
    Decl(){}
    ~Decl(){}
    Decl(Value *_rawValue, BasicBlock *_rawBlock) : rawValue(_rawValue), rawBlock(_rawBlock){};
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

class globalDecl: public Decl{
    public:
    string dataPos;
    globalDecl(Value *_rawValue, BasicBlock *_rawBlock, string _dataPos):Decl(_rawValue,_rawBlock),dataPos(_dataPos){};
    virtual ostream& output(ostream&out)const{
        out<<"="<<dataPos;
        return out;
    }
    virtual int gettype(){return 2;}
};
class memoryDecl: public Decl{
    public:
    int bias;//以sp为标准, 有正负, 输出时不乘四...
    memoryDecl(Value *_rawValue, BasicBlock *_rawBlock):Decl(_rawValue,_rawBlock){};
    memoryDecl(Value *_rawValue, BasicBlock *_rawBlock,int _bias):Decl(_rawValue,_rawBlock),bias(_bias){};
    virtual ostream& output(ostream&out)const{
        out<<"[sp,#"<<bias<<']';
        return out;
    }
    virtual int gettype(){return 2;}
};

class armInstr{
    public:
    Decl* rd;
    enum type{add=1,sub,mul,div,mod,mov,push,pop,cmp,beq,bne,blt,ble,bgt,bge,blr,b,movlt,movle,movge,movgt,moveq,movne,ldr,str};
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

class armSub:public armInstr{};
class armMul:public armInstr{};
class armDiv:public armInstr{};
class armMod:public armInstr{};
class armLdr:public armInstr{
    public:
    Decl *rs;
    virtual int getType(){return ldr;}
    virtual ostream& output(ostream&out)const
    {
        out<<"ldr "<<*rd<<", "<<*rs;
        return out;
    }
};
class armStr:public armInstr{
    public:
    Decl *rs;//str中rs其实是目的位置！！！！！！！！！
    virtual int getType(){return str;}
    virtual ostream& output(ostream&out)const
    {
        out<<"str "<<*rd<<", "<<*rs;
        return out;
    }
};
class armB:public armInstr{
    public:
    string lb;
    virtual int getType(){return beq;}
    virtual ostream& output(ostream&out)const
    {
        out<<"b "<<lb;
        return out;
    }
};
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
        out<<"cmp "<<*r0<<", "<<*r1;
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

