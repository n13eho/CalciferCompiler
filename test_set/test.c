int defn(){
    return 4;
}

int add(int a)
{
    return a;
}

int main(){
    int b = 4;
    int a=defn();
    b = b + a;
    return b;
}