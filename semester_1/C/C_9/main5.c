#include <stdio.h>

typedef struct punkt10
{
    int punkty[10];
};

void przepisanieWartosci(struct punkt10 tab1[], struct punkt10 tab2[], int rozmiar)
{
for(int i=0; i<rozmiar; i++)
{
    for(int j; j<rozmiar; j++)
    {
        tab2[i].punkty[j] = tab1[i].punkty[j];
    }
}
}

int main()
{
    struct punkt10 tab1[10] = {0,1,2,3,4,5,6,7,8,9};
    struct punkt10 tab2[10];

    int rozmiar = sizeof(tab1)/sizeof(tab1[0]);

    przepisanieWartosci(tab1,tab2,rozmiar);

    for(int i=0; i<rozmiar; i++)
    {
        printf("pkt: %d",i+1);
        for(int j=0; j<rozmiar;j++)
        {
            printf("\n %d ",tab2[i].punkty[j]);
        }
    }
}
