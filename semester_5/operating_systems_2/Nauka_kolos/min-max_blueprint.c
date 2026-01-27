#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

/*
gcc min-max.c -o min-max -lpthread -Wall
*/

int losuj(int a, int b) {
    return a + rand() % (b - a + 1); // [a, b]
}

int *array;

void *min_max(void *arg) {
    int i = ((int*)arg)[0];
    int j = ((int*)arg)[1];

    int *min_max = malloc(2 * sizeof(int));

    // uzupelnic



    return min_max;
}

int main() {
    const int N = 10*1024*1024 / sizeof(int);

    // utworzyc array



    printf("[-(RAND_MAX+1)/2, RAND_MAX/2] = [%d, %d]\n\n", -(RAND_MAX+1)/2, RAND_MAX/2);

    time_t t;
    srand((unsigned) time(&t));

    // wypelnic array



    clock_t start_time = clock();

    // wyznaczyc min1 i max1



    clock_t end_time = clock();

    printf("min1 = %d\n", min);
    printf("max1 = %d\n", max);

    printf("\n");

    clock_t start_time2 = clock();

    // uzupelnic tworzenie watkow

    

    void *min_max_left;
    void *min_max_right;

    if (pthread_join(thread1, &min_max_left)) {
        printf("Blad przy konczeniu watku.\n");
        exit(1);
    }

    if (pthread_join(thread2, &min_max_right)) {
        printf("Blad przy konczeniu watku.\n");
        exit(1);
    }

    // uzupelnic agregacje wynikow



    clock_t end_time2 = clock();

    free(min_max_left);
    free(min_max_right);

    printf("min2 = %d\n", min2);
    printf("max2 = %d\n", max2);

    printf("\n");

    double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
    double elapsed_time2 = (double)(end_time2 - start_time2) / CLOCKS_PER_SEC;

    printf("min1 max1 time = %f\n", elapsed_time);
    printf("min2 max2 time = %f\n", elapsed_time2);

    free(array);

    return 0;
}
