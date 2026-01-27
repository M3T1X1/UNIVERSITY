#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

/*
gcc tsum.c -o tsum -Wall
*/
int losuj(int a, int b) {
	return a + rand() % (b - a + 1);
}

unsigned char *array;

void *add(void *arg) {
    int a = ((int*)arg)[0];
    int b = ((int*)arg)[1];
    
    // complete
    
    long long *result = malloc(sizeof(long long));
    long long sum2 = 0;
    
    for(int i = a; i <= b; i++) {
    	sum2 = sum2 + array[i];
	}
	
	*result = sum2;
    
    return result;
}

int main() {
    // create array
    const int N = 10*1024*1024;
    
    unsigned char *arr = malloc(N * sizeof(unsigned char));

    time_t t;
    srand((unsigned) time(&t));

    // fill array
    
    for (int i = 0; i < N; i++) {
    	arr[i] = losuj(0,255);
	}
    
    clock_t start_time = clock();
    
    long long sum1 = 0;
    
    // sum array
    
    for(int i = 0; i < N; i++) {
    	sum1 = sum1 + arr[i];
	}
	
	array = arr;

    clock_t end_time = clock();

    printf("sum1 = %lld\n", sum1);


    int m = (0 + N - 1) / 2; // calculate middle index

    int left[2]  = {0, m}; // fill with indexes of left sub-array
    int right[2] = {m + 1, N - 1}; // fill with indexes of right sub-array

    clock_t start_time2 = clock();

    // create threads

    long long *left_sum;
    long long *right_sum;

    // join threads
    
    pthread_t thread1;
    pthread_t thread2;
    
    if(pthread_create(&thread1, NULL, add, left)) {
    	perror("Error creating t1");
    	abort();
	}
	
	if(pthread_create(&thread2, NULL, add, right)) {
    	perror("Error creating t2");
    	abort();
	}
	
	if(pthread_join(thread1, (void**)&left_sum)) {
		perror("Error joining t1");
		abort();
	}
	
	if(pthread_join(thread2, (void**)&right_sum)) {
		perror("Error joining t2");
		abort();
	}
    
    if (left_sum == NULL || right_sum == NULL) {
        printf("Thread failed to allocate memory.\n");
        exit(1);
    }

    // sum results returned by threads
    
    long long sum2 = *left_sum + *right_sum;

    clock_t end_time2 = clock();

    printf("sum2 = %lld\n\n", sum2);

    free(array);
    free(left_sum);
    free(right_sum);

    double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
    double elapsed_time2 = (double)(end_time2 - start_time2) / CLOCKS_PER_SEC;

    printf("sum1 time = %f\n", elapsed_time);
    printf("sum2 time = %f\n", elapsed_time2);

    return 0;
}