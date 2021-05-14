#include<bits/stdc++.h>
#include"scan.h"
using namespace std;

typedef enum{
    CUN=400, FDV, FDI, CD, VD, IV, FFPs, FFP, B, BI, S, LV, UE,
    FRPs, ME, AE, RE, EE, LAE, LOE 
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
int parser_main(TokenRec *Token, GrammaNode *TreeRoot);
void show_tree(GrammaNode *TreeRoot,int tabcnt);
