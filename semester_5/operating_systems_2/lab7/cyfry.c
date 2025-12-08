#include <stdio.h>
#include <stdlib.h>

/*
gcc cyfry.c -o cyfry -Wall
*/

int cyfry2(int n) {
    return snprintf(NULL, 0, "%i", abs(n));
}

int main(int argc, char *argv[]) {
    printf("cyfry.c\n\n");

    int n = -3579;

    printf("cyfry2(%i) = %d\n\n", n, cyfry2(n));
    
	return 0;
}
