#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("scanf-test.c\n\n");

    char str[15];

    printf("str = ");
    scanf("%s", str);

    printf("str = %s", str);

    return 0;
}
