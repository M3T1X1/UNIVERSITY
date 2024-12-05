import numpy as np
import matplotlib.pyplot as plt
import sympy as sp

# Węzły aproksymacji
points = [(0, 4), (3, 5), (6, 4), (9, 1), (12, 2)]
x_values, y_values = zip(*points)

# Tworzenie wielomianu Lagrange'a
x = sp.Symbol('x')
lagrange_polynomial = 0
for i in range(len(points)):
    xi, yi = points[i]
    term = yi * np.prod([(x - x_values[j]) / (xi - x_values[j]) for j in range(len(points)) if i != j])
    lagrange_polynomial += term

# Wyświetlanie wyników
print("Wielomian Lagrange'a:")
print(sp.expand(lagrange_polynomial))

# Wykres
x_plot = np.linspace(min(x_values) - 1, max(x_values) + 1, 500)
y_plot = np.array([float(lagrange_polynomial.subs(x, xi)) for xi in x_plot])

plt.scatter(x_values, y_values, color='red', label='Węzły aproksymacji')
plt.plot(x_plot, y_plot, label='Interpolacja Lagrange\'a', color='blue')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interpolacja Lagrange\'a')
plt.legend()
plt.grid()
plt.show()
