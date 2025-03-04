#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("stack.c\n\n");

    int x = 1;
    int y = 2;
    
    int *p_x = &x;
    int *p_y = &y;
    
    printf("p_x: %p\n", p_x); 
    printf("p_y: %p\n", p_y); 
    
    

    return 0;
}

/*
0064FEC4 [1][0][0][0]   x
0064FEC0 [2][0][0][0]   y
*/