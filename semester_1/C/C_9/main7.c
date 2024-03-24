#include <stdio.h>

typedef struct Zespolona 
{
    double re; 
    double im; 
};


struct Zespolona dodanie(struct Zespolona z1, struct Zespolona z2) 
{
    struct Zespolona wynik;

    wynik.re = z1.re + z2.re; 
    wynik.im = z1.im + z2.im; 
    
    return wynik; 

}

int main() 
{
    struct Zespolona l_1 = {5.5, 3.5}; 
    struct Zespolona l_2 = {3.0, 8.5}; 
    struct Zespolona suma = dodanie(l_1, l_2);

    printf("Wynik dodawania: %f + %f i", suma.re, suma.im);
}
