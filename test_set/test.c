// const int a[4][1+1] ={0, {2, 3}, {4, 5}, 6}; // 应该报错
// const int b[4][2] ={0, 2, 3, {4, 5}, 6}; // 应该摆错
//  const int c[2][2] = {{0},{2}}; // 0 0 2 0
//  const int d[4][2] ={0, 2, 3, {4}, 5, 6}; // 0 2 3 4 5 6 0 0
//  const int e[4][2] ={{0}, 2, 3, {4}, 5, {6}}; // 0 0 2 3 4 0 5 6
//  const int today = 9/8+7, to = 12 + 3;
// const int mondy = today + 1 + c[2]; // 11, but should be wrong


int func(int c,int b)
{
    int w = b+c;
    return w;
}
int data;
int main()
 {
     int a=10, b=0, c;
     while (1)
     {
         a = a + 1;
         b = b + 2;
         c = func(a, b);
         if(b > a && c > a + b)break;
     }
}
