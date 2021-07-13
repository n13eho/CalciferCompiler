// const int a[4][1+1] ={0, {2, 3}, {4, 5}, 6}; // 应该报错
// const int b[4][2] ={0, 2, 3, {4, 5}, 6}; // 应该摆错
// const int c[2][2] = {{0},{2}}; // 0 0 2 0
// const int d[4][2] ={0, 2, 3, {4}, 5, 6}; // 0 2 3 4 5 6 0 0
// const int e[4][2] ={{0}, 2, 3, {4}, 5, {6}}; // 0 0 2 3 4 0 5 6
// const int today = 9/8+7, to = 12 + 3;
// const int mondy = today + 1 + c[2]; // 11, but should be wrong


//const int p = 17;
// int g = 1;
//const int p[3][2] = {5, {}, {2, 3}};
// //const int p = 17;
// int rtyu;
// int a=10;
// int main()
// {
//     rtyu = 100 + a;
// }

int rtyu = 1;
int a=1;
int main()
{
    rtyu = a + a;
    rtyu = 100 + a;
}