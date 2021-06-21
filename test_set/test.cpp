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
	//const int a[4][2] = {{1}, {2, 3}, 4, 5, 6};
	// const int a[4][3] = {1, 2, {3, 4}, 5, 6};
	// for(int i=0; i<4; i++)
	// {
	// 	for(int j = 0; j<3; j++)
	// 	{
	// 		cout<<a[i][j]<<" ";
	// 	}
	// 	cout<<endl;
	
	// }
	// 	cout<<endl;
	int k=stoi("0xc",0,16);
	cout<<k<<endl;
	ab* testa= new ab();
	a* testb =testa;
	ac* testc = (ac*)testb;
	if(typeid(*testc)==typeid(ac))
	{
		printf("win!\n");
	}
   return 0;
}