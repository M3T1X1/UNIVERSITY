#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *fp;

    int count = 0;
    int suma = 0;
    int num = 0;
    float srednia;

    fp = fopen(argv[1], "r");

    while (fscanf(fp, "%d", &num) == 1) {
        suma += num;
        count++;
    }

    fclose(fp);

    srednia = (float)suma / count;

    printf("Suma: %d\n",suma);
    printf("Srednia: %d\n",srednia);

    return 0;
}