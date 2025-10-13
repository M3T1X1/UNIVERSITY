#include <stdio.h>
#include <stdlib.h>

struct Fraction {
    int num, den;
};

/*
a/b + c/d = (a*d)/(b*d) + (c*b)/(d*b) = (a*d + c*b) / (b*d)
*/

struct Fraction sum(struct Fraction x, struct Fraction y) {
    int a = x.num;
    int b = x.den;
    
    int c = y.num;
    int d = y.den;
    
    struct Fraction z;
    
    z.num = a*d + c*b;
    z.den = b*d;
    
    return z;
}

/*
a/b * c/d = (a*c) / (b*d)
*/

struct Fraction mul(struct Fraction x, struct Fraction y) {
    int a = x.num;
    int b = x.den;
    
    int c = y.num;
    int d = y.den;
    
    struct Fraction z;
    
    z.num = a*c;
    z.den = b*d;
    
    return z;
}

void print(struct Fraction x, struct Fraction y, const char op) {
    
    if (op != '+' && op != '-' && op != '*' && op != '/' && op != ':') {
        printf("%c - nieznane dzialanie\n", op);
    } else {
        struct Fraction z;
        
        if (op == '+') z = sum(x, y);
        // sub
        if (op == '*') z = mul(x, y);
        // quo
        
        printf("%d/%d %c %d/%d = %d/%d\n", x.num, x.den, op,
                                           y.num, y.den, z.num, z.den);        
    }
}

int nwd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

void printFraction(struct Fraction x) {
	int num = x.num;
    int den = x.den;

    if (den == 0) {
        printf("NaN\n");
        return;
    }
    if (num == 0) {
        printf("0\n");
        return;
    }
    
    int znak = 0;
    if (num < 0) znak = 1;
    if (den < 0) znak = 1;
    
    num = abs(num);
    den = abs(den);
    
    int c = nwd(num, den);
    num /= c;
    den /= c;
    
    int calkowita = num / den;
    int reszta = num % den;
    
    if (znak == 1) printf("-");
    if (calkowita != 0 && reszta != 0) {
    	printf("%d %d/%d\n", calkowita, reszta, den);
	}else if (reszta == 0) {
		printf("%d\n", calkowita);
	}else {
		printf("%d/%d\n", num, den);
	}
}

int main(int argc, char *argv[]) {
    printf("Fractions.c\n\n");
    
    struct Fraction x = {2, 3};
    struct Fraction y = {1, 4};
    
    struct Fraction z = sum(x, y);
    
    printf("%d/%d + %d/%d = %d/%d\n", x.num, x.den,
                                      y.num, y.den, z.num, z.den);
   
    print(x, y, '*');
    print(x, y, '$');
    
    printFraction((struct Fraction){2,0});  // NaN
	printFraction((struct Fraction){0,2});  // 0
	printFraction((struct Fraction){2,4});  // 1/2
	printFraction((struct Fraction){-1,2}); // -1/2
	printFraction((struct Fraction){1,-2}); // -1/2
	printFraction((struct Fraction){4,-2}); // -2
	printFraction((struct Fraction){5,-2}); // -2 1/2
  
	return 0;
}
