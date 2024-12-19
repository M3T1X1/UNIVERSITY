# Zadanie 8 - Całkowanie numeryczne - metoda prostokątów.
# Obliczyć wartość całki ∫(od 1 do 4) (0.06 * x^2 + 2) dx

# Funkcja, którą chcemy całkować
def f(x):
    return 0.06 * x**2 + 2

# Zakres całkowania
a = 1
b = 4
n = 10

# Szerokosc przedzialu
h = (b - a) / n

# Metoda prostokątów
def prostokat(a, n, func):
    calka = 0
    for i in range(n):
        x_i = a + i * h  # Punkt na lewym końcu prostokąta
        calka += func(x_i)  # Dodanie wartości funkcji w punkcie
    return calka * h  # Mnożenie przez szerokość przedziału

# Obliczenie wartości całki
wynik= prostokat(a,n,f)

f = max(abs(prostokat(a,n,f)),abs(prostokat(a,n,f)))

def wzof(a,b,h,f):
    wynik = ((b-a)*h**4/180) * f
    return wynik

wynik_wzor = wzof(a,b,h,f)


# Wyświetlenie wyniku
print(f"Wartość całki wynosi: {wynik:.5f}")
print(f"Wartość całki wynosi: {wynik_wzor:.5f}")