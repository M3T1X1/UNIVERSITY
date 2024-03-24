#include <stdio.h>

int binary_Conv(int liczba)
{
    
    if(liczba > 0)
    {
        binary_Conv(liczba/2);
        printf("%d",liczba%2);
    }

}

int main()
{
    int liczba=0;

    printf("Podaj liczbe dziesietna: ");
    scanf("%d",&liczba);

    binary_Conv(liczba);
    
}