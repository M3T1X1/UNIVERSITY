#include <stdio.h>
#include <math.h>

typedef struct punkt 
{
    int x;
    int y;
    int z;
};

int odleglosc(struct punkt pkt1, struct punkt pkt2) 
{
    return sqrt(pow(pkt2.x - pkt1.x, 2) + pow(pkt2.y - pkt1.y, 2) + pow(pkt2.z - pkt1.z, 2));
}

int minimalnaOdleglosc(struct punkt tab[], int rozmiar) 
{
    int min_odleglosc = odleglosc(tab[0], tab[1]);

    for (int i=0; i<rozmiar-1; i++) 
    {
        for (int j=i+1; j<rozmiar; j++) 
        {
            int odleglosc = Odleglosc(tab[i], tab[j]);
            if (odleglosc < min_odleglosc) 
            {
                min_odleglosc = odleglosc;
            }
        }
    }
    return min_odleglosc;
}

void przepisanieWartosci(struct punkt tab1[],struct punkt tab2[], int rozmiar)
{
    for(int i=0; i<rozmiar; i++)
    {
        tab2[i] = tab1[i];
    }
}

int main() 
{
    struct punkt tab[] =  
    { 
        {0, 1, 2},
        {3, 4, 5},
        {6, 7, 8},
        {9, 10, 11}
    };

    struct punkt tab2[] = {};

    int rozm_tab = sizeof(tab) / sizeof(tab[0]);
    int min_odl = minimalnaOdleglosc(tab, rozm_tab);

    printf("Najmniejsza odleglosc: %d", min_odl);

    przepisanieWartosci(tab,tab2,rozm_tab);
}
