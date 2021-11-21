#include <iostream>

using namespace std;

int a=1;
int arr[10]={1,2,3,4,5,6,7,8,9,10};
int func(int b, int c){
  a=a+1;
  return b+c;
}
int func2(int b, int c){
  arr[5]=arr[5]+1;
  return b+c;
}
int main(){
    int e=func(a, func(0,1)); // 8+1=9 10
    cout<<e<<endl;
}

