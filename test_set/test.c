// int sub()
// {
//     const int a = 9, b = 8;
//     return a - b;
// }

// int sub2()
// {
//     const int a = 9, b = 8;
//     return a-b;
// }

// void whh(int a)
// {
//     return 0;
// }

// int add(int a, int b[])
// {
//     int c;
//     return a + b[0];
//     int d;
// }

const int a[4][1+1] ={0, {2, 3}, {4, 5}, 6}; // 应该报错
const int b[4][2] ={0, 2, 3, {4, 5}, 6}; // 应该摆错
const int c[2][2] = {{0},{2}}; // 0 0 2 0
const int d[4][2] ={0, 2, 3, {4}, 5, 6}; // 0 2 3 4 5 6 0 0
const int e[4][2] ={{0}, 2, 3, {4}, 5, {6}}; // 0 0 2 3 4 0 5 6
const int today = 9/8+7, to = 12 + 3, mondy = 19 % 3;
