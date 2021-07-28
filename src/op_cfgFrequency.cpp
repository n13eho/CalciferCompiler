#include"RIG.h"
#include"op_cfgFrequency.h"
const double eps = 1e-9;
map<BasicBlock*, double> blockFrequency;


/*
    * 1.1 计算frequency of each block map_frequen<basicBlock* b, double frequency>
    * 1.2 在建立IN/OUT集合的时候就记录每个decl出现在gen集合中的次数，并记录，用dc->gen_used
    * 1.3 map_frequen[dc->rawBlock] * dc->gen_used.size() 得到最终的cost， 存入dc->spill_cost
    * 1.4 通过RIG图 遍历所有decl 找出cost最小的.
*/

//temperate varible
map<BasicBlock*, int> block2id;//block对应的变量编号
int Fcnt=1;
vector<vector<double>>  coefficientM;//计算期望的系数矩阵
map<pair<BasicBlock*,BasicBlock*>,double> edgeF;//A->B的转移概率
vector<BasicBlock*> exitB;//函数的出口

//hyper paramter
//TODO:算不出来while的转移概率, 先给whileTrue0.75.
double hyperWT=0.75;

void addEdgeF(BasicBlock* a,BasicBlock* b, double F){
    edgeF[make_pair(a,b)]=F;
}

void dfsF(BasicBlock* b)
{
    block2id[b]=Fcnt++;
    if(b->succBlock.size()==0){
        //没有后继
        exitB.push_back(b);
        return ;
    }
    else if(b->succBlock.size()==1){
        //如果后继为1, 转移概率就是1;
        BasicBlock* nx= b->succBlock[0];
        addEdgeF(b,nx,1);
    }
    else{
        //多个后继(must be 2), 需要估计每条边的转移概率
        
        if(b->BlockName=="while"){//while
            for(auto insid: b->InstrList){
                auto ins = IR1->InstList[insid];
                if(ins->getOpType() >= Instruction::ArithEq && ins->getOpType()<=Instruction::ArithGQ){
                    IntegerValue* r0 = (IntegerValue*)ins->getOp()[0];
                    IntegerValue* r1 = (IntegerValue*)ins->getOp()[1];
                    if(r0->isConst&&r1->isConst){
                        //要么死循环, 要么多余
                        int x= r0->RealValue, y=r1->RealValue;
                        bool fl=0;
                        if(ins->getOpType() == Instruction::ArithEq)if(x==y)fl=1;
                        if(ins->getOpType() == Instruction::ArithNeq)if(x!=y)fl=1;
                        if(ins->getOpType() == Instruction::ArithLT)if(x<y)fl=1;
                        if(ins->getOpType() == Instruction::ArithBG)if(x>y)fl=1;
                        if(ins->getOpType() == Instruction::ArithLQ)if(x<=y)fl=1;
                        if(ins->getOpType() == Instruction::ArithGQ)if(x>=y)fl=1;
                        addEdgeF(b,b->succBlock[0],(double)fl);//第一个一定是whileTrue
                        addEdgeF(b,b->succBlock[1],(double)(!fl));
                    }
                    else{
                        // TODO: estimate more exactly frequency.
                        addEdgeF(b,b->succBlock[0],hyperWT);
                        addEdgeF(b,b->succBlock[1],1-hyperWT);
                    }
                    break;
                }
            }
        }
        else{//if
            // 现在, 我们的做法是:
            // 如果都是常数, 就1:0或者0:1; 否则就1:1;
            for(auto insid: b->InstrList){
                auto ins = IR1->InstList[insid];
                if(ins->getOpType() >= Instruction::ArithEq && ins->getOpType()<=Instruction::ArithGQ){
                    IntegerValue* r0 = (IntegerValue*)ins->getOp()[0];
                    IntegerValue* r1 = (IntegerValue*)ins->getOp()[1];
                    if(r0->isConst&&r1->isConst){
                        //这个可以算出来
                        int x= r0->RealValue, y=r1->RealValue;
                        bool fl=0;
                        if(ins->getOpType() == Instruction::ArithEq)if(x==y)fl=1;
                        if(ins->getOpType() == Instruction::ArithNeq)if(x!=y)fl=1;
                        if(ins->getOpType() == Instruction::ArithLT)if(x<y)fl=1;
                        if(ins->getOpType() == Instruction::ArithBG)if(x>y)fl=1;
                        if(ins->getOpType() == Instruction::ArithLQ)if(x<=y)fl=1;
                        if(ins->getOpType() == Instruction::ArithGQ)if(x>=y)fl=1;
                        addEdgeF(b,b->succBlock[0],(double)fl);//第一个一定是ifTrue
                        addEdgeF(b,b->succBlock[1],(double)(!fl));//第一个一定是ifTrue
                    }
                    else{
                        // 算不出来就先0.5;
                        // TODO: estimate more exactly frequency. 
                        addEdgeF(b,b->succBlock[0],0.5);
                        addEdgeF(b,b->succBlock[1],0.5);
                    }
                    break;
                }
            }
        }
    }
    for(auto nx: b->succBlock){
        if(block2id[nx]==0)dfsF(nx);
    }
}

vector<double> x;
int Gauss(int equ, int var, vector<vector<double>> a)
{
    int i,j,k,col,max_r;
    for(k=0,col=0;k<equ&&col<var;k++,col++)
    {
        max_r=k;
        for(i=k+1;i<equ;i++)
            if(fabs(a[i][col])>fabs(a[max_r][col])) max_r=i;

        if(fabs(a[max_r][col])<eps)
		{
			// 有一列为空.
			continue;
		}
        if(k!=max_r)
        {
            for(j=col;j<var;j++)swap(a[k][j],a[max_r][j]);
            swap(x[k],x[max_r]);
        }
        x[k]/=a[k][col];
        for(j=col+1;j<var;j++)a[k][j]/=a[k][col];
        a[k][col]=1;
        for(i=0;i<equ;i++)
            if(i!=k)
            {
                x[i]-=x[k]*a[i][col];
                for(j=col+1;j<var;j++)a[i][j]-=a[k][j]*a[i][col];
                a[i][col]=0;   
            }
    }
    return 1;
}

void getFrequency()
{
    // 调用接口
    // 1. 估算每一条边的转移概率, 以及对block编号
    for(auto gb: IR1->Blocks){
        if(gb->domBlock.size() == 0)continue; // 全局变量跳过

        // init
        x.clear();
        Fcnt=1;
        coefficientM.clear();
        edgeF.clear();
        exitB.clear();

        dfsF(gb->domBlock[0]);
        //为了计算Frequency, 函数的出口要向入口连一条边..
        for(auto i :exitB){
            addEdgeF(i,gb->domBlock[0],1.0);
        }

        // 2. 根据转移概率列方程
        for(int i=0;i<gb->domBlock.size();i++){
            vector<double> tem;
            for(int j=0;j<gb->domBlock.size();j++)tem.push_back(0.0);
            tem[i]+=1.0;
            coefficientM.push_back(tem);
        }
        for(auto edge:edgeF){
            int v = block2id[edge.first.first];//start
            int u = block2id[edge.first.second];//end
            coefficientM[u-1][v-1]-=edge.second;
//            dbg(v, u, edge.second);
        }
        vector<double> tem;
        for(int i=0;i<gb->domBlock.size();i++)tem.push_back(0.0);
        tem[0]=1;coefficientM.push_back(tem);
        for(int i=0;i<coefficientM.size();i++)x.push_back(0.0);
        x[coefficientM.size() - 1]=1;

//        for(auto i: coefficientM)
//        {
//            for(auto j: i)
//            {
//                cout << j <<"\t";
//            }
//            cout << "\n";
//        }
//        for(auto i: x)
//        {
//            cout << i <<"\t";
//        }
//        cout << endl;

        // 3. 解方程
        if(Gauss(coefficientM.size(),gb->domBlock.size(),coefficientM)){
            // 4. 给blockFrequency 赋值
            for(auto b:gb->domBlock){
                int id = block2id[b];
                blockFrequency[b]=x[id-1];
            }
        }
        else{
            dbg("板子永远不会错！");
        }
    }

    // for debug 打印fre
    for(auto p: blockFrequency)
    {
        dbg(p.first->BlockName, p.second);
        dbg(" ");
    }


}