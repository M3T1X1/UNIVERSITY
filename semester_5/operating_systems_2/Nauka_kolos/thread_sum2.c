#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

/*
gcc thread-sum.c -o thread-sum -lpthread -Wall
*/

typedef struct {
	int *array;
	int size;
} ThreadArgs;

void *sum(void *arg) {
    ThreadArgs *args = (ThreadArgs *)arg;
    
    int *result = malloc(sizeof(int));
    
    if (result == NULL) return NULL;
    
    int suma = 0;
    
    for (int i = 0; i < args->size; i++) {
    	suma = suma + args->array[i];
	}
	
	*result = suma;

    return result;
}

int main() {
    int N = 10;
    
    int arr[N];
    
    for (int i = 0; i < N; i++) {
    	arr[i] = i + 1; 
	}
	
	ThreadArgs args;
	
	args.array = arr;
	args.size = N;

    pthread_t thread;

    if (pthread_create(&thread, NULL, sum, &args)) {
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