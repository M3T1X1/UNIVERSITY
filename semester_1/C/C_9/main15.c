#include <stdio.h>

int liczba_wystapien(char *sciezka, char c) 
{
    FILE *fp; 
    int znak = 0;
    int licznik = 0;
    
    fp = fopen(sciezka, "r");

    while ((znak = fgetc(fp)) != EOF) 
    {
        if (znak == c) {
            licznik++;
        }
    }

    return licznik;
}