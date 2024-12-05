import numpy as np
import matplotlib.pyplot as plt
import sympy as sp

# Węzły aproksymacji
points = [(0, 4), (3, 5), (6, 4), (9, 1), (12, 2)]
x_values, y_values = zip(*points)

# Stopień wielomianu aproksymacyjnego
m = 3

# Tworzenie macierzy Vandermonde'a
X = np.vander(x_values, m + 1, increasing=True)

# Oblicz współczynniki wielomianu (metoda najmniejszych kwadratów)
coefficients = np.linalg.lstsq(X, y_values, rcond=None)[0]

# Tworzenie wielomianu w formie symbolicznej
x = sp.Symbol('x')
polynomial = sum(c * x**i for i, c in enumerate(coefficients))

# Wyświetlanie wyników
print("Współczynniki wielomianu aproksymacyjnego:")
for i, c in enumerate(coefficients):
    print(f"a{i} = {c:.4f}")
print("\nWielomian aproksymacyjny:")
print(sp.expand(polynomial))


# Wykres
x_plot = np.linspace(min(x_values) - 1, max(x_values) + 1, 500)
y_plot = sum(c * x_plot**i for i, c in enumerate(coefficients))
plt.scatter(x_values, y_values, color='red', label='Węzły aproksymacji')
plt.plot(x_plot, y_plot, label=f'Aproksymacja stopnia {m}', color='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Wielomian aproksymacyjny')
plt.legend()
plt.grid()
plt.show()