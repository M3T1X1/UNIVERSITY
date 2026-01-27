#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 1 + 1) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);

        return 1;
    }
    
    const char *name = argv[1];
    
    //complete
    
    FILE *fp = fopen(argv[1],"r");
    
    if (!fp) return -1;
    
    int c;
    int sum = 0;
    
    while(fscanf(fp, "%d", &c) == 1) {
    	sum = sum + c;
	}
	
	printf("%d", sum);
    
	return 0;
}
	