#include <stdio.h>
#include <stdlib.h>

/*
c
ala  ma kota
*/

void printChars(FILE *fp) {
    int c;

    while ((c = fgetc(fp)) != EOF) {
        printf("%c", c);
    }
}

void printLines(FILE *fp) {
    char line[1200+1]; // szerokość linii w notepad
    
    while (fgets(line, sizeof(line), fp) != NULL) {
        printf("%s", line);
    }
}

int main(int argc, char *argv[]) {
    printf("Files.c\n\n");

    const char name[] = "plik.txt";

    FILE *fp = fopen("plik.txt", "r");

    if (fp == NULL) {
        perror(name);

        return EXIT_FAILURE;
    }

    printChars(fp); printf("\n");
    
    printf("\n");

    rewind(fp);

    printLines(fp); printf("\n");

    printf("\n");

    fclose(fp);

    return 0;
}
