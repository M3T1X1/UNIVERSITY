#include <stdio.h>

typedef struct trojkat
{
    int a;
    int b;
    int c;
};

int obwTr(struct trojkat o)
{
   int wynik = o.a + o.b + o.c;

   printf("Obw wynosi: %d",wynik);
}

void przepisanieWartosci(struct trojkat o, struct trojkat *o_2)
{
    o_2->a = o.a;
    o_2->b = o.b;
    o_2->c = o.c;
}

int main()
{
    struct trojkat pierwszy;
    pierwszy.a = 5;
    pierwszy.b = 4;
    pierwszy.c = 3;

    struct trojkat drugi;
    drugi.a = 10;
    drugi.b = 5;
    drugi.c = 3;

    int obw = drugi.a+drugi.b+drugi.c;
    
    obwTr(pierwszy);
    przepisanieWartosci(pierwszy,&drugi);

    printf("\nObw bez kopiowania: %d",obw);
    printf("\nObw po kopiowaniu: %d",drugi.a+drugi.b+drugi.c);
}