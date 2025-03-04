#include <stdio.h>
#include <stdlib.h>


int main()
{
	int x = 1;
 	char *p_X = (char*)&x;  // wskaznik na najmlodszy bajt liczby 1
 	
	if (*p_X == 1) {  // sprawdzam czy najmlodszy bajt ma przypisana wartosc 1
		printf("little-endian architecture");
	}
	else {
		printf("big-endian architecture");
	}
 	
	
	return 0;
}