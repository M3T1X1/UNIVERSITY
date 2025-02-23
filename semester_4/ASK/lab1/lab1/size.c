#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("size.c\n\n");
    
    printf("sizeof(char) = %u\n", sizeof(char)); 
    printf("sizeof(short) = %u\n", sizeof(short)); 
    printf("sizeof(int) = %u\n", sizeof(int)); 
    printf("sizeof(long) = %u\n", sizeof(long)); 
    printf("sizeof(long int) = %u\n", sizeof(long int)); 
    printf("sizeof(long long) = %u\n", sizeof(long long)); 
    
    
    printf("\n"); 

    printf("sizeof(float) = %u\n", sizeof(float)); 
    printf("sizeof(double) = %u\n", sizeof(double)); 
    printf("sizeof(long double) = %u\n", sizeof(long double)); 

    return 0;
}