#include <stdio.h>
#include <stdlib.h>

/*
gcc check.c -o check -wall
*/

int main(int argc, char *argv[]) {
    printf("check.c\n\n");
    
    printf("Program compiled on: ");
    
#ifdef linux
    printf("Linux\n");       
#else
    printf("Windows\n");
#endif    
	return 0;
}
