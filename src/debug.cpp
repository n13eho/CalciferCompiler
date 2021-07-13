#include<bits/stdc++.h>
#include"../include/debug.h"
using namespace std;

map<BasicBlock*,int> vis;

map<int,string> DEBUG_blkOP={{BasicBlock::While,"while"},{BasicBlock::If,"if"},{BasicBlock::Basic,"basic"},{BasicBlock::Continue,"continue"},{BasicBlock::Break,"break"}};

std::map<int, string> DEBUG_insOP = {{Instruction::InsType::Add, "+"}, {Instruction::InsType::Sub, "-"},
{Instruction::InsType::Mul, "*"}, {Instruction::InsType::Div, "/"}, {Instruction::InsType::Mod, "%"},
{Instruction::InsType::UnaryPos, "single+"}, {Instruction::InsType::UnaryNeg, "single-"},
{Instruction::InsType::UnaryNot, "single!"}, {Instruction::InsType::Assign, "="},
{Instruction::InsType::LogicAnd, "&&"}, {Instruction::InsType::LogicOr, "||"},
{Instruction::InsType::ArithEq, "=="}, {Instruction::InsType::ArithNeq, "!="},
{Instruction::InsType::ArithLT, "<"}, {Instruction::InsType::ArithBG, ">"},
{Instruction::InsType::ArithLQ, "<="}, {Instruction::InsType::ArithGQ, ">="},
{Instruction::InsType::Jmp, "J"}, {Instruction::InsType::ConBr, "Br"},
{Instruction::InsType::Call, "Call"}, {Instruction::InsType::Ret, "return"},
{Instruction::InsType::Load, "Load"}, {Instruction::InsType::Store, "Store"},
{Instruction::InsType::Break, "break"}};

void printIns(int id)
{
    
    Instruction* presenIns = IR1->InstList[id];
    cout << presenIns->getId() << "\t" << DEBUG_insOP[presenIns->getOpType()] << "\t";

    if(presenIns->getOpType() == Instruction::Jmp|| presenIns->getOpType() == Instruction::ConBr)
    {
        if(nullptr != presenIns->jmpDestBlock)
        {
            cout<<presenIns->jmpDestBlock->BlockName << presenIns->jmpDestBlock->getFirstIns()<<endl;
        }
        // if(nullptr!=presenIns->getResult())
            // cout<<((IntegerValue*)presenIns->getResult())->RealValue<<endl;
        else
            cout<<endl;
        return ;
    }
    for(int i = 0; i < presenIns->getOp().size(); i++)std::cout << presenIns->getOp()[i]->VName << ":"<<((IntegerValue*)presenIns->getOp()[i])->RealValue<< "\t";
    if(presenIns->getOp().size() == 1) cout << "\t";

    // ready to try template of casting

    if(presenIns->getOpType() == Instruction::InsType::Ret)
    { // Retrun 语句没有reslut，访问空0 segmentation fault
        cout << endl;
    }
    else{cout << presenIns->getResult()->VName << endl;}
}

void show_block(BasicBlock* node,int dep)
{

    vis[node]=1;
    for(int i=1;i<=dep*4;i++)cout<<' ';
    // cout<<DEBUG_blkOP[node->bType]<<endl;
    cout<<node->BlockName<<endl;
    for(auto i : node->InstrList){
        for(int i=1;i<=dep*4;i++)cout<<' ';
        printIns(i);
    }
     for(auto i : node->succBlock)
     {
         if(!vis[i])show_block(i,dep);
     }
    for(auto i : node->domBlock)
    {
        if(!vis[i])show_block(i,dep+1);
    }
}
