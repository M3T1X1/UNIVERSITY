#include <stdio.h>
#include <stdlib.h>


int main()
{
	int x = 1;
 	char *p_X = (char*)&x;
 	
 	printf("%p\n\n", *p_X);
 	
	
	return 0;
}