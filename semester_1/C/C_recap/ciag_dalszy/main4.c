//Napisz funkcje która bierze za argument pointer na zmienną typu char i wpisuje do pliku jakąś wartość, a potem wyświetla wartośc w terminalu.

#include <stdio.h>

void wpiszDoPliku(char *wartosc[], char *nazwa[])
{
    FILE *fp = fopen(nazwa,"w+");
    char linie[100];

    fputs(wartosc,fp);

   while(fgets(linie,100,fp))
   {
    printf("%s",linie);
   }

    fclose(fp);
}

int main()
{
    char wartosc[100] = "Witam serdecznie";
    char nazwa[100] = "plik.txt";

    wpiszDoPliku(wartosc, nazwa);
}