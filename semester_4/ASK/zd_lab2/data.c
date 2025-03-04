#include <stdio.h>
#include <stdlib.h>

int main() { 
	printf("data.c\n\n");
	 
	int z1 = 1;
	int z2 = 2;
	
	int n1;
	int n2;
	
	int z3 = 3;
	int n3;
	
	int n4;	
	int z4 = 4;

	printf("Wartosci zmiennych, wraz z ich adresami:\n\n");
	
	printf("Wartosc z1: %d\n", z1);
	printf("Adres z1: %p\n\n", &z1);
	
	printf("Wartosc z2: %d\n", z2);
	printf("Adres z2: %p\n\n", &z2);

	printf("Adres n1: %p\n", &n1);
	printf("Adres n2: %p\n\n", &n2);
	
	printf("Wartosc z3: %d\n", z3);
	printf("Adres z3: %p\n\n", &z3);
	
	printf("Adres n3: %p\n\n", &n3);

	printf("Adres n4: %p\n\n", &n4);

	printf("Wartosc z4: %d\n", z4);
	printf("Adres z4: %p\n\n", &z4);
	
	
	
	
    return 0;
}

/*
heap  [ ][ ][ ][ ]   heap

0064FEB4 [ ][ ][ ][ ]   n4
0064FEB8 [ ][ ][ ][ ]    n3
0064FEC0 [ ][ ][ ][ ]   n2
0064FEC4 [ ][ ][ ][ ]   n1
                         
0064FEB0 [4][ ][ ][ ]   z4	
0064FEBC [3][ ][ ][ ]   z3
0064FEC8 [2][ ][ ][ ]   z2
0064FECC [1][ ][ ][ ]   z1

main  [ ][ ][ ][ ]   text

*/