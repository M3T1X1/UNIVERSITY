import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

distance = ctrl.Antecedent(np.arange(0, 31, 1), 'distance')
brake = ctrl.Consequent(np.arange(0, 6.1, 0.1), 'brake')

distance['BARDZO_BLISKO'] = fuzz.trapmf(distance.universe, [0, 0, 2, 6])
distance['BLISKO'] = fuzz.trimf(distance.universe, [2, 8, 15])
distance['DALEKO'] = fuzz.trapmf(distance.universe, [10, 16, 30, 30])

brake['ZERO'] = fuzz.trimf(brake.universe, [0, 0, 1])
brake['LEKKIE'] = fuzz.trimf(brake.universe, [0.5, 2, 3])
brake['MOCNE'] = fuzz.trimf(brake.universe, [2.5, 4, 6])

rules = [
    ctrl.Rule(distance['BARDZO_BLISKO'], brake['MOCNE']),
    ctrl.Rule(distance['BLISKO'], brake['LEKKIE']),
    ctrl.Rule(distance['DALEKO'], brake['ZERO'])
]

brake_ctrl = ctrl.ControlSystem(rules)
sim = ctrl.ControlSystemSimulation(brake_ctrl)

test_distances = np.arange(0, 31, 1)
brake_results = []

for d in test_distances:
    sim = ctrl.ControlSystemSimulation(brake_ctrl)
    sim.input['distance'] = d
    sim.compute()
    brake_results.append(sim.output['brake'])

plt.plot(test_distances, brake_results, marker='x')
plt.title('Hamowanie w zależności od odległości ')
plt.xlabel('Odległość')
plt.ylabel('Poziom hamowania')
plt.grid()