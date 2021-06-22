#include <iostream>
#include<string>
using namespace std;
class a
{
	int k;
};
class ab:public a{};
class ac:public a{};

int main()
{
	const int shuzu[3][4][2]={{0,1},1,2,3,4};
	for(int i=0;i<3;i++)
	{
		cout<<"{";
		for(int j=0;j<4;j++)
		{
			printf("{");
			for(int k=0;k<2;k++)
			{
				printf("%d ",shuzu[i][j][k]);
			}
			cout<<"}\n";
		}
		cout<<"}\n";
	}
}