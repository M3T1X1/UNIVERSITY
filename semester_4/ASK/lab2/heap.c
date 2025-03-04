#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("heap.c\n\n");

    void *x = malloc(sizeof(int));
    void *y = malloc(sizeof(int));

    printf("x: %p\n", x);
    printf("y: %p\n\n", y);
    
    printf("y - x = %d\n\n", y - x);
    
    *(int*)x = 1;
    *(int*)y = 2;
    
    printf("*(int*)x = %d\n",*(int*)x);
    printf("*(int*)y = %d\n",*(int*)y);
    
    
    
    return 0;
}

/*
         [ ][ ][ ][ ]
         [ ][ ][ ][ ]
         [ ][ ][ ][ ]
007315C8 [2][0][0][0]   *(int*)y

         [ ][ ][ ][ ]
         [ ][ ][ ][ ]
         [ ][ ][ ][ ]
007315B8 [1][0][0][0]   *(int*)x

*/