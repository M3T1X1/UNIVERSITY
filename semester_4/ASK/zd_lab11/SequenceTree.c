#include <stdio.h>
#include <stdlib.h>

int f(int n) {
    if (n == 1) return 3;
    if (n == 2) return 4;
    if (n == 3) return 5;

    return f(n - 1) + f(n - 2) + f(n - 3);
}

int seq(int n) {
    static int wywolanie = 0;
    wywolanie++;

    printf("seq%d(%d) = %d\n", wywolanie, n, f(n));

    if (n == 1) return 3;
    if (n == 2) return 4;
    if (n == 3) return 5;

    return seq(n - 1) + seq(n - 2) + seq(n - 3);
}

int main() {
    printf("SequenceTree.c\n\n");

    int n = 4;

    seq(n);

    return 0;
}