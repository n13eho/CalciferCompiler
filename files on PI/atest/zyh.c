#include <stdio.h>

int a=1;
int arr[10]={1,2,3,4,5,6,7,8,9,10};
int func(int b, int c,int d,int e,int f,int g){
  a=a+1;
  return b+c+d+e+f+g;
}
int func2(int b, int c){
  arr[5]=arr[5]+1;
  return b+c;
}
int main(){
    int e=func(0,0,0,0,a,func(0,1,0,0,0,0)); // 8+1=9 10
    printf("%d\n",e);
}

