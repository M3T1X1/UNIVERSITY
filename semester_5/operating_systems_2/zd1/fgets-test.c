#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    printf("fgets-test.c\n\n");

    char str[15];

    printf("str = ");
    fgets(str, 15, stdin);

    printf("str = %s", str);

    return 0;
}