# Zadanie 7 - Całkowanie numeryczne - metoda trapezów.
# Obliczyć wartość całki ∫(od 0 do 1) sqrt(1 + x) dx z krokiem h = 1/3
import math

# Funkcja, którą chcemy całkować
def f(x):
    return math.sqrt(1 + x)

# Zakres całkowania
a = 0  # dolna granica
b = 1  # górna granica
h = 1 / 3  # krok całkowania

# Liczba przedziałów
n = int((b - a) / h)

# Zastosowanie metody trapezów
def trapezoidal_integration(a, b, h, func):
    # Obliczenie wartości funkcji na końcach przedziału
    integral = func(a) + func(b)

    # Suma wartości funkcji w węzłach wewnętrznych
    for i in range(1, n):
        x_i = a + i * h
        integral += 2 * func(x_i)

    # Mnożenie przez krok podzielony przez 2
    integral *= (h / 2)

    return integral

# Obliczenie wartości całki
result = trapezoidal_integration(a, b, h, f)

# Wyświetlenie wyniku
print(f"Wartość całki wynosi: {result:.5f}")