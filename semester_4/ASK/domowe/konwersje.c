#include <stdio.h>
#include <stdlib.h>

/*
- jaką maksymalną liczbę binarną można zapisać na liczbie dziesiętnej typu int?

UINT_MAX = 4294967295
UBIN_MAX = 1111111111

1111 1111 1111 1111 1111 1111 1111 1111 = 32bity 

- jaką maksymalną liczbę binarną można zapisać na liczbie ósemkowej typu int? *

UOCT_MAX = 37777777777 (oct 37777777777 == dec 4294967295)
UBIN_MAX = 11111111

011 111 111 111 111 111 111 111 111 111 111 = 32 bity 
111 111 111 111 111 111 111 111 111 111 111 = 33 bity

- jaka jest wartość dziesiętna maksymalnej liczby binarnej zapisanej na liczbie dziesiętnej typu int?

           9876543210 
UBIN_MAX = 1111111111 + 1 - 1 = 2^10 - 1 = 1024 - 1 = 1023


- jaka jest wartość dziesiętna maksymalnej liczby binarnej zapisanej na liczbie ósemkowej typu int? *

		   76543210
UBIN_MAX = 11111111 + 1 - 1 = 2^8 - 1 = 255



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


int dec2bin2(int x) {
    int sum = 0;
	int position = 1;
	
    while (x > 0) {
        int last = x % 10; 
       	int bin_part = 0; 
		int power = 1;
       
        while (last > 0) {
            bin_part = bin_part + (last % 2) * power;
            last = last / 2;
            power = power * 10;
        }

        sum = sum + bin_part * position;
        position = position * 1000; 
        x = x / 10;
    }

    return sum;
}

int bin2dec(int x) {
    int sum = 0;
	int pow = 1;
	
    while (x > 0) {
        sum = sum + (x % 10) * pow;
        x = x / 10;
        pow = pow * 2;
    }
    return sum;
}

void dec2byte(unsigned int x) {
    unsigned char *p_X = (unsigned char*)&x;
    
    printf("[");
    
    for (int i = 0; i < sizeof(x); i++) {
        printf("%d", p_X[i]);
        if (i < sizeof(x) - 1) {
            printf("] [");
        }
    }
    
    printf("]\n");  
}

int main() {
    printf("konwersje.c\n\n");

    int dec1 = 1023;  // dec1 = 0 .. 1023
    int bin = 11110000; 
    unsigned int dec2 = 100;
    
    printf("dec2bin(%d) = %d\n\n", dec1, dec2bin(dec1));
    printf("dec2bin2(%d) = %d\n\n", dec1, dec2bin2(dec1));
    printf("bin2dec(%d) = %d\n\n", bin, bin2dec(bin));
    printf("dec2byte(%d) = ", dec2); 
    
    dec2byte(dec2);
    
    return 0;
}