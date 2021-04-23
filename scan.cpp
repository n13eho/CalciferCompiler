#include"global.h"
#include"scan.h"

// static FILE* targetFile;
static int currChar = ' ';


//保留字的val
std::string reW_int      = "int";
std::string reW_void     = "void";
std::string reW_if       = "if";
std::string reW_else     = "else";
std::string reW_while    = "while";
std::string reW_break    = "break";
std::string reW_continue = "continue";
std::string reW_return   = "return";

//非运算符号sign char
char signC_semi   = ';';
char signC_comm   = ',';
char signC_rdbarl = '(';
char signC_rdbarr = ')';
char signC_sqbarl = '[';
char signC_sqbarr = ']';
char signC_barl   = '{';
char signC_brar   = '}';
char signC_assign = '='; // 

//运算符，单和双op Char
char opC_add        = '+';
char opC_sub        = '-';
char opC_div        = '/'; // 
char opC_mul        = '*';
char opC_mod        = '%';
std::string opC_eq  = "=="; // 
std::string opC_neq = "!=";//
std::string opC_or  = "||";//?
std::string opC_and = "&&";//?
char opC_not        = '!';//
char opC_lt         = '<';//
std::string opC_lq  = "<=";//
char opC_bg         = '>';//
std::string opC_bq  = ">=";//

void TokenRec::show_token()
{
    std::cout << "<" << type << ", ";
    if(type == IntConst)
    {
        std::cout << val.num << ">" << '\n';
    }
    else
        std::cout << val.val_str << ">" << '\n';
}


void TokenRec::get_token()
{

    // 忽略空格
    while(isspace(currChar))
        currChar = fgetc(targetFile);
        
    // 匹配标识符Ident 和 可能出现的保留字
    if(isalpha(currChar))
    {
        val.val_str = currChar;
        while (isalnum(currChar = fgetc(targetFile)))
        {// true if currChar [0-9a-zA-Z]
            val.val_str += currChar;
        }

        if(val.val_str == reW_int){type = INT; return;}// 这样写，很没有章法
        if(val.val_str == reW_void){type = VOID; return;}// 这样写，很没有章法
        if(val.val_str == reW_if){type = IF; return;}// 这样写，很没有章法
        if(val.val_str == reW_else){type = ELSE; return;}// 这样写，很没有章法
        if(val.val_str == reW_while){type = WHILE; return;}// 这样写，很没有章法
        if(val.val_str == reW_break){type = BREAK; return;}// 这样写，很没有章法
        if(val.val_str == reW_continue){type = CONTINUE; return;}// 这样写，很没有章法
        if(val.val_str == reW_return){type = RETURN; return;}// 这样写，很没有章法
        //否则就不是保留字，是一个普通的Ident
        type = Ident;
        return;        
    }

    // 匹配数字
    if(isdigit(currChar))
    {
        std::string numStr;
        while(isdigit(currChar))
        {
            numStr += currChar;
            currChar = fgetc(targetFile);
        }
        val.num = strtod(numStr.c_str(), 0);
        type = IntConst;
        return;
    }

    // 先匹配单个非运算符号的
    // std::cout << val.num << '\n';
    val.val_str = currChar;///////////////////???????????????
    int tempchar = currChar;
    currChar = fgetc(targetFile); //提前读一个
    if(tempchar == signC_semi){type = SEMI; return;}
    else if(tempchar == signC_comm){type = COMM; return;}
    else if(tempchar == signC_rdbarl){type = RDBRAL; return;}
    else if(tempchar == signC_rdbarr){type = RDBRAR; return;}
    else if(tempchar == signC_sqbarl){type = SQBRAL; return;}
    else if(tempchar == signC_sqbarr){type = SQBRAR; return;}
    else if(tempchar == signC_barl){type = BRAL; return;}
    else if(tempchar == signC_brar){type = BRAR; return;}
    //然后匹配运算符,单
    else if(tempchar == opC_add){type = ADD; return;}
    else if(tempchar == opC_sub){type = SUB; return;}
    else if(tempchar == opC_mul){type = MUL; return;}
    else if(tempchar == opC_mod){type = MOD; return;}
    //双
    else if(tempchar == '|' && currChar == '|')
    {
        val.val_str += currChar;
        currChar = fgetc(targetFile);//读掉
        type = OR;
        return;
    }
    else if(tempchar == '&' && currChar == '&')
    {
        val.val_str += currChar;
        currChar = fgetc(targetFile);
        type = AND;
        return;
    }
    // ! 和 !=
    else if(tempchar == '!')
    {
        if(currChar == '=')
        {//是!= 不等于
            val.val_str += currChar;
            currChar = fgetc(targetFile);
            type = NEQ;
            return;
        }
        //否则就是 ！ 是not
        else{type = NOT; return;}
    }
    // = 和 ==
    else if(tempchar == '=')
    {
        if(currChar == '=')
        {// == 
            val.val_str += currChar;
            currChar = fgetc(targetFile);
            type = EQ;
        }
        //否则就是 = assign
        else{type = ASSIGN; return;}
    }
    // > 和 >=
    else if(tempchar == '>')
    {
        if(currChar == '=')
        {
            val.val_str += currChar;
            currChar = fgetc(targetFile);
            type = BQ;
        }
        else{type = BG; return;}
    }
    //< 和 <=
    else if(tempchar == '<')
    {
        if(currChar == '=')
        {
            val.val_str += currChar;
            currChar = fgetc(targetFile);
            type = LQ;
        }
        else{type = LT; return;}
    }
    // / 和 // 和 /*
    else if(tempchar == '/')
    {
        if(currChar != '/' || currChar != '*')
        {// 不是注释，只是除号
            type = DIV;
            return;
        }
        else if(currChar == '/')
        {//如果注释是//，以序列 ‘//’ 开始，直到换行符结束，不包括换行符
            type = COMM;
            while (currChar != EOF || currChar != '\n' || currChar != '\r')
            {// '\r' 会有可能吗
                val.val_str += currChar;
                currChar = fgetc(targetFile);
            }
            return;
        }
        else if(currChar == '*')
        {//多行注释：以序列 ‘/*’ 开始，直到第一次出现 ‘*/’ 时结束，包括结束处‘*/’。
            type = COMM;
            int commtemp;
            while (currChar != EOF)
            {
                val.val_str += currChar;
                commtemp = currChar;
                currChar = fgetc(targetFile);
                if(commtemp == '*' && currChar == '/')
                {
                    val.val_str += currChar;
                    currChar = fgetc(targetFile);
                    return;
                }

            }
            //注意这里还应该再处理一下/* 和 */不匹配的出错的情况...在语法分析里面做吗
        }
    }
    //最后是EOF文件末尾的处理
    else if(tempchar == EOF)
    {
        type = ENDF;
        return;
    }
    return;
}