import math


def falsi_method(f, a, b, epsilon=0.00001, max_iter=1000):

    x0, x1 = a, b

    for i in range(max_iter):
        f_x0 = f(x0)
        f_x1 = f(x1)

        if abs(f_x1) < epsilon:
            print(f"Znaleziono rozwiązanie: x = {x1}, po {i + 1} iteracjach")
            return x1

        x_new = x1 - f_x1 * (x1 - x0) / (f_x1 - f_x0)
        f_x_new = f(x_new)

        if f_x0 * f_x_new < 0:
            x1 = x_new
        elif f_x1 * f_x_new < 0:
            x0 = x_new
        else:
            if abs(f_x_new) < epsilon:
                print(f"Znaleziono rozwiązanie: x = {x_new}, po {i + 1} iteracjach")
                return x_new
            print("Brak rozwiązania w podanej liczbie iteracji.")
            return None

    print("Nie znaleziono rozwiązania w podanej liczbie iteracji.")
    return None

def example_function(x):
    return 3 * x - math.cos(x) - 1


a = 0.25
b = 0.75
epsilon = 0.00001

solution = falsi_method(example_function, a, b, epsilon)

if solution is not None:
    print(f"Rozwiązanie: x ≈ {solution}")
else:
    print("Brak rozwiązania.")