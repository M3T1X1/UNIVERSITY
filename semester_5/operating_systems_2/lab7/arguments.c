#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("arguments.c\n\n");
    
    printf("argc = %d\n\n", argc);
    
    printf("addr: $s\n\n", argv[0]);
    
//  nazwa programu

    const char deli[] = "\\/";
    
// do dokonczenia

    printf("Params: ");

    for (int i = 1; i < argc; i++) {
        printf("%s ", argv[i]);
    }
    
    printf("\n");
    
	return 0;
}
