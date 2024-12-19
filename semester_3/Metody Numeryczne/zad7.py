# Obliczyć wartość całki ∫(od 0 do 1) sqrt(1 + x) dx z krokiem h = 1/3
import math
#from sympy import symbols, diff, arg
import sympy as sp
# Funkcja, którą chcemy całkować
def f(x):
    return math.sqrt(1 + x)

x = sp.symbols('x')
# Zakres całkowania
a = 0  # dolna granica
b = 1  # górna granica
h = 1 / 3  # krok całkowania

# Liczba przedziałów
n = int((b - a) / h)

# Zastosowanie metody trapezów
def trapez(a, b, h, func):
    # Obliczenie wartości funkcji na końcach przedziału
    integral = func(a) + func(b)

    # Suma wartości funkcji w węzłach wewnętrznych
    for i in range(1, n):
        x_i = a + i * h
        integral += 2 * func(x_i)

    # Mnożenie przez krok podzielony przez 2
    integral *= (h / 2)

    return integral

result = trapez(a, b, h, f)

f2=sp.diff(f,x,2)

def bladMax(a,b,h,func):
    blad = abs(((h**2)/12)*(b-a))*max(abs(func.subs(h,a)), abs(func.subs(h,b)))
    return blad

maxBlad = bladMax(a,b,h,f2)


print(f"Wartość całki wynosi: {result:.5f}")
print(f"Wartość całki wynosi: {maxBlad:.5f}")