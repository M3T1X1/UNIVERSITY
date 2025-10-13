#include <stdio.h>

int main(void) {
    int str;

    printf("str = ");

    str = getchar();

    if (str == EOF) {
        printf("Stdin is empty\n");
    } else {
        printf("Stdin is not empty\n");
    }

    return 0;
}