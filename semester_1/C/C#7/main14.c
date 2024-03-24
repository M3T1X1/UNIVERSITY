#include <stdio.h>
#include <ctype.h>

void bez_znakow(char *sciezka) 
{
    FILE *fp;  
    int znak = 0;

    fp = fopen(sciezka, "r");
   
    while ((znak = fgetc(fp)) != EOF) 
    {
          if (!isspace(znak)) 
          {
        
          }
    }

}