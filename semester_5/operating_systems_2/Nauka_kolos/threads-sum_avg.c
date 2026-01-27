#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

/*
gcc threads-sum.c -o threads-sum -lpthread -Wall
*/

int *array;

int losuj(int a, int b) {
    return a + rand() % (b - a + 1); // [a, b]
}

void *min(void *arg) {
	int a = ((int*)arg)[0];
    int b = ((int*)arg)[1];
    
    int *min = malloc(sizeof(int));
    
    if (min == NULL) return NULL;
    
    int curr_min = array[a];
    
    for (int i = a; i <= b; i++) {
    	if (array[i] < curr_min) curr_min = array[i];
	}
	
	*min = curr_min;
	
	return min;
}

void *average(void *arg) {
	int a = ((int*)arg)[0];
    int b = ((int*)arg)[1];
    
    double *average = malloc(sizeof(double));
    
    if (average == NULL) return NULL;
    
    long long sum = 0;
    
    for (int i = a; i <= b; i++) {
    	sum = sum + array[i];
	}
	
	int count = b - a + 1;
	
	*average = (double) sum / count;
	
	return average;
	
}

int main() {
    const int N = 10 * 1024 * 1024 / sizeof(int);

    // create int array of size N
    
    int *arr = malloc(N * sizeof(int));

    // fill array with numbers 1..N
    
	printf("[-(RAND_MAX)/2-1, RAND_MAX/2] = [%d, %d]\n\n", -(RAND_MAX)/2-1, RAND_MAX/2);

    time_t t;
    srand((unsigned) time(&t));
    
    array = arr;
    
    for (int i = 0; i < N; i++) {
    	arr[i] = losuj(-RAND_MAX/2-1, RAND_MAX/2);
	}
	
	clock_t start_time_1 = clock();

    int min1 = arr[0];
	double avg1 = 0;
	long long sum = 0;
	
    for (int i = 0; i < N; i++) {
    	if(arr[i] < min1) min1 = arr[i];
    	sum = sum + arr[i];
	}    
	
	avg1 = (double) sum / N;
	
	clock_t end_time_1 = clock();
	
    printf("min1 = %d\n", min1);
    printf("avg1 = %f\n", avg1);

    clock_t start_time_2 = clock();

    pthread_t thread1;
    pthread_t thread2;
    
    int full[2] = {0, N-1};
    
    if (pthread_create(&thread1, NULL, min, &full)) {
        printf("Error: Could not create thread min.\n");
        abort();
    }

    if (pthread_create(&thread2, NULL, average, &full)) {
        printf("Error: Could not create thread avg.\n");
        abort();
    }

    int *min2;
    double *avg2;

    if (pthread_join(thread1, (void**)&min2)) {
        printf("Error: Could not join thread min2.\n");
        exit(1);
    }

    if (pthread_join(thread2, (void**)&avg2)) {
        printf("Error: Could not join thread avg2.\n");
        exit(1);
    }

    if (min2 == NULL || avg2 == NULL) {
        printf("Thread failed to allocate memory.\n");
        exit(1);
    }
    
    clock_t end_time_2 = clock();


    printf("min2 = %d\n", *min2);
	printf("avg2 = %f\n\n", *avg2);
	
	double elapsed_time = (double)(end_time_1 - start_time_1) / CLOCKS_PER_SEC;
    double elapsed_time2 = (double)(end_time_2 - start_time_2) / CLOCKS_PER_SEC;
	
	printf("time_1 = %f\n", elapsed_time);
	printf("time_2 = %f\n\n", elapsed_time2);
	
    free(min2);
    free(avg2);

    return 0;
}
