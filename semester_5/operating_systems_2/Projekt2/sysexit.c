#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

//gcc sysexit.c -o sysexit

int main(void) {
    const pid_t pid = fork();

    if (pid < 0) {
        perror("fork failed");

        return 1;
    }
    if (pid == 0) {  // Child
        printf("Child (PID %d)\n", getpid());

        _exit(42);
    } else {  // Parent
        printf("Parent (PID %d).\n", getpid());

        int status;

        waitpid(pid, &status, 0);

        printf("Child after _exit(42) (PID %d).\n", getpid());
        printf("Exit status : %d\n", WEXITSTATUS(status));

        return 0;
    }
}
