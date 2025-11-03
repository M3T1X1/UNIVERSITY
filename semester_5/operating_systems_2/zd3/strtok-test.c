#include <stdio.h>
#include <stdlib.h>

void printHex(const char *str, size_t len) {
    for (size_t i = 0; i < len; i++) {
        printf("%02X ", (unsigned char)str[i]);
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    printf("strtok-test.c\n\n");
    
    char str[] = "  Ala  ma\t\tkota.\n";
    const char delim[] = " \t\n";
    size_t len = sizeof(str);

    printf("  Ala  ma               kota.\n\n");

    printf("Original hex:\n");
    printHex(str, len);
    printf("\n");

    char *token = strtok(str, delim);

    if (token != NULL) {
        printHex(str, len);
    }

    while (token != NULL) {
        printHex(str, len);
        
        token = strtok(NULL, delim);
    }

    printf("\n");

    strcpy(str, "  Ala  ma\t\tkota.\n");
    token = strtok(str, delim);
    while (token) {
        printf("%p \"%s\"\n", (void*)token, token);
        token = strtok(NULL, delim);
    }
    
	return 0;
}
