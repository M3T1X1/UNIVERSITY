import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

size = ctrl.Antecedent(np.arange(0, 11, 1), 'size')
weight = ctrl.Antecedent(np.arange(0, 101, 1), 'weight')
quality = ctrl.Consequent(np.arange(0, 1.01, 0.01), 'quality')

size['small'] = fuzz.trimf(size.universe, [0, 0, 5])
size['large'] = fuzz.trimf(size.universe, [5, 10, 10])

weight['small'] = fuzz.trimf(weight.universe, [0, 0, 50])
weight['large'] = fuzz.trimf(weight.universe, [50, 100, 100])

quality['bad'] = fuzz.trimf(quality.universe, [0.0, 0.0, 0.5])
quality['medium'] = fuzz.trimf(quality.universe, [0.0, 0.5, 1.0])
quality['good'] = fuzz.trimf(quality.universe, [0.5, 1.0, 1.0])

rules = [
    ctrl.Rule(size['small'] & weight['small'], quality['bad']),
    ctrl.Rule(size['small'] & weight['large'], quality['medium']),
    ctrl.Rule(size['large'] & weight['small'], quality['medium']),
    ctrl.Rule(size['large'] & weight['large'], quality['good']),
]

quality_ctrl = ctrl.ControlSystem(rules)
sim = ctrl.ControlSystemSimulation(quality_ctrl)

size_test = [2, 7, 10]
weight_values = np.arange(0, 101, 5)

colors = ['blue', 'orange', 'green']
for idx, s in enumerate(size_test):
    quality_results = []
    for w in weight_values:
        sim = ctrl.ControlSystemSimulation(quality_ctrl)
        sim.input['size'] = s
        sim.input['weight'] = w
        try:
            sim.compute()
            quality_results.append(sim.output['quality'])
        except KeyError:
            print(f"BRAK wyniku dla size={s}, weight={w}")
            quality_results.append(np.nan)
    plt.plot(weight_values, quality_results, color=colors[idx], marker='o', label=f'Rozmiar: {s}')


plt.title('Jakość owocu w zależności od wagi (przy różnych rozmiarach)')
plt.xlabel('Waga owocu')
plt.ylabel('Jakość owocu')
plt.legend()
plt.grid()
plt.show()
