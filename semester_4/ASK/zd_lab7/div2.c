#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("div2.c\n\n");

	unsigned long long a = 4294967296;
    unsigned int b = 3;

    unsigned long long iloraz = a / b;
    unsigned long long reszta = a % b;

    printf("a = %llu\n", a);
    printf("b = %u\n\n", b);
    printf("iloraz = %llu\n", iloraz);
    printf("reszta = %llu\n", reszta);

    return 0;
}