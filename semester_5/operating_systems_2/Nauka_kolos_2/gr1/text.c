#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 1 + 1) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);

        return 1;
    }
    
    // complete

	FILE *fp = fopen(argv[1], "rb");
	
	if (!fp) return -1;

	int c = 0;
	int is_text = 1;
	
	while((c = fgetc(fp) != EOF)) {
		if (c > 127) {
			is_text = 0;
			break;
		}
	}

	if (is_text == 0) {
		printf("Nie jest");
	}
	else{
		printf("Jest");
	}
    
    return 0;
}