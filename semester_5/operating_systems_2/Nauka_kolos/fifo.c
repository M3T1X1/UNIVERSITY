#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

int main() {
	if (mkfifo("/fifo", 0600) == -1) {
		if (errno != EEXIST) {
			perror("Error creating FIFO");
			exit(1);
		}
	}
	
	pid_t pid = fork(); 
	
	if (pid == -1) {
		perror("Error creating process");
		exit(0);
	}
	
	if(pid == 0 ) { // child
		int fifofd = open("fifo", O_WRONLY);		
		
		char str[6] = "Witam";
		
		if (fifofd == -1) {
			perror("Erorr opening FIFO");
			exit(1);
		}
		
		if (write(fifofd, str, sizeof(str) + 1) == -1) {
			perror("Error writing to FIFO");
		}
		
		close(fifofd);
		exit(0);
	}
	
	if (pid > 0) {
		int fifofd = open("fifo", O_RDONLY);
		
		if (fifofd == -1) {
			perror("Error opening from FIFO");
			exit(1);
		}
		
		char buff[10];
		
		if (read(fifofd, buff, sizeof(buff) + 1) == -1) {
			perror("Error reading from fifo");
			exit(1);
		}
		
		print("Wartosc buffora: %s", buff);
	}
		
	
	return 0;
}