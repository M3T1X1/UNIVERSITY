#include <stdio.h>

typedef struct figura 
{
    int fig; 
    double wymiary[3]; 
};


double pole(struct figura f) 
{
    double wynik = 0.0;

    if(f.fig == 1) 
    {
        wynik = 0.5 * f.wymiary[0] * f.wymiary[1];
    } 
    else if(f.fig == 2) 
    { 
        wynik = f.wymiary[0] * f.wymiary[1];
    } 
    else if(f.fig == 3) 
    { 
        wynik = f.wymiary[0] * f.wymiary[1];
    } 
    else if(f.fig == 4) 
    { 
        wynik = 0.5 * (f.wymiary[0] + f.wymiary[1]) * f.wymiary[2];
    }
    
    return wynik;
}

int main() 
{
    struct figura f_trojkat = {1, {6.0, 4.0}}; 
    struct figura f_prostokat = {2, {5.0, 3.0}}; 
    struct figura f_rownoleglobok = {3, {7.0, 2.0}}; 
    struct figura f_trapez = {4, {3.0, 5.0, 4.0}}; 

    printf("Pole trojkata: %f\n", pole(f_trojkat));
    printf("Pole prostokata: %f\n", pole(f_prostokat));
    printf("Pole rownolegloboku: %f\n", pole(f_rownoleglobok));
    printf("Pole trapezu: %f\n", pole(f_trapez));

    return 0;
}