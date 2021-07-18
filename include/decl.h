#pragma once
#include"armInstruciton.h"
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
    armInstr* birth; //which instruction has the value;
    vector<armInstr*> usesd; //which instruction uses it;
    Decl(){}
    ~Decl(){}
    Decl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth) : rawValue(_rawValue), rawBlock(_rawBlock), birth(_birth){};
    
};


class constDecl:public Decl{
    public:    
    int value;
    constDecl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth,int _value):Decl(_rawValue,_rawBlock,_birth),value(_value){};
};

class varDecl:public Decl{
    public:
    int Vreg;
    varDecl(Value *_rawValue, BasicBlock *_rawBlock, armInstr *_birth,int _Vreg):Decl(_rawValue,_rawBlock,_birth),Vreg(_Vreg){};

};

class armInstr{
    public:
    enum type{add=1,sub,mul,div,mod,andd,orr,mov,ldr,str,push,pop} ;
    virtual ostream & operator << (ostream &out){
        // out<<"@ NULL\n";
    }
    virtual int getType(){return 0;}
};

class armAdd:public armInstr
{
    public:
    Decl *rd;
    Decl *r0,*r1;
    virtual int getType(){return add;}
    virtual ostream & operator<<(ostream &out){
        // out<<"add ";
        // out<<(*rd)<<", "<<*r0<<", "<<*r1;
        // return out;
    }
};

class armSub:armInstr{};
class armMul:armInstr{};
class armDiv:armInstr{};
class armMod:armInstr{};
class armAnd:armInstr{};
class armOrr:armInstr{};
class armMov:armInstr{};



extern ostream & operator << (ostream &out,const Decl *A);
extern ostream & operator << (ostream &out,const constDecl *A);
extern ostream & operator << (ostream &out,const varDecl *A);
