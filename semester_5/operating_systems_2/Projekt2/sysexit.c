#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

//gcc sysexit.c -o sysexit

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Podaj dokładnie 1 argument!\n");
        return -1;
    }

    int i = 0;
    while (argv[1][i] != '\0') {
        if (!isdigit((unsigned char)argv[1][i])) {
            printf("Argument musi być TYLKO liczbą całkowitą!\n");
            _exit(1);
        }
        i++;
    }

    int error_code = atoi(argv[1]);

    printf("String przed _exit(%d)\n", error_code);

    _exit(error_code);

    printf("String po _exit(%d), ktory nigdy się nie wykona.\n", error_code);
}