#include <stdio.h>

int zabawa(int min, int max) 
{
    char odp=0;
    if (min == max) 
    {
        return min;
    }

    int zaokraglanie = (min + max)/2;

    printf("Czy twoja liczba jest wieksza od %d? Jesli tak, wpisz t, a jesli nie to wpisz n: ", zaokraglanie);
    scanf(" %c", &odp);

    if(odp == 't') 
    {
        return zabawa(zaokraglanie + 1, max);
    }
    else(odp == 'n'); 
    {
        return zabawa(min, zaokraglanie);
    }
}
int main()
{
    printf("Wymysl liczbe od 0 do 10000\n");
    printf("Wymyslona liczba to %d.\n", zabawa(0, 10000));
}