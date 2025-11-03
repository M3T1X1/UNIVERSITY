#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("Fractions2.c\n\n");
    
    char buffer[10];
    
    if (fgets(buffer, sizeof(buffer), stdin)) {
        char *p = buffer;
        while (*p != '\0') {
            if (*p == '\n') {
                *p = '\0';
                break;
            }
            p++;
        }
        
        printf("Wczytany tekst: \"%s\"\n", buffer);
    } else {
        printf("Blad podczas odczytu!\n");
    }
    
	return 0;
}
