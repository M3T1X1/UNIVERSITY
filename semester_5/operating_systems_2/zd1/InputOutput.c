#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("InputOutput.c\n\n");
    
    printf("a = ");
    
    int a;
    scanf("%d", &a);

    printf("int value a = %d\n\n", a);
    
    printf("b = ");
    
    float b;
    scanf("%f", &b);

    printf("float value b = %f\n\n", b);
    
    printf("c = ");
    
    char str[10];
    scanf("%9s", str);

    printf("string value c = %s\n\n", str);

	printf("d = ");

	double d;
	scanf("%lf", &d);

	printf("double value d = %.15lf\n\n", d);

	return 0;
}
