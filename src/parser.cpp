#include "parser.h"
#include "scan.h"
#include <bits/stdc++.h>
static int errorcnt = 0;
//所有的函数,开始时,Token已经读了这个模块的第一个;结束时,Token已经读了下一个模块的第一个.


std::map<int, std::string> typetablep = {
{Ident, "Idengt"}, {IntConst, "IntConst"}, {IF, "if"}, {ELSE, "else"}, {WHILE, "while"}, {BREAK, "break"}, {CONTINUE, "continue"}, {RETURN, "return"},
{ASSIGN, "Symble"},{ADD, "Operator"}, {SUB, "Operator"}, {DIV, "Operator"}, {MUL, "Operator"}, {MOD, "Operator"}, {EQ, "Operator"},
{NEQ, "Operator"}, {OR, "Operator"}, {AND, "Operator"}, {NOT, "Operator"}, {LT, "Operator"}, {LQ, "Operator"}, 
{BG, "Operator"}, {BQ, "Operator"},{RT,"root"},{CUN,"cmpUnit"},{FDV,"void function"},{FDI,"int function"},
{CD, "constdf"},{VD,"vardf"},{IV,"initVar"},{FFP,"FuncFParam"},{FFPs,"FuncFParams"},{B,"Block"},{BI,"BlockItem"},{S,"stmt"},
{LV,"lv"},{UE,"UnaryExp"},{FRPs,"FunRParams"},{ME,"MulExp"},{AE,"AddExp"},{RE,"RelExp"},{LAE,"LogiAndExp"},{LOE,"LogicOrExp"}
};

int CompUnitNode(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode;
    SubTreeRoot->type = CUN;
    if (Token->type == CONST)
    {
        // 去匹配常数声明
        Token->get_token();
        if (Token->type == INT)
        {
            Token->get_token();
            while (1)
            {
                GrammaNode *newSon = new GrammaNode();
                retcode = ConstDef(Token, newSon);
                if (retcode >= 0)
                    SubTreeRoot->son.push_back(newSon);
                if (Token->type == COMM)
                    Token->get_token();
                else if (Token->type == SEMI)
                {
                    Token->get_token();
                    break;
                }
                else
                    ErrorCatch("Excepted ;");
            }
        }
    }
    else if (Token->type == VOID)
    {
        // get one void func tree
        Token->get_token();
        GrammaNode *newSon = new GrammaNode();
        retcode = FuncDefV(Token, newSon);
        if (retcode >= 0)
            SubTreeRoot->son.push_back(newSon);
    }
    else if (Token->type == INT)
    {
        Token->get_token();
        if (Token->type == Ident)
        {
            GrammaNode *newSub = new GrammaNode();
            newSub->son.push_back(new GrammaNode(Ident, Token->val.val_str));
            Token->get_token();
            if (Token->type == RDBRAL)
            {
                Token->get_token();
                retcode = FuncDefI(Token, newSub);
                if (retcode >= 0)
                    SubTreeRoot->son.push_back(newSub);
            }
            else
            {
                while (1)
                {
                    GrammaNode * newSon = new GrammaNode();
                    *newSon = *newSub;
                    retcode = VarDef(Token, newSon);
                    if (retcode >= 0)
                        SubTreeRoot->son.push_back(newSub);
                    if (Token->type == COMM)
                    {
                        Token->get_token();
                        newSub->son.clear();
                        if (Token->type == Ident)
                        {
                            newSub->son.push_back(new GrammaNode(Ident, Token->val.val_str));
                            Token->get_token();
                        }
                        else
                        {
                            ErrorCatch("error");
                            retcode = -1;
                        }
                    }
                    else if (Token->type == SEMI)
                    {
                        Token->get_token();
                        break;
                    }
                }
                delete newSub;
            }
        }
        else
        {
            ErrorCatch("error");
            return -1;
        }
    }
    return retcode;
}
int FuncDefV(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode;
    SubTreeRoot->type = FDV;
    if (Token->type == Ident)
    {
        SubTreeRoot->son.push_back(new GrammaNode(Ident, Token->val.val_str));
        Token->get_token();
        if (Token->type == RDBRAL)
        {
            Token->get_token();
            if (Token->type != RDBRAR)
            {
                GrammaNode * newSon = new GrammaNode();
                retcode = FuncFParams(Token, newSon);
                if (retcode >= 0)
                {
                    SubTreeRoot->son.push_back(newSon);
                }
                if (Token->type != RDBRAR)
                {
                    ErrorCatch("Error\n");
                    return -1;
                }
            }
            Token->get_token();
            GrammaNode * newSon = new GrammaNode();
            retcode = Block(Token, newSon);
            if (retcode >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
        else
        {
            ErrorCatch("error");
            return -1;
        }
    }
    else
    {
        ErrorCatch("error");
        return -1;
    }
    return retcode;
}
int FuncDefI(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode;
    SubTreeRoot->type = FDI;
    if (Token->type != RDBRAR)
    {
        GrammaNode * newSon = new GrammaNode();
        retcode = FuncFParams(Token, newSon);
        if (retcode >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    Token->get_token();
    GrammaNode* newSon = new GrammaNode();
    retcode = Block(Token, newSon);
    if (retcode >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int ConstDef(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode;
    SubTreeRoot->type = CD;
    if (Token->type == Ident)
    {
        for (Token->get_token(); Token->type != ASSIGN; Token->get_token())
        {
            if (Token->type == SQBRAL)
            {
                Token->get_token();
                GrammaNode * newSon = new GrammaNode();
                if ((retcode = AddExp(Token, newSon)) >= 0)
                {
                    SubTreeRoot->son.push_back(newSon);
                }
                if (Token->type != SQBRAR)
                {
                    ErrorCatch("Excepted ]");
                    return -1;
                }
            }
            else
            {
                ErrorCatch("Excepted [");
                return -1;
            }
        }
        Token->get_token();
        GrammaNode *newSon = new GrammaNode();
        retcode = InitVal(Token, newSon);
        if (retcode >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    else
    {
        ErrorCatch("error");
        return -1;
    }
    return retcode;
}
int VarDef(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode = 0;
    SubTreeRoot->type = VD;
    for (; Token->type != SEMI && Token->type != COMM && Token->type != ASSIGN; Token->get_token())
    {
        if (Token->type == SQBRAL)
        {
            Token->get_token();
            GrammaNode *newSon = new GrammaNode();
            if ((retcode = AddExp(Token, newSon)) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type != SQBRAR)
            {
                ErrorCatch("error");
                return -1;
            }
        }
    }
    if (Token->type == ASSIGN)
    {
        Token->get_token();
        GrammaNode *newSon = new GrammaNode();
        if ((retcode = InitVal(Token, newSon)) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
        if (Token->type != SEMI && Token->type != COMM)
        {
            ErrorCatch("error");
            return -1;
        }
    }
    return retcode;
}
int InitVal(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode = 0;
    SubTreeRoot->type = IV;
    if (Token->type == BRAL) //说明是一堆AddExp
    {
        for (Token->get_token(); Token->type != BRAR; Token->get_token())
        {
            if (Token->type == COMM)
                continue;
            GrammaNode *newSon = new GrammaNode();
            if ((retcode = InitVal(Token, newSon)) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
    }
    else
    {
        GrammaNode *newSon = new GrammaNode();
        if ((retcode = AddExp(Token, newSon)) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    return retcode;
}
int FuncFParams(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode = 0;
    SubTreeRoot->type = FFPs;
    GrammaNode *newSon = new GrammaNode();
    if ((retcode = FuncFParam(Token, newSon)) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    for (Token->get_token(); Token->type == RDBRAR;)
    {
        if (Token->type == COMM)
        {
            Token->get_token();
            continue;
        }
        newSon = new GrammaNode();
        if ((retcode = FuncFParam(Token, newSon)) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    return retcode;
}
int FuncFParam(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode = 0;
    SubTreeRoot->type = FFP;
    if (Token->type == INT)
    {
        Token->get_token();
        if (Token->type == Ident)
        {
            SubTreeRoot->son.push_back(new GrammaNode(Ident, Token->val.val_str));
            Token->get_token();
            if (Token->type == SQBRAL)
            {
                Token->get_token();
                if (Token->type == SQBRAR)
                {
                    for (Token->get_token(); Token->type != RDBRAR && Token->type != COMM; Token->get_token())
                    {
                        if (Token->type == SQBRAL)
                        {
                            Token->get_token();
                            GrammaNode *newSon = new GrammaNode();
                            if (retcode = AddExp(Token, newSon) >= 0)
                            {
                                SubTreeRoot->son.push_back(newSon);
                            }
                            Token->get_token();
                            if (Token->type != SQBRAR)
                            {
                                ErrorCatch("ERROR");
                                return -1;
                            }
                        }
                        else
                        {
                            ErrorCatch("error");
                            return -1;
                        }
                    }
                }
                else
                {
                    ErrorCatch("error");
                    return -1;
                }
            }
        }
        else
        {
            ErrorCatch("error");
            return -1;
        }
    }
    else
    {
        ErrorCatch("error");
        return -1;
    }
    return retcode;
}
int Block(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    int retcode = 0;
    SubTreeRoot->type = B;
    if (Token->type == BRAL)
    {
        for (Token->get_token(); Token->type != BRAR; Token->get_token())
        {
            GrammaNode *newSon = new GrammaNode();
            if (retcode = BlockItem(Token, newSon) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
    }
    return retcode;
}
int BlockItem(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = BI;
    if (Token->type == INT)
    {
        for (Token->get_token(); Token->type != SEMI;)
        {
            if (Token->type == COMM)
            {
                Token->get_token();
                continue;
            }
            if (Token->type == Ident)
            {
                newSon = new GrammaNode();
                newSon->son.push_back(new GrammaNode(Ident, Token->val.val_str));
                if (retcode = VarDef(Token, newSon) >= 0)
                {
                    SubTreeRoot->son.push_back(newSon);
                }
            }
        }
    }
    else if (Token->type == CONST)
    {
        Token->get_token();
        if (Token->type != INT)
        {
            ErrorCatch("error");
            return -1;
        }
        for (Token->get_token(); Token->type != SEMI;)
        {
            if (Token->type == COMM)
            {
                Token->get_token();
                continue;
            }
            newSon = new GrammaNode();
            if (retcode = ConstDef(Token, newSon) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
    }
    else
    {
        newSon = new GrammaNode();
        if (retcode = Stmt(Token, newSon) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    return retcode;
}
int Stmt(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = S;
    if (Token->type == IF)
    {
        SubTreeRoot->son.push_back(new GrammaNode(IF));
        Token->get_token();
        if (Token->type == RDBRAL)
        {
            Token->get_token();
            newSon = new GrammaNode();
            if (retcode = LOrExp(Token, newSon))
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type != RDBRAR)
            {
                ErrorCatch("error");
            }
            Token->get_token();
            newSon = new GrammaNode();
            if (retcode = Stmt(Token, newSon))
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type == ELSE)
            {
                SubTreeRoot->son.push_back(new GrammaNode(ELSE));
                Token->get_token();
                newSon = new GrammaNode();
                if (retcode = Stmt(Token, newSon))
                {
                    SubTreeRoot->son.push_back(newSon);
                }
            }
        }
        else
        {
            ErrorCatch("error");
        }
    }
    else if (Token->type == WHILE)
    {
        SubTreeRoot->son.push_back(new GrammaNode(WHILE));
        Token->get_token();
        if (Token->type == RDBRAL)
        {
            Token->get_token();
            newSon = new GrammaNode();
            if (retcode = LOrExp(Token, newSon))
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type != RDBRAR)
            {
                ErrorCatch("error");
            }
            Token->get_token();
            newSon = new GrammaNode();
            if (retcode = Stmt(Token, newSon))
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
        else
        {
            ErrorCatch("error");
        }
    }
    else if (Token->type == BREAK)
    {
        SubTreeRoot->son.push_back(new GrammaNode(BREAK));
        Token->get_token();
    }
    else if (Token->type == CONTINUE)
    {
        SubTreeRoot->son.push_back(new GrammaNode(CONTINUE));
        Token->get_token();
    }
    else if (Token->type == RETURN)
    {
        SubTreeRoot->son.push_back(new GrammaNode(RETURN));
        Token->get_token();
    }
    else if (Token->type == BRAL)
    {
        newSon = new GrammaNode();
        if (retcode = Block(Token, newSon) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    else if (Token->type == SEMI)
    {
        Token->get_token();
        return 0;
    }
    else
    {
        GrammaNode *newMul = new GrammaNode();
        newSon = new GrammaNode();
        if (retcode = MulExp(Token, newMul) >= 0)
        {
            newSon->son.push_back(newMul);
        }
        if (Token->type == ADD || Token->type == SUB)
        {
            newSon->son.push_back(new GrammaNode(ADD));
            Token->get_token();
            if (retcode = AddExp(Token, newSon) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
        }
        else
        {
            if (retcode = LVal(Token, newSon) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type == ASSIGN)
            {
                SubTreeRoot->son.push_back(new GrammaNode(ASSIGN));
                Token->get_token();
                newSon = new GrammaNode();
                if (retcode = AddExp(Token, newSon) >= 0)
                {
                    SubTreeRoot->son.push_back(newSon);
                }
            }
            else
            {
                ErrorCatch("error");
            }
        }
    }
    if (Token->type != SEMI)
    {
        ErrorCatch("error");
        return -1;
    }
    return retcode;
}
int LVal(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = UE;
    for (; Token->type != ASSIGN; Token->get_token())
    {
        if (Token->type == SQBRAL)
        {
            Token->get_token();
            newSon = new GrammaNode();
            if (retcode = AddExp(Token, newSon) >= 0)
            {
                SubTreeRoot->son.push_back(newSon);
            }
            if (Token->type != SQBRAR)
            {
                ErrorCatch("error");
                return -1;
            }
        }
        else
        {
            ErrorCatch("error");
            return -1;
        }
    }
    return retcode;
}
int UnaryExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = UE;
    switch (Token->type)
    {
    case IntConst:
        SubTreeRoot->son.push_back(new GrammaNode(IntConst, Token->val.num));
        Token->get_token();
        break;
    case Ident:
        Token->get_token();
        if (Token->type == RDBRAL)
        {
            Token->get_token();
            if (Token->type != RDBRAR)
            {
                Token->get_token();
                newSon = new GrammaNode();
                if (retcode = FuncRParams(Token, newSon))
                {
                    SubTreeRoot->son.push_back(newSon);
                }
            }
            Token->get_token();
        }
        else
        {
            ErrorCatch("Excepted (");
            retcode = -1;
        }
        break;
    case ADD:
        Token->get_token();
        newSon = new GrammaNode();
        if (retcode = UnaryExp(Token, newSon))
        {
            SubTreeRoot->son.push_back(newSon);
        }
        break;
    case SUB:
        Token->get_token();
        newSon = new GrammaNode();
        if (retcode = UnaryExp(Token, newSon))
        {
            SubTreeRoot->son.push_back(newSon);
        }
        break;
    case NOT:
        Token->get_token();
        newSon = new GrammaNode();
        if (retcode = UnaryExp(Token, newSon))
        {
            SubTreeRoot->son.push_back(newSon);
        }
        break;
    default:
        ErrorCatch("error");
        retcode = -1;
        break;
    }
    return retcode;
}
int FuncRParams(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = FRPs;
    newSon = new GrammaNode();
    if (retcode = AddExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    for (; Token->type == COMM;)
    {
        Token->get_token();
        newSon = new GrammaNode();
        if (retcode = AddExp(Token, newSon) >= 0)
        {
            SubTreeRoot->son.push_back(newSon);
        }
    }
    return retcode;
}
int MulExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = ME;
    newSon = new GrammaNode();
    if (retcode = UnaryExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type < DIV || Token->type > MOD)
    {
        ErrorCatch("Excepted * / %.....but get"+Token->val.val_str);
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = MulExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int AddExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = AE;
    newSon = new GrammaNode();
    if (retcode = MulExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type != ADD && Token->type != SUB)
    {
        ErrorCatch("Excepted +/-");
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = AddExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int RelExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = RE;
    newSon = new GrammaNode();
    if (retcode = AddExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type < LT || Token->type > BQ)
    {
        ErrorCatch("error");
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = RelExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int EqExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = EE;
    newSon = new GrammaNode();
    if (retcode = RelExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type != EQ && Token->type != NEQ)
    {
        ErrorCatch("error");
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = EqExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int LAndExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = LAE;
    newSon = new GrammaNode();
    if (retcode = EqExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type != AND)
    {
        ErrorCatch("error");
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = LAndExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
int LOrExp(TokenRec *Token, GrammaNode *SubTreeRoot)
{
    GrammaNode* newSon;
    int retcode = 0;
    SubTreeRoot->type = LOE;
    newSon = new GrammaNode();
    if (retcode = EqExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
        return retcode;
    }
    if (Token->type != OR)
    {
        ErrorCatch("error");
        return -1;
    }
    SubTreeRoot->son.push_back(new GrammaNode(Token->type));
    Token->get_token();
    newSon = new GrammaNode();
    if (retcode = LOrExp(Token, newSon) >= 0)
    {
        SubTreeRoot->son.push_back(newSon);
    }
    return retcode;
}
void ErrorCatch(string s)
{
    errorcnt++;
    printf("Passer: Error No.%d ----", errorcnt);
    cout << errorcnt << "\n";
    cout<<s<<'\n';
}

int parser_main(TokenRec *Token, GrammaNode *TreeRoot)
{
    int retcode;
    TreeRoot->type = RT;
    Token->get_token();
    while (Token->type != ENDF)
    {
        GrammaNode *newSon = new GrammaNode();
        retcode = CompUnitNode(Token, newSon);
        if (retcode >= 0)
        {
            TreeRoot->son.push_back(newSon);
        }
    }
    return retcode;
}
void show_tree(GrammaNode * TreeRoot, int tabcnt)
{
    printf("type: ");
    cout<<typetablep[TreeRoot->type]<<endl;
    for(int i=0;i<TreeRoot->son.size();i++)
    {
        for(int i=1;i<=tabcnt;i++)printf("  ");
        printf("%d->",i);
        show_tree(TreeRoot->son[i],tabcnt+3);
    }
}