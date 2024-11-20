def secant_method(f, a, b, epsilon=0.00001, max_iter=1000):

    x0, x1 = a, b

    for i in range(max_iter):
        f_x0 = f(x0)
        f_x1 = f(x1)

        if abs(f_x1) < epsilon:
            print(f"Znaleziono rozwiązanie: x = {x1}, po {i + 1} iteracjach")
            return x1

        if f_x1 - f_x0 == 0:
            print("Dzielenie przez zero, metoda siecznych nie może kontynuować.")
            return None

        x_new = x1 - f_x1 * (x1 - x0) / (f_x1 - f_x0)

        x0, x1 = x1, x_new

    print("Nie znaleziono rozwiązania w podanej liczbie iteracji.")
    return None

def example_function(x):
    return x ** 3 + x ** 2 - 3 * x - 3

a = 1
b = 2
epsilon = 0.00001

solution = secant_method(example_function, a, b, epsilon)

if solution is not None:
    print(f"Rozwiązanie: x ≈ {solution}")
else:
    print("Brak rozwiązania.")