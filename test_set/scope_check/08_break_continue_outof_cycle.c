int main () {
    int a = 0;
    int i = 0;
    while(1)
    {
        a++;
        printf("%d\n", a);
        if (i > 4)
            break;
        i++;
    }
    if (a < 4)
        continue;
    else
        break;
    return 0;
}