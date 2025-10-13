#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    printf("InputOutput4.c\n\n");

    char str[15];

    fgets(str,15,stdin);
    printf("%s",str);

    return 0;
}