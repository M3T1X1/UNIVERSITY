import numpy as np
import matplotlib.pyplot as plt
import sympy as sp

# Węzły aproksymacji
points = [(0, 4), (3, 5), (6, 4), (9, 1), (12, 2)]
x_values, y_values = zip(*points)

# Tworzenie wielomianu Newtona
x = sp.Symbol('x')

# Obliczanie różnic dzielonych
def newton_interpolation(x_values, y_values):
    n = len(x_values)
    coeffs = np.copy(y_values)
    for j in range(1, n):
        for i in range(n - 1, j - 1, -1):
            coeffs[i] = (coeffs[i] - coeffs[i - 1]) / (x_values[i] - x_values[i - j])
    return coeffs

# Różnice dzielone dla interpolacji Newtona
coefficients = newton_interpolation(x_values, y_values)

# Tworzenie wielomianu Newtona
newton_polynomial = coefficients[0]
for i in range(1, len(coefficients)):
    term = coefficients[i]
    for j in range(i):
        term *= (x - x_values[j])
    newton_polynomial += term

# Wyświetlanie wyników
print("Wielomian Newtona:")
print(sp.expand(newton_polynomial))

# Wykres
x_plot = np.linspace(min(x_values) - 1, max(x_values) + 1, 500)
y_plot = np.array([float(newton_polynomial.subs(x, xi)) for xi in x_plot])

plt.scatter(x_values, y_values, color='red', label='Węzły aproksymacji')
plt.plot(x_plot, y_plot, label='Interpolacja Newtona', color='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interpolacja Newtona')
plt.legend()
plt.grid()
plt.show()
