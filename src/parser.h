#include<bits/stdc++.h>
#include"scan.h"
using namespace std;

typedef enum{
    RT=400,CUN, FDV, FDI, CD, VD, IV, FFPs, FFP, B, BI, S, LV, UE,
    FRPs, ME, AE, RE, EE, LAE, LOE, PE
} GrammaType;


struct GrammaNode
{ 
    int type;
    int num;
    string str;
    vector<GrammaNode*> son;
    GrammaNode(){son.clear();}
    GrammaNode(int x){type=x;son.clear(); }
    GrammaNode(int x, int y){type=x;num = y;son.clear(); }
    GrammaNode(int x, string y){type=x;str = y;son.clear(); }
};
int CompUnitNode(TokenRec *Token,GrammaNode *SubTreeRoot);
int FuncDefV(TokenRec *Token,GrammaNode *SubTreeRoot);
int FuncDefI(TokenRec *Token,GrammaNode *SubTreeRoot);
int ConstDef(TokenRec *Token,GrammaNode *SubTreeRoot);
int VarDef(TokenRec*Token,GrammaNode *SubTreeRoot);
int InitVal(TokenRec *Token, GrammaNode *SubTreeRoot);
int FuncFParams(TokenRec *Token,GrammaNode *SubTreeRoot);
int FuncFParam(TokenRec *Token,GrammaNode *SubTreeRoot);
int Block(TokenRec*Token,GrammaNode *SubTreeRoot);
int BlockItem(TokenRec *Token, GrammaNode *SubTreeRoot);
int Stmt(TokenRec *Token,GrammaNode *SubTreeRoot);
int LVal(TokenRec*Token, GrammaNode *SubTreeRoot);
int UnaryExp(TokenRec *Token,GrammaNode *SubTreeRoot);
int FuncRParams(TokenRec *Token, GrammaNode *SubTreeRoot);
int MulExp(TokenRec *Token, GrammaNode *SubTreeRoot);
int AddExp(TokenRec*Token,GrammaNode *SubTreeRoot);
int RelExp(TokenRec *Token,GrammaNode *SubTreeRoot);
int EqExp(TokenRec *Token,GrammaNode *SubTreeRoot);
int LAndExp(TokenRec *Token, GrammaNode *SubTreeRoot);
int LOrExp(TokenRec *Token,GrammaNode *SubTreeRoot);
int PrimaryExp(TokenRec *Token,GrammaNode *SubTreeRoot);
void ErrorCatch(string s);
int parser_main(TokenRec *Token, GrammaNode *TreeRoot);
void show_tree(GrammaNode *TreeRoot,int tabcnt);
