#include <stdio.h>

int sumaCyfr(int cyfra)
{
    int c_1 = cyfra%10;
    int c_10 = cyfra/10;

    if(cyfra==0)
    {
        return 0;
    }
    else
    {
        return c_1+sumaCyfr(c_10);
    }
}

int main()
{
    int liczba=0;

    printf("Podaj liczbe calkowita: ");
    scanf("%d",&liczba);
    int wynik = sumaCyfr(liczba);

    printf("Wynik to: %d",wynik);
    
    return 0;
}

