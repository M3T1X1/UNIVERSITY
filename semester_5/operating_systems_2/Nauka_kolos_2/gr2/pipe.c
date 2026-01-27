#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

/*
gcc pipe.c -o pipe -Wall
*/

int draw(int a, int b) {
    return a + rand() % (b - a); // [a, b)
}

int main() {
    int pipefd[2];

    if (pipe(pipefd) == -1) {
        perror("Error creating pipe");
        exit(1);
    }

    pid_t pid = fork();

    if (pid < 0) {
        fprintf(stderr, "fork failed\n");

        return 1;
    }

    // complete
    
    if (pid == 0){
    	close(pipefd[0]);
		
		int ilosc = draw(5,6);
		int nums[ilosc];
		
		for(int i = 0; i < ilosc; i++) {
			nums[i] = i + 1;
		}
		
		if(write(pipefd[1], nums, sizeof(int)) == -1) {
			perror("Error writing");
			abort();
		}
		
		return 1;
	}
	
	if(pid > 0) {
		close(pipefd[1]);
		
		int buff[100];
		int sum = 0;
		int counter = 0;
		int odebrana_liczba;
		
		if(read(pipefd[0],&odebrana_liczba, sizeof(int)) == -1) {
			perror("Error reading");
			abort();
		}
		
		while(read(pipefd[0], &odebrana_liczba, sizeof(int)) > 0 ) {
			buff[counter] = odebrana_liczba;
			sum = sum + odebrana_liczba;
			counter++;
		}
		
		for(int i = 0; i < buff; i++) {
			sum = buff[i];
			counter++;
		}
		
		printf("Suma: %d",suma);
		printf("Counter: %d",counter);
	}
    
    

    return 0;
}