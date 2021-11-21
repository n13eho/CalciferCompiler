#include<bits/stdc++.h>
using namespace std;

int main(){
    srand(time(0));
    freopen("in.in","w",stdout);
    int c = rand()%3+1;
    int n = rand()%10+4;
    int m = rand()%10+4;
    int k = n*m;
    cout<<c<<' '<<n<<' '<<m<<endl;
    cout<<k<<' ';
    for(int i=1;i<=k;i++)cout<<rand()%10<<' ';
    cout<<endl;
    int t = c*c;
    cout<<t<<" ";
    for(int i=1;i<=t;i++)cout<<rand()%10<<' ';
    fclose(stdout);
}