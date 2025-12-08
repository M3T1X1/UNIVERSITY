#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    printf("list.c\n\n");
    
    int length = 0;
    
    for (int i = 1; i < argc; i++) {
        length = length + 1 + strlen(argv[i]);
    }
    
    /*
    ls
    dir
    */

    char commands[3 + length + 1]; 

#ifdef linux
    strcpy(commands, "ls");
#else
    strcpy(commands, "dir");
#endif

    for (int i = 1; i < argc; i++) {
        strcat(commands, " ");
        strcat(commands, argv[i]);
    }
    
    system(commands);
    
	return 0;
}
