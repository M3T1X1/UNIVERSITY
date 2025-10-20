#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/*                 index
                   | 
         0    1    2    3    4      indexes
str -> ['9']['9']['$'][' ']['\0']
       |         |
       str       ptr                pointers
*/

int indexOf(const char *str, int c) {
    char *ptr = strchr(str, c);
    
    if (ptr == NULL) return -1;
    
    int index = ptr - str;
    
    return index;
}

/*
       0    1    2    3      indexes
s -> ['-']['3']['5']['\0']   
     |    |    |    |        
     s    s+1  s+2  s+3      pointers
*/

int isNumber(const char *s) {
    if (*s == '-') s++;
    
    if (*s == '\0') return 0;
    
    while (*s != '\0') {
        if (!isdigit(*s)) return 0;
        s++;
    }
    
    return 1;
}

/*
       i         i'        j'        j
       0    1    2    3    4    5    6    7
s -> [' '][' ']['a']['l']['a'][' '][' ']['\0']
       k
*/

char *trim(char *s) {
    int i = 0;
    int j = strlen(s) - 1;
    int k = 0;
    
    while (isspace(s[i]) && i <= j) i++;

    while (isspace(s[j]) && i <= j) j--;
    
    while (i <= j) s[k++] = s[i++];
    
    s[k] = '\0';
    
    return s;  
}

char *identity(const char *name, const char *surname) {
    if (!surname) surname = "";
	if (!name) name = "";

    size_t size = strlen(name) + 1 + strlen(surname) + 1;
    char *full_name = malloc(size);
    if (!full_name) return NULL;
    
    strcpy(full_name, name);
    strcat(full_name, " ");
    strcat(full_name, surname);
    
    return full_name;
}

char *login(const char *name, const char *surname) {
	if (!surname) surname = "";
	if (!name) name = "";

	char first = name[0] ? name[0] : '\0';

	size_t max_len = 31;
	size_t surname_len = strlen(surname);
	if (surname_len > max_len - 1) surname_len = max_len - 1;
	
	char *result = malloc(surname_len + 2);
	if (!result) return NULL;

	if (first) {
        result[0] = first;
	} else {
        result[0] = '\0';
	}
        
    strncpy(result + 1, surname, surname_len);
    result[surname_len + 1] = '\0';

    return result;
}

int main(int argc, char *argv[]) {
    printf("strings.c\n\n");

//  indexOf test

    char str[] = "99$ ";
    int c = '$';
    
    printf("indexOf(\"%s\", '%c') = %d\n", str, c, indexOf(str, c));
    
    printf("\n");
    
//  isNumber test

    char s[] = "-35";
    
    if (isNumber(s)) {
        printf("Napis \"%s\" reprezentuje liczbe.\n", s);
    }else {
        printf("Napis \"%s\" nie reprezentuje liczby.\n", s);        
    }   
    
    printf("\n");
    
//  trim test

    char s2[] = "  ala  ";
    
    printf("%s$\n", s2);     
    printf("%s$\n", trim(s2));     
    
    printf("\n");

//	identity test
    
    char s_name[] = "Kacper";
    char s_surname[] = "Dusza";
    
    char *result = identity(s_name, s_surname);
	printf("Identity: %s\n", result);

	free(result);

	printf("\n");

//	login test
    
    char *log = login(s_name, s_surname);
    printf("Login: %s\n", log);
    free(log);
    
	return 0;
}
