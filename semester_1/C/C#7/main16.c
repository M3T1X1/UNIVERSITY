#include <stdio.h>

void dopisz_pliki(char *sciezka1, char *sciezka2) 
{
    FILE *fp1;
    fp1=fopen(sciezka1, "r");
   
    FILE *fp2;
    fp2 = fopen(sciezka2, "a");

    int znak = 0;
    
    while ((znak = fgetc(fp1)) != EOF) 
    {
        fputc(znak, fp2);
    }

    fclose(fp1);
    fclose(fp2);
}