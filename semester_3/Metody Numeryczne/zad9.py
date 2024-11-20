# Zadanie 9 - Całkowanie numeryczne - metoda parabol.
# Obliczyć wartość całki ∫(od -3 do 1) [sin(x) * e^(-3x) + x^3] dx oraz jej błąd maksymalny
import math

# Funkcja podcałkowa
def f(x):
    return math.sin(x) * math.exp(-3 * x) + x**3

# Zakres całkowania
a = -3  # dolna granica
b = 1   # górna granica
n = 100  # liczba przedziałów (musi być parzysta dla metody Simpsona)

# Sprawdzenie, czy liczba przedziałów jest parzysta
if n % 2 != 0:
    n += 1  # Wymuszamy parzystość

# Szerokość przedziału
h = (b - a) / n

# Metoda Simpsona
def simpson_integration(a, b, n, func):
    integral = func(a) + func(b)  # Wartości funkcji na krańcach
    for i in range(1, n):
        x_i = a + i * h
        if i % 2 == 0:  # Węzły parzyste
            integral += 2 * func(x_i)
        else:  # Węzły nieparzyste
            integral += 4 * func(x_i)
    return integral * (h / 3)

# Obliczenie wartości całki
result = simpson_integration(a, b, n, f)

# Wyznaczenie błędu maksymalnego
# Obliczamy wartość maksymalnej czwartej pochodnej na przedziale
def f_derivative_4(x):
    return math.sin(x) * (-3)**4 * math.exp(-3 * x)  # Przybliżenie wyłącznie dla składnika wykładniczego

# Przybliżony błąd maksymalny
M4 = max([abs(f_derivative_4(x)) for x in [a, b]])  # Maksymalna wartość pochodnej w krańcach
error_bound = (b - a) * h**4 * M4 / 180

# Wyświetlenie wyników
print(f"Wartość całki wynosi: {result:.5f}")
print(f"Przybliżony błąd maksymalny wynosi: {error_bound:.5e}")