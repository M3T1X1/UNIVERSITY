#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

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
            if(isspace(c)) continue;
            
            counter++;
            inside = 1;
        } else {
            if(!isspace(c)) continue;
            
            inside = 0;
        }
    }
    
    return counter;
}

int countWords2(FILE *fp) {
    int counter = 0;
    int c;
	int prev = ' '; 
    
    while ((c = fgetc(fp)) != EOF) {
        if (!isspace(c) && isspace(prev)) {
            counter++;
        }
        prev = c;
    }
    return counter;
}

int main(int argc, char *argv[]) {
    printf("CountWords.c\n\n");

    const char name[] = "plik.txt";

    FILE *fp = fopen("plik.txt", "r");

    if (fp == NULL) {
        perror(name);

        return EXIT_FAILURE;
    }

    printChars(fp); printf("\n");
    
    printf("\n");

    rewind(fp);

    printf("words1 = %d", countWords1(fp));
    
	printf("\n");  
	
	rewind(fp);  
    
    printf("words2 = %d", countWords2(fp));

    fclose(fp);

    return 0;
}
