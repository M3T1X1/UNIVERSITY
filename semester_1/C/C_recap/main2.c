#include <stdio.h>

struct Kolo
{
    float promien;
    char tab[100];

};

float pole(struct Kolo *pointer)
{
    //float wartosc =3.14*pointer->promien*pointer->promien; 
    //printf("%f",wartosc);
    return 3.14*(*pointer).promien*(*pointer).promien; //pi * r^2

    //jak odwołuję się od zwykłego stuct to:
    //pierwszy.promien
    //jak od pointera struckt to:
    //(*pierwszy).promien
}

struct Kolo *noweKolo(float r)
{
    struct Kolo trzecie = {r,"trzecie"};
    return &trzecie;
}

int main()
{
    struct Kolo pierwsze = {4, "pierwsze"};
    struct Kolo drugie = {pole(&pierwsze),"drugie"};
    struct Kolo *trzecie = noweKolo(drugie.promien);
    
    pole(&pierwsze);
}