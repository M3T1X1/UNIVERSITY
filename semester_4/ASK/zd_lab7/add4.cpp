#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("add4.c\n\n");
    
    unsigned int a = 4294967295;
    unsigned int b = 1;
    
    unsigned long long iloczyn = (unsigned long long)a+b;
    
    printf("a = %u\n", a);
    printf("b = %u\n\n", b);
    
    printf("iloczyn = %llu\n", iloczyn);

    return 0;
}