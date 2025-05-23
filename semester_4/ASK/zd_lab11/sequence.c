#include <stdio.h>
#include <stdlib.h>


double seq1(int n);
double seq2(int n);
double seq3(int n);

/*
r0  r1  r2
|---|---|       
1   2   3   4   5   6   7    indeksy
3   4   8   12  22  35  61.5   wartości
    |---|---|
    r0  r1  r2

Przesunięcie ramki w prawo:

r0 = r1
r1 = r2
r2 = 0.5*r1 + 2*r0
*/

double seq1(int n) {
   double r0 = 3;
   double r1 = 4;
   double r2 = 0.5*r1 + 2*r0;     
   
   if (n == 1) return r0;
   if (n == 2) return r1;
   if (n == 3) return r2;
   
   int i;   
   for (i = 1; i <= n-3; i++) {
       r0 = r1;
       r1 = r2;
       r2 = 0.5*r1 + 2*r0;
   }
   
   return r2;
}
   
/*
- dokonaj analizy wywołania seq1(4)

* seq1(4) = 12
  r0 = 3
  r1 = 4
  r2 = 8
  
  4 == 1 false
  4 == 2 false
  4 == 3 false
  
  i
  i = 1
  i <= 1   r0 = r1 = 4
           r1 = r2 = 8
           r2 = 0.5*8 + 2*4 = 12    i = 2 
           
  2 <= 1 false
  
  return r2 = 12
  
- narysuj graf obliczeń dla seq1(4)

 seq(1)  seq(2)    
      \   /  
      seq(3)  
        \    
        seq(4)
*/

/*
r0  r1 
|---| 
1   2   3   4   5   6   7    indeksy 
3   4   8  12  22  35  61.5   wartości 
|   |---| 
pom r0  r

Przesunięcie ramki w prawo:

pom = r1
r0 = r1
r1 = 0.5*r0 + 2*pom
*/

double seq2(int n) {
   double pom = 3;
   double r0 = 4;
   double r1 = 0.5*r0 + 2*pom;     
   
   if (n == 1) return pom;
   if (n == 2) return r0;
   if (n == 3) return r1;
   
   int i;   
   for (i = 1; i <= n-3; i++) {
       pom = r0;
       r0 = r1;
       r1 = 0.5*r0 + 2*pom;
   }
   
   return r1;
}
/*
- dokonaj analizy wywołania seq2(4)
* seq1(4) = 12
  pom = 3
  r0 = 4
  r1 = 0.5*4 + 2*3 = 2 + 6 = 8
  
  4 == 1 false
  4 == 2 false
  4 == 3 false
  
  i
  i = 1
  1 <= 1   pom = r0 = 4
           r0 = r1 = 8
           r1 = 0.5*r0 + 2*pom = 0.5*8 + 2*4 = 4 + 8 = 12   i = 2
           
  2 <= 1 false
  
  return r1 = 12
  
- narysuj graf obliczeń dla seq2(4)

 seq(1)  seq(2)    
      \   /  
      seq(3)  
        \    
        seq(4)
*/
double seq3(int n) {
	
	if (n == 1) return 3;
	if (n == 2) return 4;
	if (n == 3) return 8;
		
	return 0.5 * seq3(n-1) + 2 * seq3(n-2);
	
}
/*
- dokonaj analizy wywołania seq3(4)

 *seq3(4) = 12
  4 == 1 false
  4 == 2 false
  4 == 3 false
  
  return 0.5 * seq3(3) + 2 * seq3(2)
  
  3 == 1 false
  3 == 2 false
  3 == 3 true
  return 8
  
  seq3(2):
  2 == 1 false
  2 == 2 true
  return 4
  
  return 0.5 * 8 + 2 * 4
  return 4 + 8
  return 12
  
- narysuj graf wywołań dla seq3(4)

seq3(4)
   /   \
seq3(3) seq3(2)
  /   \
seq3(2) seq3(1)
*/    


int main() {
    printf("sequence.c\n\n");

    int n = 5;
	    
    printf("seq1(%d) = %.2f\n", n, seq1(n));
    printf("seq2(%d) = %.2f\n", n, seq2(n));
    printf("seq3(%d) = %.2f\n", n, seq3(n));

    return 0;
}