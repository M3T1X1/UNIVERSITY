#include <stdio.h>
#include <stdlib.h>
#include <math.h>
 
int polinomial(unsigned char *p, int n){
    unsigned int sum = 0;
    for (int i = 0; i < n; i++) {
        sum = sum + *(p+i) * pow(256, i);
    }

    return sum;
}

int hornerPolinomial(unsigned char *pointer, int w){
    unsigned int outcome = 0;
 
    for (int i = w - 1; i >= 0; i--) {
        outcome = outcome * 256 + pointer[i];
    }
    return outcome;
}
 
int main() {
    printf("number.c\n\n");
    
    char x[] = {1, 2, 3, 4};
    int n = sizeof(x) / sizeof(x[0]);
    
    printf("number(%p, %u) = %u\n", x, n, polinomial(x, n));
    printf("Using horner scheme: number(%p, %u) = %u \n", x, n , hornerPolinomial(x, n));
    
    return 0;
}