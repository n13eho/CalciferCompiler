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
{Instruction::InsType::Break, "break"},{Instruction::InsType::Alloc,"Allocate"},{Instruction::InsType::Phi,"phi"}};

void printIns(int id)
{
    Instruction* presenIns = IR1->InstList[id];
    std::cout << presenIns;
}

void show_block(BasicBlock* node,int dep,BasicBlock* father,int way)
{

    vis[node]=1;
    for(int i=1;i<=dep*4;i++)cerr<<' ';
    // cerr<<DEBUG_blkOP[node->bType]<<endl;
    cerr<<node;
    if(father!=nullptr)cerr<<"("<<father<<")"<<"["<<way<<"]"<<endl;
    else cerr<<endl;
    for(auto i : node->InstrList){
        for(int i=1;i<=dep*4;i++)cerr<<' ';
        printIns(i);
    }
     for(auto i : node->succBlock)
     {
         if(!vis[i]){
#ifdef DEBUG_ON
            show_block(i,dep,node,1);  
#endif
            
        }
     }
    for(auto i : node->domBlock)
    {
        if(!vis[i]){
#ifdef DEBUG_ON
            show_block(i,dep+1,node,2);   
#endif
            
            }
    }
}
map<BasicBlock*, bool> viscfg;
set<BasicBlock*> other;

void outputsuc(BasicBlock* s)
{
    viscfg[s]=1;
    for(auto eb:s->succBlock){
        cerr<<"succ:";
        dbg(eb);
        dbg(eb->BlockName);
        for(auto i : eb->InstrList)
            printIns(i);
        other.insert(eb);
    }
}

void show_cfg()
{
    for(auto gb:IR1->Blocks){
        std::cout << gb->BlockName;
        for(auto i : gb->InstrList)
            printIns(i);
        for(auto b:gb->domBlock){
            std::cout <<"dom:";
            std::cout << b->BlockName;
            for(auto i : b->InstrList)
                printIns(i);
            if(!viscfg[b])outputsuc(b);
            std::cout <<endl;
        }
        std::cout << endl;
    }
    std::cout << "-----------------------------------";
    for(auto ot:other){
        if(viscfg[ot])continue;
        if(!viscfg[ot])outputsuc(ot);
    }
}
