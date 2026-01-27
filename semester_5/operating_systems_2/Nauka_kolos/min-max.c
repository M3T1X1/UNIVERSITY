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
    int a = ((int*)arg)[0];
    int b = ((int*)arg)[1];

    int *min_max = malloc(2 * sizeof(int));

    // uzupelnic

	if (min_max == NULL) return NULL;
	
	int min = 0;
	int max = 0;
	
	int min1 = array[a];
	int max1 = array[a];
	
	for(int i = a; i <= b; i++) {
		if(array[i] < min1) min1 = array[i];
		if(array[i] > max1) max1 = array[i];
	}
	
	min_max[0] = min1;
	min_max[1] = max1;

    return min_max;
}

int main() {
    const int N = 10*1024*1024 / sizeof(int);

    // utworzyc array

	int *arr = malloc(N * sizeof(int));


    printf("[-(RAND_MAX)/2-1, RAND_MAX/2] = [%d, %d]\n\n", -(RAND_MAX)/2-1, RAND_MAX/2);

    time_t t;
    srand((unsigned) time(&t));

    // wypelnic array

	array = arr;
	
	for (int i = 0; i < N; i++) {
		arr[i] = losuj(RAND_MAX/2-1, RAND_MAX/2);
	}

    clock_t start_time = clock();

    // wyznaczyc min1 i max1

	int min = arr[0];
	int max	= arr[0];

	for (int i = 0; i < N; i++) {
		if(arr[i] < min) min == arr[i];
		if(arr[i] > max) max == arr[i];
	}
	
    clock_t end_time = clock();

    printf("min1 = %d\n", min);
    printf("max1 = %d\n", max);

    printf("\n");

    clock_t start_time2 = clock();

    // uzupelnic tworzenie watkow

	int m = (0 + N-1) / 2;
	int left[2] = {0, m};
	int right[2] = {m+1, N-1};
	
	pthread_t thread1;
	pthread_t thread2;
	
	if (pthread_create(&thread1, NULL, min_max, &left)) {
		printf("Blad przy konczeniu watku. t1\n");
        abort();
	} 
	
	if (pthread_create(&thread2, NULL, min_max, &right)) {
		printf("Blad przy konczeniu watku. t1\n");
        abort();
	}

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
    
    int * left_res = (int *)min_max_left;
    int * right_res = (int *)min_max_right;
    
	int result = *left_res + *right_res;

    clock_t end_time2 = clock();

	int min2;
	int max2;

	if (left_res[0] < right_res[0]) min2 = left_res[0]; 
	else min2 = right_res[0];
	
	if (left_res[0] < right_res[0]) max2 = left_res[0]; 
	else max2 = right_res[0];

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
