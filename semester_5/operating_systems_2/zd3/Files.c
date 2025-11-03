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

void copy(const char *addr1, const char *addr2) {
    FILE *src = fopen(addr1, "r");
    if (src == NULL) {
        perror(addr1);
        exit(EXIT_FAILURE);
    }

    FILE *dest = fopen(addr2, "w");
    if (dest == NULL) {
        perror(addr2);
        fclose(src);
        exit(EXIT_FAILURE);
    }

    int ch;
    while ((ch = fgetc(src)) != EOF) {
        fputc(ch, dest);
    }

    fclose(src);
    fclose(dest);
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
    
    copy("plik.txt", "skopiowany_plik.txt");

    return 0;
}
