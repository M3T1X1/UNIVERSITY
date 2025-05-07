#include <stdio.h>
#include <stdlib.h>

// seq(1) = 3
// seq(2) = 4
// seq(n) = 0.5*seq(n-1) + 2*seq(n-2)  dla  n > 2

/*
a   b   c
|---|---|       .
1   2   3   4   5   6   7    indeksy
3   4   8   12  22  35  61.5 wartości
    |---|---|
    a   b   c
      
*/

double seq1(int n) {
    if (n == 1) return 3;
    if (n == 2) return 4;
    
    double a = 3;
    double b = 4;
    double c = 8;
    
    for (int i = 1; i <=n-3; i++) {
        a = b;
        b = c;
        c = 0.5 * b + 2 * a;
    }
    
    return c;
}

double seq2(int n) {
    if (n == 1) return 3;
    if (n == 2) return 4;
    
    double a = 3;
    double b = 4;
    double c;
    
    for (int i = 1; i <=n-2; i++) {
        c = 0.5 * b + 2 * a;
        a = b;
        b = c;
    }
    
    return c;
}

int main() {
    printf("sequence.c\n\n");

	int n = 4;    
    
    printf("seq1(%d) = %.2f\n\n", n, seq1(n));   
    printf("seq2(%d) = %.2f\n", n, seq2(n));   
    

    return 0;
}


