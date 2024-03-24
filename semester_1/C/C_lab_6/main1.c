/*
#include <stdio.h>
#include <math.h>

int silnia(int liczba) { 
int sil; 
if (liczba < 0) return 0;
if (liczba == 0 || liczba == 1) return 1; 
sil = liczba * silnia(liczba - 1); 
return sil;
}
 int main()
 {
    int x = 0;
    int result = silnia(x);

    printf("Podaj liczbe: ");
    scanf("%d",&x);

    printf("%d",silnia(x));
 }
 */

#include <stdio.h> 
 
unsigned count; 
 
unsigned fib_rec(unsigned n) { 
++count; 
return n < 2 ? n : (fib_rec(n - 2) + fib_rec(n - 1)); 
} 
 
unsigned fib_it(unsigned n) { 
unsigned a = 0, b = 0, c = 1; 
++count; 
if (!n) return 0; 
while (--n) { 
++count; 
a = b; 
b = c; 
c = a + b; 
} 
return c; 
} 
 
int main(void) { 
unsigned n, result; 
printf("Ktory element ciagu Fibonacciego obliczyc? "); 
while (scanf("%d", &n) == 1) { 
count = 0; 
result = fib_rec(n); 
printf("fib_rec(%3u) = %6u (wywolan: %5u)\n", n, result, 
count); 
count = 0; 
result = fib_it(n); 
printf("fib_it (%3u) = %6u (wywolan: %5u)\n", n, result, 
count); 
} 
return 0; 
} 