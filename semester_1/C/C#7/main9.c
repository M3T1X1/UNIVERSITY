#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *fp1, *fp2;
    char litera=0;

    fp1 = fopen(argv[1], "r");

    while ((litera = fgetc(fp1)) != EOF) {
        fputc(litera, fp2);
    }

    fclose(fp1);
    fclose(fp2);

    return 0;
}