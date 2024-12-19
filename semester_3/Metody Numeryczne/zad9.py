# Zadanie 9 - Całkowanie numeryczne - metoda parabol.
# Obliczyć wartość całki ∫(od -3 do 1) [sin(x) * e^(-3x) + x^3] dx oraz jej błąd maksymalny
import math
import sympy as sp

#wzor B=((b-a)*h^4)/180 * max.f(4)


# Funkcja podcałkowa
def f(x):
    return math.sin(x) * math.exp(-3 * x) + x**3

# Zakres całkowania
a = -3  # dolna granica
b = 1   # górna granica
n = 10  # liczba przedziałów (musi być parzysta dla metody Simpsona)

# Sprawdzenie, czy liczba przedziałów jest parzysta
if n % 2 != 0:
    n += 1

h = (b - a) / n
x = sp.Symbol('x')
# Metoda Simpsona
def simpson(a, b, n, func):
    integral = func(a) + func(b)  # Wartości funkcji na krańcach
    for i in range(1, n):
        x_i = a + i * h
        if i % 2 == 0:  # Węzły parzyste
            integral += 2 * func(x_i)
        else:  # Węzły nieparzyste
            integral += 4 * func(x_i)
    return integral * (h / 3)

# Obliczenie wartości całki
wynik = simpson(a, b, n, f)

#f = max(abs(simpson(a,b,n,f)),abs(simpson(a,b,n,f)))
def f4(x):
    wartoscF = math.sin(x)*sp.exp(-3*x) + x**3
    wartoscF4 = sp.diff(wartoscF, x,4)
    return wartoscF4.subs(x,wartoscF)

def bladMax(a,b,h,f):
  wynik = ((b-a)*h**4/180) * f
  return wynik

f__a = f4(a)
f__b = f4(b)

bladMaksymalny = bladMax(a, b, n, wynik)

print(f"Wartość całki wynosi: {wynik:.5f}")
print(f"Blad maksymalny: {bladMaksymalny:.5f}")