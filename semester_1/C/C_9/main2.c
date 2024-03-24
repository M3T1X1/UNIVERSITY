#include <stdio.h>
#include <unistd.h>

int main()
{
    FILE *fp;

    char file_name[100];
    char c = 0;
    
    
    printf("Podaj nazwe pliku: ");
    scanf("%s",&file_name);

    fp = fopen(file_name,"r");

    if(!access(file_name, F_OK) == 0)
    {
        printf("Plik nie istenije");
    }

    while ((c=fgetc(fp)) !=EOF)
    {
        printf("%c",c);
    }
    

}