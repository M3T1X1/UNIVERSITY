#include <stdio.h>

int czyPierwsza(float *liczba)
{
  if((int)*liczba < 2)
  {
    return 0;
  }

  for(int i=2; i*i<=*liczba;i++)
  {
    if((int)*liczba%i==0)
    {
       //printf("Nie jest");
       return 0;
    }
    else
    {
        //printf("Jest");
        return 1;
    }
  }
  
}

int main()
{
    float floatcik = 4;

    czyPierwsza(&floatcik);
}