# Zadanie 8 - Całkowanie numeryczne - metoda prostokątów.
# Obliczyć wartość całki ∫(od 1 do 4) (0.06 * x^2 + 2) dx

# Funkcja, którą chcemy całkować
def f(x):
    return 0.06 * x**2 + 2

# Zakres całkowania
a = 1  # dolna granica
b = 4  # górna granica
n = 100  # liczba przedziałów (im więcej, tym większa dokładność)

# Obliczenie szerokości każdego przedziału
h = (b - a) / n

# Metoda prostokątów (wersja z lewymi końcami przedziałów)
def rectangle_integration(a, b, n, func):
    integral = 0
    for i in range(n):
        x_i = a + i * h  # Punkt na lewym końcu prostokąta
        integral += func(x_i)  # Dodanie wartości funkcji w punkcie
    return integral * h  # Mnożenie przez szerokość przedziału

# Obliczenie wartości całki
result = rectangle_integration(a, b, n, f)

# Wyświetlenie wyniku
print(f"Wartość całki wynosi: {result:.5f}")