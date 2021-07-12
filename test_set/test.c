// const int a[4][1+1] ={0, {2, 3}, {4, 5}, 6}; // 应该报错
// const int b[4][2] ={0, 2, 3, {4, 5}, 6}; // 应该摆错
// const int c[2][2] = {{0},{2}}; // 0 0 2 0
// const int d[4][2] ={0, 2, 3, {4}, 5, 6}; // 0 2 3 4 5 6 0 0
 const int e[4][2] ={{0}, 2, 3, {4}, 5, {6}}; // 0 0 2 3 4 0 5 6
// const int today = 9/8+7, to = 12 + 3;
// const int mondy = today + 1 + c[2]; // 11, but should be wrong


const int p = 17;
int rtyu;

int func(int c,int b)
{
    int w = b+c;
//    if(c > b)w = b + c;
//    else if(c == b) w = b;
//    else w = b - c;
    return w;
}

int main()
{
//     int a=c[1][1], b=0, c;
    int a=10, b=0, c;
    const int ppp=5;
//     c = getint();
    while (1)
    {
        a = a + 1;
        b = b + 2;
        c = func(a, b);
        if(b > a)break;
    }
    return c;
}