import numpy as np
from matplotlib import pyplot as plt


def triangular(x, a1, a2, a3):
    if a1 <= x <= a2: return (x - a1) / (a2 - a1)
    if x == a2: return 1.0
    if a2 <= x <= a3: return (a3 - x) / (a3 - a2)
    return 0.0


def trapezoidal(x, a1, a2, a3, a4):
    if x <= a1: return 0
    if a1 <= x <= a2: return (x - a1) / (a2 - a1)
    if a2 <= x <= a3: return 1
    if a3 <= x <= a4: return (a4 - x) / (a4 - a3)
    if a4 <= x: return 0


print(trapezoidal(5, 0, 1, 2, 3))

test_data = np.arange(-0.5, 3.5, 0.1)
y = []

for t in test_data:
    print(f"Dla x = {t} y = {trapezoidal(t, 0, 1, 2, 3)} ")
    y.append(trapezoidal(t, 0, 1, 2, 3))
    print()

plt.plot(test_data, y)
plt.show()

