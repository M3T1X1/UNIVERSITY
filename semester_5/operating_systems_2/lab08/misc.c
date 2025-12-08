#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int losuj(int a, int b) { // [a,b)

    return a + rand() % (b-a);
}

/*
[a-zA-Z0-9./]

a  b
oooo
4567

Liczba kropek = b - a + 1 = 7 - 4 + 1 = 4
*/

int wariacje1() {
    int one = ('z' - 'a' + 1) + ('Z' - 'A' + 1) + ('9' - '0' + 1) + 1 + 1;
    int two = one * one;

    return two;
}

void set(char salt[2]) {
    int one = ('z' - 'a' + 1) + ('Z' - 'A' + 1) + ('9' - '0' + 1) + 1 + 1;

    char charset[one];

    int i = 0;

    for (int j = 'a'; j <= 'z'; j++) charset[i++] = j;

    for (int j = 'A'; j <= 'Z'; j++) charset[i++] = j;

    for (int j = '0'; j <= '9'; j++) charset[i++] = j;

    charset[i++] = '.';
    charset[i++] = '/';

    salt[0] = charset[losuj(0,one)];
    salt[1] = charset[losuj(0,one)];
    salt[2] = '\0';
}

int errnoExample() {
    const char name[] = "aaaplik.txt";

    FILE *fp = fopen("plik.txt", "r");

    if (fp == NULL) {
        int errno_ = errno;

        printf("%s: %s\n", name, strerror(errno_));

        return EXIT_FAILURE;
    }

    fclose(fp);

    return 0;
}

int main(int argc, char *argv[]) {
    printf("misc.c\n\n");

//  losuj test

    printf("RAND_MAX = %d\n\n", RAND_MAX);

    int a = 1;
    int b = 5;

    int liczba_losowan = 5;

    srand(time(NULL));

    for (int i = 1; i <= liczba_losowan; i++) {
        printf("Losuj(%d, %d) = %d\n", a, b, losuj(a, b));
    }

    printf("\n");

//  wariacja test

    printf("wariacje1() = %d\n", wariacje1());

    printf("\n");

//  set test

    char salt[2 + 1];

    for (int i = 1; i <= liczba_losowan; i++) {
        set(salt);

        printf("Set -> %s\n", salt);
    }

    printf("\n");

//  error test

    errnoExample();

    printf("\n");

    return 0;
}