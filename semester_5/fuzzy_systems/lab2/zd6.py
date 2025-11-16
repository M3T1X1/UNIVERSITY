import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

distance = ctrl.Antecedent(np.arange(0, 31, 1), 'distance')
brake = ctrl.Consequent(np.arange(0, 6.1, 0.1), 'brake')
humidity = ctrl.Antecedent(np.arange(0, 101, 1), 'humidity')
ice = ctrl.Antecedent(np.arange(0, 101, 1), 'ice')

distance['BARDZO_BLISKO'] = fuzz.trapmf(distance.universe, [0, 0, 2, 6])
distance['BLISKO'] = fuzz.trimf(distance.universe, [2, 8, 15])
distance['DALEKO'] = fuzz.trapmf(distance.universe, [10, 16, 30, 30])

brake['ZERO'] = fuzz.trimf(brake.universe, [0, 0, 1])
brake['LEKKIE'] = fuzz.trimf(brake.universe, [0.5, 2, 3])
brake['MOCNE'] = fuzz.trimf(brake.universe, [2.5, 4, 6])

humidity['NISKA'] = fuzz.trapmf(humidity.universe, [0, 0, 20, 40])
humidity['SREDNIA'] = fuzz.trimf(humidity.universe, [30, 50, 70])
humidity['WYSOKA'] = fuzz.trapmf(humidity.universe, [60, 80, 100, 100])

ice['BRAK'] = fuzz.trapmf(ice.universe, [0, 0, 15, 30])
ice['CZESCIWO'] = fuzz.trimf(ice.universe, [30, 50, 70])
ice['PELNE'] = fuzz.trapmf(ice.universe, [70, 85, 100, 100])

rules = [
    ctrl.Rule(distance['BARDZO_BLISKO'], brake['MOCNE']),

    ctrl.Rule(distance['BLISKO'] & ice['BRAK'] & humidity['NISKA'], brake['LEKKIE']),
    ctrl.Rule(distance['BLISKO'] & ice['BRAK'] & humidity['SREDNIA'], brake['LEKKIE']),
    ctrl.Rule(distance['BLISKO'] & ice['BRAK'] & humidity['WYSOKA'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'] & ice['CZESCIWO'] & humidity['NISKA'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'] & ice['CZESCIWO'] & humidity['SREDNIA'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'] & ice['CZESCIWO'] & humidity['WYSOKA'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'] & ice['PELNE'], brake['MOCNE']),

    ctrl.Rule(distance['DALEKO'] & ice['BRAK'] & humidity['NISKA'], brake['ZERO']),
    ctrl.Rule(distance['DALEKO'] & ice['BRAK'] & humidity['SREDNIA'], brake['ZERO']),
    ctrl.Rule(distance['DALEKO'] & ice['BRAK'] & humidity['WYSOKA'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'] & ice['CZESCIWO'] & humidity['NISKA'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'] & ice['CZESCIWO'] & humidity['SREDNIA'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'] & ice['CZESCIWO'] & humidity['WYSOKA'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'] & ice['PELNE'], brake['LEKKIE']),
]

brake_ctrl = ctrl.ControlSystem(rules)
sim = ctrl.ControlSystemSimulation(brake_ctrl)

test_distances = np.arange(0, 31, 1)
ice_levels = [0, 50, 100]  # BRAK, CZESCIWO, PELNE
humidity_test = 50

colors = ['blue', 'orange', 'green']
markers = ['o', 'x', '^']

for idx, ice_lvl in enumerate(ice_levels):
    brake_results = []
    for d in test_distances:
        sim = ctrl.ControlSystemSimulation(brake_ctrl)
        sim.input['distance'] = d
        sim.input['humidity'] = humidity_test
        sim.input['ice'] = ice_lvl
        sim.compute()
        brake_results.append(sim.output['brake'])
    plt.plot(test_distances, brake_results, marker=markers[idx], color=colors[idx], linewidth=2, label=f'Oblodzenie: {ice_lvl}%')

plt.title('Hamowanie w zależności od odległości, wilgotności i oblodzenia nawierzchni')
plt.xlabel('Odległość [m]')
plt.ylabel('Poziom hamowania')
plt.legend()
plt.grid()
plt.show()
