#include <stdio.h>
#include <math.h>
int funcRecu(int n)
{
int a=0;

if(n==1)
{
    return -1;
}
else
{
    return (-funcRecu(n-1)*n-2);
}

}

int main()
{
    printf("%d\n",funcRecu(3));
}

