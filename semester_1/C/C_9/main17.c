#include <stdio.h>

int main(int argc, char *argv[]) 
{
  
    const char *nazwa_pliku = argv[1];
    FILE *fp;
    fp = fopen(nazwa_pliku, "w");
  
    int n = 0;
    printf("Podaj liczbę linii: ");
    scanf("%d", &n);

    char linia[200];
    for (int i = 0; i < n; i++) 
    {
        printf("Wpisz linię %d: ", i + 1);
        scanf(" %[^\n]", linia);
        fprintf(fp, "%s\n", linia);
    }

    fclose(fp);

    return 0;
}

