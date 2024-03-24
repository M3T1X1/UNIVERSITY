#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    FILE *fp;
    int cyfry = 0;
    int duza_l = 0; 
    int mala_l = 0;
    char ch;

    fp = fopen(argv[1], "r");

    while ((ch = fgetc(fp)) != EOF) {
        if (isdigit(ch)) {
            cyfry++;
        } else if (isupper(ch)) {
            duza_l++;
        } else if (islower(ch)) {
            mala_l++;
        }
    }

    fclose(fp);

    printf("Liczba cyfr: %d\n",cyfry);
    printf("Liczba duzych liter: %d\n",duza_l);
    printf("Liczba malych liter: %d\n",mala_l);

    return 0;
}