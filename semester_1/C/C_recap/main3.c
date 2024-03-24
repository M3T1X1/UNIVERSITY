#include <stdio.h>

void procedura(char *nazwa)
{
     FILE* fp = fopen(nazwa,"r");
     
     char znaki[100];
     while(fgets(znaki,100,fp))
     {
        printf("%s",znaki);
     }
     fclose(fp);
}

int main()
{
char tab[100] = "plik.txt";

procedura(tab);
}