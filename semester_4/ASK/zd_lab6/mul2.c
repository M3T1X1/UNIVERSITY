#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("mul2.c\n\n");
    
    unsigned int a = 4294967295;
    unsigned int b = 2;
    
    long long int iloczyn = (long long int)a*b;
    
    printf("a = %u\n", a);
    printf("b = %u\n\n", b);
    
    printf("iloczyn = %llu\n", iloczyn);

    return 0;
}