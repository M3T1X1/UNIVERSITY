import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

# Zmienne wejściowe
distance = ctrl.Antecedent(np.arange(0, 31, 1), 'distance')
humidity = ctrl.Antecedent(np.arange(0, 101, 1), 'humidity')  # Wilgotność w procentach

# Zmienna wyjściowa
brake = ctrl.Consequent(np.arange(0, 6.1, 0.1), 'brake')

# Zbiory rozmyte dla odległości
distance['BARDZO_BLISKO'] = fuzz.trapmf(distance.universe, [0, 0, 2, 6])
distance['BLISKO'] = fuzz.trimf(distance.universe, [2, 8, 15])
distance['DALEKO'] = fuzz.trapmf(distance.universe, [10, 16, 30, 30])

# Zbiory rozmyte dla wilgotności
humidity['NISKA'] = fuzz.trapmf(humidity.universe, [0, 0, 20, 40])
humidity['SREDNIA'] = fuzz.trimf(humidity.universe, [30, 50, 70])
humidity['WYSOKA'] = fuzz.trapmf(humidity.universe, [60, 80, 100, 100])

# Zbiory rozmyte dla hamowania
brake['ZERO'] = fuzz.trimf(brake.universe, [0, 0, 1])
brake['LEKKIE'] = fuzz.trimf(brake.universe, [0.5, 2, 3])
brake['MOCNE'] = fuzz.trimf(brake.universe, [2.5, 4, 6])

# Reguły sterownika:
rules = [
    # Bardzo blisko: zawsze mocne (niezależnie od wilgotności)
    ctrl.Rule(distance['BARDZO_BLISKO'], brake['MOCNE']),
    # Blisko + niska wilgotność = lekkie, ale blisko + wysoka wilgotność = mocne
    ctrl.Rule(distance['BLISKO'] & humidity['NISKA'], brake['LEKKIE']),
    ctrl.Rule(distance['BLISKO'] & humidity['SREDNIA'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'] & humidity['WYSOKA'], brake['MOCNE']),
    # Daleko: zahamuj tylko jeśli ślisko i nadal dość blisko, w przeciwnym wypadku - zero
    ctrl.Rule(distance['DALEKO'] & humidity['NISKA'], brake['ZERO']),
    ctrl.Rule(distance['DALEKO'] & humidity['SREDNIA'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'] & humidity['WYSOKA'], brake['LEKKIE']),
]

brake_ctrl = ctrl.ControlSystem(rules)
sim = ctrl.ControlSystemSimulation(brake_ctrl)

# Przykład wykresu dla różnych poziomów wilgotności
test_distances = np.arange(0, 31, 1)
humidity_levels = [10, 50, 90]  # NISKA, ŚREDNIA, WYSOKA

for hum in humidity_levels:
    brake_results = []
    for d in test_distances:
        sim = ctrl.ControlSystemSimulation(brake_ctrl)
        sim.input['distance'] = d
        sim.input['humidity'] = hum
        sim.compute()
        brake_results.append(sim.output['brake'])
    plt.plot(test_distances, brake_results, marker='o', label=f'Wilgotność: {hum}%')

plt.title('Hamowanie w zależności od odległości i wilgotności nawierzchni')
plt.xlabel('Odległość [m]')
plt.ylabel('Poziom hamowania')
plt.legend()
plt.grid()
plt.show()
