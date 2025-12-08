#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
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

/*
c  c'
   ala  ma kota
*/


int countWords1(FILE *fp) {
    int inside = 0;
    int counter = 0;

    int c;
    while ((c = fgetc(fp)) != EOF) {
        if (inside == 0) {
            if (isspace(c)) continue;

            counter++;
            inside = 1;
        } else {
            if (!isspace(c)) continue;

            inside = 0;
        }
    }

    return counter;
}

/*
Ala ma kota,\n
a  kot\tma Ale.
*/

void printWords(FILE *fp) {
    char line[1200+1]; // szerokość linii w notepad

    while (fgets(line, sizeof(line), fp) != NULL) {
        const char delim[] = " \n\t";

        /* get the first token */
        char *token = strtok(line, delim);

        /* walk through other tokens */
        while (token != NULL) {
            printf( "%s\n", token );

            token = strtok(NULL, delim);
        }
    }
}


int main(int argc, char *argv[]) {
    printf("DisplayWords.c\n\n");

    const char name[] = "plik.txt";

    FILE *fp = fopen("plik.txt", "r");

    if (fp == NULL) {
        perror(name);

        return EXIT_FAILURE;
    }

    printChars(fp); printf("\n");
    
    printf("\n");

    rewind(fp);

    printWords(fp); printf("\n");    

    fclose(fp);

    return 0;
}
