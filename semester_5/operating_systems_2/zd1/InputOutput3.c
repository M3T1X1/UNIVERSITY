#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    printf("InputOutput3.c\n\n");

    char str[15];

    scanf("%[^\n]", str);

    printf("%s",str);

    return 0;
}
