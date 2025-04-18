#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("add4.c\n\n");
    
    int a = -2147483648;
    int b = -1;
    
    long long int iloczyn = (long long int)a+b;
    
    printf("a = %d\n", a);
    printf("b = %d\n\n", b);
    
    printf("iloczyn = %lld\n", iloczyn);

    return 0;
}