import math

def newton_method(f, f_prime, f_double_prime, a, b, epsilon=0.01, max_iter=1000):

    if f(a) * f_double_prime(a) > 0:
        x = a
    elif f(b) * f_double_prime(b) > 0:
        x = b
    else:
        print("Brak odpowiedniego punktu początkowego spełniającego warunek zbieżności.")
        return None

    for i in range(max_iter):
        fx = f(x)
        fpx = f_prime(x)

        #
        if fpx == 0:
            print("Pochodna pierwszego stopnia jest zerowa, metoda Newtona nie może kontynuować.")
            return None

        x_new = x - fx / fpx

        if abs(x_new - x) < epsilon:
            print(f"Znaleziono rozwiązanie: x = {x_new}, po {i + 1} iteracjach")
            return x_new

        x = x_new

    print("Nie znaleziono rozwiązania w podanej liczbie iteracji.")
    return None


def example_function(x):
    return math.sin(x) - 0.5 * x

def example_function_derivative(x):
    return math.cos(x) - 0.5

def example_function_second_derivative(x):
    return -math.sin(x)

a = math.pi / 2
b = math.pi
epsilon = 0.01

solution = newton_method(example_function, example_function_derivative, example_function_second_derivative, a, b, epsilon)

if solution is not None:
    print(f"Rozwiązanie: x ≈ {solution}")
else:
    print("Brak rozwiązania.")