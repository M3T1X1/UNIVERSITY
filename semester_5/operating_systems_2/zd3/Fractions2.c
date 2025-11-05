#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("Fractions2.c\n\n");
    
    char buff[10];
    
    if (fgets(buff, sizeof(buff), stdin)) {
        char *p = buff;
        while (*p != '\0') {
            if (*p == '\n') {
                *p = '\0';
                break;
            }
            p++;
        }
        
        printf("Tekst: \"%s\"\n", buff);
    } else {
        printf("Error\n");
    }
    
	return 0;
}
