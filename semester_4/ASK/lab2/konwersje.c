#include <stdio.h>
#include <stdlib.h>

/*
- jaką maksymalną liczbę binarną można zapisać na liczbie dziesiętnej typu int?


UINT_MAX = 4294967295
UBIN_MAX = 1111111111

-- jaka jest wartość dziesiętna maksymalnej liczby binarnej zapisanej na liczbie dziesiętnej typu int?

           9876543210 
UBIN_MAX = 1111111111 + 1 - 1 = 2^10 - 1 = 1024 - 1 = 1023
*/

/*
- dziesiętne 11 na liczbę binarną

11 / 2 = 5   r0 = 1
5 / 2 = 2    r1 = 1
2 / 2 = 0    r2 = 0
1 / 2 = 0    r3 = 1

     
11 = 1011 = 1*10^0 + 1*10^1 + 0*10^2 + 1*10^3
*/

int dec2bin(int x) {   // na liczbie dziesiętnej
    int sum = 0;
    int pow = 1;
    
    while (x > 0) {
        sum = sum + x%2 * pow;
        
        x = x / 2;
        
        pow = pow * 10;
    }
    
    return sum;
}    


int main() {
    printf("konwersje.c\n\n");

    int dec1 = 1023;  // dec1 = 0 .. 1023
    
    printf("dec2bin(%d) = %d\n\n", dec1, dec2bin(dec1));
    
    return 0;
}