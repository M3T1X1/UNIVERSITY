#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

/*
gcc thread-sum.c -o thread-sum -lpthread -Wall
*/

typedef struct {
	int *array;
	int a;
	int b;
}ThreadArgs;

void *sum(void *arg) {
	ThreadArgs *args = (ThreadArgs *) arg;
	
	int *result = malloc(sizeof(int));
	
	int suma = 0;
	
	for (int i = args->a; i <= args->b; i++) {
		suma = suma + args->array[i];
	}
	
	*result = suma;
	
    return result;
}

int main() {
    const int N = 10;
    
    int arr[N];
    
    for (int i = 0; i < N; i++) {
    	arr[i] = i + 1;
	}
	
	int sum1 = 0;
	
	for (int i = 0; i < N; i++) {
		sum1 = sum1 + arr[i];
	}
	
	int m = (0 + N-1)/2;
	
	ThreadArgs arg1 = {.array = arr, .a = 0, .b = m}; //left
	ThreadArgs arg2 = {.array = arr, .a = m+1, .b = N-1}; //right
	    
    pthread_t thread1;
    pthread_t thread2;

    if (pthread_create(&thread1, NULL, sum, &arg1)) {
       printf("Error: Could not create thread 1.\n");
       abort();
    }
    
     if (pthread_create(&thread2, NULL, sum, &arg2)) {
       printf("Error: Could not create thread 2.\n");
       abort();
    }

    int *left_res;
    int *right_res;

    if (pthread_join(thread1, (void**)&left_res)) {
        printf("Error: Could not join thread 1.\n");
        exit(1);
    }
    
    if (pthread_join(thread2, (void**)&right_res)) {
        printf("Error: Could not join thread 2.\n");
        exit(1);
    }

    if (sum == NULL) {
        printf("Thread failed to allocate memory.\n");
        exit(1);
    }
    
    int sum2 = *left_res + *right_res;

    printf("sum1 = %d\n", sum1);
    printf("sum2 = %d\n", sum2);

    free(left_res);
	free(right_res);
	
    return 0;
}