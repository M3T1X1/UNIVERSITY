import numpy as np
from pyit2fls import T1TSK, T1FS, tri_mf, trapezoid_mf
import matplotlib.pyplot as plt

# definiujemy że uniwersum jakości jedzenia to zbiór od 0 do 10 (skala punktowa)
food_universe = np.linspace(0.0, 10.0, 1000)
# definiujemy że uniwersum jakosci obsługi to zbiór od 0 do 10
service_universe = np.linspace(0.0, 10.0, 1000)

# wejście 1
# definiujemy zbiory rozmyte
# świadomie wykroczono poza uniwersum, gdyż biblioteka nie pozwala
# podać dwóch takich samych wartości obok siebie
low = T1FS(food_universe, trapezoid_mf, [-1, 0, 3, 5, 1.0])
low.plot('low food')
medium = T1FS(food_universe, tri_mf, [3, 5, 7, 1.0])
medium.plot('medium food')
high = T1FS(food_universe, trapezoid_mf, [6, 7, 10, 11, 1.0])
high.plot('high food')

# wejście 2
low_service = T1FS(service_universe, trapezoid_mf, [-1, 0, 3, 5, 1.0])
medium_service = T1FS(service_universe, tri_mf, [3, 5, 7, 1.0])
high_service = T1FS(service_universe, trapezoid_mf, [6, 7, 10, 11, 1.0])

# definiujemy funkcje liniowe dwuargumentowe
# w przykładzie mamy 2 zmienne, zatem jest to funkcja dwóch zmiennych
# oraz parametru wolnego
def low_tip(x1, x2):
    return 0 + 0.5 * x1 + 0.5 * x2


def medium_tip(x1, x2):
    return 0 + 0.7 * x1 + 0.7 * x2


def high_tip(x1, x2):
    # pominięto tutaj współczynnki zmiennych, ale są po prostu równe 1
    return 0 + x1 + x2


# definiujemy sterownik rozmyty TSK
controller = T1TSK()
# są 2 wejścia, jedno wyjście
controller.add_input_variable('food')
controller.add_input_variable('service')
controller.add_output_variable('tip')

# reguły TSK
# poprzednik składa się tak jak we wnioskowaniu Mamdaniego
# ze zbiorów rozmytych połączych spójnikami rozmytymi
# natomiast następnik jest wcześniej zdefiniowaną funkcją

controller.add_rule([('food', low), ('service', low_service)], [('tip', low_tip)])
controller.add_rule([('food', low), ('service', medium_service)], [('tip', low_tip)])
controller.add_rule([('food', low), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', medium), ('service', low_service)], [('tip', low_tip)])
controller.add_rule([('food', medium), ('service', medium_service)], [('tip', medium_tip)])
controller.add_rule([('food', medium), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', high), ('service', low_service)], [('tip', medium_tip)])
controller.add_rule([('food', high), ('service', medium_service)], [('tip', high_tip)])
controller.add_rule([('food', high), ('service', high_service)], [('tip', high_tip)])

# podajemy ostre wejścia i uzyskujemy wyjście
# biblioteka wymaga powtórzenia wejść ostrych jako argumentów funkcji na wyjściu
it2out = controller.evaluate({"food": 6.5, "service": 5.0}, (6.5, 5,))
print(it2out) # tutaj dostajemy słownik wszystkich wyjść
print(it2out['tip']) # tutaj możemy pobrać konkretną wartość wyjścia

plt.show()