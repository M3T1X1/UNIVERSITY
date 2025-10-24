import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

quality_of_service = ctrl.Antecedent(np.arange(0, 10, 1), 'quality')
tip = ctrl.Consequent(np.arange(0, 20, 1), 'tip')

quality_of_service['BAD'] = fuzz.trapmf(quality_of_service.universe, [0, 0, 3, 5])
quality_of_service['MEDIUM'] = fuzz.trimf(quality_of_service.universe, [3, 5, 7])
quality_of_service['HIGH'] = fuzz.trapmf(quality_of_service.universe, [6, 7, 10, 10])

tip['POOR'] = fuzz.trapmf(tip.universe, [0, 0, 3, 5])
tip['AVERAGE'] = fuzz.trimf(tip.universe, [4, 8, 12])
tip['GENEROUS'] = fuzz.trapmf(tip.universe, [10, 15, 20, 20])

rule1 = ctrl.Rule(quality_of_service['BAD'], tip['POOR'])
rule2 = ctrl.Rule(quality_of_service['MEDIUM'], tip['AVERAGE'])
rule3 = ctrl.Rule(quality_of_service['HIGH'], tip['GENEROUS'])

tipper_ctrl = ctrl.ControlSystem([rule1, rule2, rule3])
tipper_simulation = ctrl.ControlSystemSimulation(tipper_ctrl)

quality_values = np.arange(-3, 8, 0.2)
tip_values = []

for q in quality_values:
    tipper_sim = ctrl.ControlSystemSimulation(tipper_ctrl)
    tipper_sim.input['quality'] = q
    tipper_sim.compute()
    tip_values.append(tipper_sim.output['tip'])

for q, t in zip(quality_values, tip_values):
    print(f"Jakość: {q:.2f} -> Napiwek: {t:.2f}")

plt.plot(quality_values, tip_values,  marker='o')
plt.title("Zależność jakości obsługi od wysokości napiwku")
plt.xlabel("Jakość obsługo")
plt.ylabel("Wysokość napiwku")
plt.grid(True)
plt.show()
