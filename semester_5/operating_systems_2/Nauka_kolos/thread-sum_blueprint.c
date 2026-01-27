#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

/*
gcc thread-sum.c -o thread-sum -lpthread -Wall
*/

int *array;

void *sum(void *arg) {
    int n = *(int*)arg;

    int *result = malloc(sizeof(int));

    if (result == NULL) return NULL;

    int sum = 0;

    for (int i = 0; i < n; i++) {
        sum = sum + array[i];
    }

    *result = sum;

    return result;
}

int main() {
    int N = 10;

    int arr[N];

    array = arr;

    for (int i = 0; i < N; i++) {
        arr[i] = i + 1;
    }

    pthread_t thread;

    if (pthread_create(&thread, NULL, sum, &N)) {
       printf("Error: Could not create thread.\n");
       abort();
    }

    int *sum;

    if (pthread_join(thread, (void**)&sum)) {
        printf("Error: Could not join thread.\n");
        exit(1);
    }

    if (sum == NULL) {
        printf("Thread failed to allocate memory.\n");
        exit(1);
    }

    printf("sum = %d\n", *sum);

    free(sum);

    return 0;
}