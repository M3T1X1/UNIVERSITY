#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>

/*
gcc fifo.c -o fifo -Wall
*/

int draw(int a, int b) {
    return a + rand() % (b - a + 1); // [a, b)
}

int main() {
    if (mkfifo("myfifo", 0600) == -1) {
        if (errno != EEXIST) {
            perror("Error creating FIFO");
            exit(1);
        }
    }

    pid_t pid = fork();

    if (pid < 0) {
        fprintf(stderr, "fork failed\n");

        return 1;
    }
    
    if (pid == 0) {
    	int fifofd = open("myfifo", O_WRONLY);
    	
    	if (fifofd == -1) {
    		perror("Error opening fifo for writing");
    		exit(1);
		}
		
		int ilosc = draw(5,6);
		int nums[ilosc];
		
		for(int i = 0; i < ilosc; i++) {
			nums[i] = i + 1;
		}
		
		if(write(fifofd, nums, sizeof(nums)) == -1) {
			perror("Error writing");
			exit(1);
		}
		
		exit(0);
	}
	
	if(pid > 0) {
		int fifofd = open("myfifo", O_RDONLY);
		
		int liczba;
		int sum = 0;
		int counter = 0;
		
		while(read(fifofd, &liczba, sizeof(liczba)) > 0) {
			sum = sum + liczba;
			counter++;
		}
		
		printf("Suma: %d", sum);
		printf("Coutner: %d", counter);
	}

    // complete    

    return 0;
}