#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

void letter_counting() {
    FILE *fp = fopen("sample.txt","r");

    if (fp == NULL) {
        perror("Error opening file");
        return;
    }

    int histogram[26] = {0};    // tablica na znaki a-z

    int ch;

    while  ((ch = fgetc(fp)) != EOF) {
        if (isalpha(ch)) {  // sprawdzanie czy zmienna ch jest znakiem
            ch = tolower(ch);
            histogram[ch - 'a']++;  // mapowanie litery na indeks tablicy
        }
    }

    fclose(fp);

    int empty_file_check = 0;

    // sprawdzanie czy plik zawiera litery
    for (int i = 0; i < 26; i++) {
        empty_file_check += histogram[i];
    }

    if (empty_file_check == 0) {
        printf("File does not contain letters\n");
    }

    // wyświetlanie histogramu na konsoli
    for (int i = 0; i < 26; i++) {
        if (histogram[i] > 0) {
            printf("%c: %d\n", 'a' + i, histogram[i]);  // do 'a' dodajemy wartość i przez co powstaje kolejna litera
        }
    }
}

int main() {
    letter_counting();
    return 0;
}