#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

//gcc sysexit_new.c -o sysexit_new

//./sysexit_new 1    → BEZ _exit()
//./sysexit_new 2    → Z _exit()

int main(const int argc, char *argv[]) {
    int tryb_programu = 2;

    if (argc > 1) {
        tryb_programu = atoi(argv[1]);
        if (tryb_programu == 1) {
            printf("TRYB BEZ _exit()\n");
        } else {
            printf("TRYB Z _exit()\n");
        }
    } else {
        printf("TRYB Z _exit()\n");
    }

    const pid_t pid = fork();

    if (pid < 0) {
        perror("fork failed");
        return 1;
    }

    if (pid == 0) {  // DZIECKO
        printf("Child (PID %d)\n", getpid());

        if (tryb_programu == 2) {
            printf("Child: _exit(42)\n");
            _exit(42);
        } else {
            printf("Child: BEZ _exit()\n");

            while(1) {
                sleep(1);
            }

            /*
            while(1) sleep(1) SYMULUJE "brak _exit()" jest to jedyny sposób pokazania, że dziecko musi się jawnie zakończyć _exit().
            Inaczej program "działa" przez ukryte exit(0) na końcu main().
            */
        }

    } else {  // RODZIC
        printf("Parent (PID %d) czeka na dziecko...\n", getpid());

        int status;

        waitpid(pid, &status, 0);

        printf("Child ended (PID %d) \n", getpid());
        printf("Exit status : %d\n", WEXITSTATUS(status));

        return 0;
    }
}
