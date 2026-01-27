#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

/*
gcc pipe.c -o pipe -Wall
*/

int main () {
    int pipefd[2];
    
    if (pipe(pipefd) == -1) {
        perror("blad tworzenia potoku");
        exit(1);
    }
    
    pid_t pid1 = fork();
    
    if (pid1 == -1) {
        perror("Blad tworzenia dziecka 1");
        exit(1);
    }
    
    if (pid1 == 0) { // child 1
        close(pipefd[0]);
        
        if (write(pipefd[1], "Czesc", 6) == -1) {
            perror("Blad zapisu do potoku");
            exit(1);
        }
        
        exit(1);
    }
    
    pid_t pid2 = fork();
    
    if (pid2 == -1) {
        perror("Blad tworzenia dziecka 2");
        exit(1);
    }
    
    if (pid2 == 0) {
        close(pipefd[0]);
        
        if (write(pipefd[1], " cwelu", 7) == -1) {
            perror("Blad zapisu do potoku");
            exit(1);
        }
        
        exit(0);
    }
    
    close(pipefd[1]);
    
    char buffer[20];
    
    ssize_t bytes;
    
    while((bytes = read(pipefd[0], buffer, sizeof(buffer) - 1)) > 0) {
        printf("%s", buffer);
    }
    
    wait(NULL);
    wait(NULL);
    

    return 0;
}