#include <stdio.h>

// Definicja struktury przechowującej dane osobowe
typedef struct dane_osobowe 
{
    char imie[50];
    char nazwisko[50];
    int wiek;
};

void najmlodszy(struct dane_osobowe tab[], int rozmiar) 
{
    int wiek_min = 0;

    for (int i = 1; i < rozmiar; ++i) 
    {
        if (tab[i].wiek < tab[wiek_min].wiek) 
        {
            wiek_min = i;
        }
    }

    printf("%s %s jest najmlodszy\n", tab[wiek_min].imie, tab[wiek_min].nazwisko);
}

int main() 
{
    struct dane_osobowe tablica[] = 
    {
        {"Stanislaw", "Nieczystosci", 25},
        {"Boguslaw", "Lecina", 22},
        {"Tytus", "Bomba", 20},
        {"Dominik", "Jachas", 30}
    };

    int rozmiar = sizeof(tablica) / sizeof(tablica[0]);

    najmlodszy(tablica, rozmiar);
}
