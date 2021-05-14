#include<bits/stdc++.h>
using namespace std;
struct node
{
    vector<int> test;
};
int main()
{
    node* waiceng = new node();
    waiceng->test.clear();
    waiceng->test.push_back(2);
    for(auto i: waiceng->test)cout<<i<<endl;
    if(1)
    {
        node * neiceng = new node();
        *neiceng = *waiceng;
        neiceng->test.push_back(3);
        for(auto i: waiceng->test)cout<<i<<endl;
        for(auto i: neiceng->test)cout<<i<<endl;
    }
    for(auto i: waiceng->test)cout<<i<<endl;
    return 0;
}