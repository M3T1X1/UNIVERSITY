#include <stdio.h>

int main(int argc, char *argv[])
{
    FILE *fp;
    
    int policz=0;
    char litera=0;

    fp = fopen(argv[1], "r");
    
    while ((litera = fgetc(fp)) != EOF) 
    {
        policz++;
    }

    printf("Liczba liter: %d\n",policz);

    return 0;
}