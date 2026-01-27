#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1024

int main(int argc, char *argv[]) {
    printf("scanf-test.c\n\n");

    printf("str = ");

    char str[MAX_SIZE];

    memset(str, 255, sizeof(str));

    scanf("%1023s", str);

    printf("str = ");

    // complete 
    
    for(int i = 0; i < MAX_SIZE; i++) {
    	if(str[i] == ' ') printf(" ");
    	else if (str[i] == '\n') printf("\\n");
    	else if (str[i] == '\t') printf("\\t");
    	else if (str[i] == '\0') printf("\\0");
    	else printf("%c", str[i]);
	}

    printf("\n");

    return 0;
}