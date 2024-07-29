#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>
#include <limits.h>

int main()
{
    // Dlaczego program używa malloc do alokacji pamięci na wejście użytkownika?

    // Dlaczego w tym kodzie kilka razy występuje "free(buffor)"?

    // Dlaczego program używa srand(time(NULL)) do inicjalizacji generatora liczb losowych?

    // Jaka jest rola funkcji strtod w tym programie?

    // Jak program sprawdza, czy wybór gracza jest poprawny?

    // Jak program porównuje wybór gracza z wyborem komputera?

    int wybor_gracza;
    int wybor_komputera;
    
    printf("1. Kamien\n");
    printf("2. Papier\n");
    printf("3. Scyzoryk\n");
    printf("Wybierz przedmiot: ");
   
    char *buffor = malloc(64);
    if (buffor == NULL)
    {
        printf("\nBlad alokacji pamieci.");
        return -1;
    }

    if (fgets(buffor, 64, stdin) == NULL)
    {
        printf("\nBlad odczytu wejscia.");
        free(buffor);
        return -1;
    }

    // Usunięcie znaku nowej linii z końca wejścia, jeśli występuje
    size_t len = strlen(buffor);
    if (len > 0 && buffor[len - 1] == '\n') {
        buffor[len - 1] = '\0';
    }

    for (int i = 0; i < strlen(buffor); i++) 
    {
        if (!isdigit(buffor[i])) 
        {
            printf("\nWybrano zly przedmiot.");
            free(buffor);
            return -1;
        }
    }

    wybor_gracza = strtod(buffor, NULL);
    free(buffor);

    switch (wybor_gracza)   
    {
    case 1:
    case 2:
    case 3:
        break;
    default:
        printf("\nWybrano zly przedmiot.");
        return -1;
    }

    printf("\n");

    srand(time(NULL));
    wybor_komputera = rand() % 3 + 1;

    if (wybor_gracza == 1)
    {
        if (wybor_komputera == 1)
        {
            printf("Komputer wylosowal kamien i jest remis.\n");
        }
        else if (wybor_komputera == 2)
        {
            printf("Komputer wylosowal papier i wygral.\n");
        }
        else if (wybor_komputera == 3)
        {
            printf("Komputer wylosowal scyzoryk i wygrywasz.\n");
        }
    }
    else if (wybor_gracza == 2)
    {
        if (wybor_komputera == 1)
        {
            printf("Komputer wylosowal kamien i wygrywasz.\n");
        }
        else if (wybor_komputera == 2)
        {
            printf("Komputer wylosowal papier i jest remis.\n");
        }
        else if (wybor_komputera == 3)
        {
            printf("Komputer wylosowal scyzoryk i wygral.\n");
        }
    }
    else if (wybor_gracza == 3)
    {
        if (wybor_komputera == 1)
        {
            printf("Komputer wylosowal kamien i wygral.\n");
        }
        else if (wybor_komputera == 2)
        {
            printf("Komputer wylosowal papier i przegral.\n");
        }
        else if (wybor_komputera == 3)
        {
            printf("Komputer wylosowal scyzoryk i jest remis.\n");
        }
    }
    
    return 0;
}
