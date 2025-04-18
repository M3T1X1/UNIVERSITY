#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("idiv2.c\n\n");

    long long a = -2147483650;
    int b = -3;

    long long iloraz = a / b;
    long long reszta = a % b;

    printf("a = %lld\n", a);
    printf("b = %d\n\n", b);
    
    printf("\niloraz = %lld\n", iloraz);
    printf("reszta = %lld\n", reszta);


    return 0;
}