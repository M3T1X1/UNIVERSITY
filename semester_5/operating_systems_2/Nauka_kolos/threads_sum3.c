#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

/*
gcc threads-sum.c -o threads-sum -lpthread -Wall
*/

int *array;

void *add(void *arg) {
    int a = ((int*)arg)[0];
    int b = ((int*)arg)[1];

	long long *result = malloc(sizeof(long long));
	
	if (result == NULL) return NULL;
	
	long long sum2 = 0;
	
	for (int i = a; i <= b; i++) {
		sum2 = sum2 + array[i];
	}
	
	*result = sum2;

    // complete

    return result;
}

int main() {
    const int N = 10*1024*1024/sizeof(int);

    // create int array of size N
    
    int *arr = malloc(N * sizeof(int));
    int arr[N];
    
    // fill array with numbers 1..N
    
    for (int i = 0; i < N; i++) {
    	arr[i] = i + 1;
	}
    
    // make array accessible to threads

	array = arr;

    // calculate sum1 sequentially
    
    long long sum1 = 0;
    
    clock_t start_time1 = clock();
    
    for (int i = 0; i < N; i++) {
    	sum1 = sum1 + arr[i];
	}

	clock_t end_time1 = clock();
	
	double time1 = (double) (end_time1 - start_time1) / CLOCKS_PER_SEC;

    printf("sum1 = %lld\n", sum1);

    int m = (0 + N-1) / 2; // calculate middle index

    int left[2]  = {0, m};		// fill with indexes of left sub-array
    int right[2] = {m + 1, N - 1};  // fill with indexes of right sub-array

	clock_t start_time2 = clock();

    pthread_t thread1;
    pthread_t thread2;

    if (pthread_create(&thread1, NULL, add, left)) {
        printf("Error: Could not create thread.\n");
        abort();
    }

    if (pthread_create(&thread2, NULL, add, right)) {
        printf("Error: Could not create thread.\n");
        abort();
    }

    long long *left_sum;
    long long *right_sum;

    if (pthread_join(thread1, (void**)&left_sum)) {
        printf("Error: Could not join thread.\n");
        exit(1);
    }

    if (pthread_join(thread2, (void**)&right_sum)) {
        printf("Error: Could not join thread.\n");
        exit(1);
    }

    if (left_sum == NULL || right_sum == NULL) {
        printf("Thread failed to allocate memory.\n");
        exit(1);
    }

    long long sum2 = *left_sum + *right_sum;// add sums of left and right sub-arrays

	clock_t end_time2 = clock();
	
	double time2 = (double) (end_time2 - start_time2) / CLOCKS_PER_SEC;

    printf("sum2 = %lld\n\n", sum2);

	printf("time 1 = %f\n\n", time1);
	printf("time 2 = %f\n\n", time2);

    free(left_sum);
    free(right_sum);

    printf("left[2]  = {%d, %d}\n", left[0], left[1]);
    printf("right[2] = {%d, %d}\n", right[0], right[1]);

    return 0;
}
