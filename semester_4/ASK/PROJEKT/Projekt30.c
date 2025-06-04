#include <stdio.h>

int main() {
    float fahrenheit, celsius;
    int result;

    while (1) {
        printf("F = ");
        result = scanf("%f", &fahrenheit);

        // Sprawdzenie poprawności wejścia
        if (result != 1) {
            printf("Niepoprawna wartość. Spróbuj ponownie.\n");

            // Wyczyść bufor wejściowy
            int c;
            while ((c = getchar()) != '\n' && c != EOF);

            continue;
        }

        // Konwersja: C = (F - 32) * 5 / 9
        celsius = (fahrenheit - 32.0f) * 5.0f / 9.0f;
        printf("C = %.2f\n", celsius);
        break;
    }

    return 0;
}