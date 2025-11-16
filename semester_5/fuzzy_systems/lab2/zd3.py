import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

service_quality = ctrl.Antecedent(np.arange(-2, 12, 1), 'service_quality')
food_quality = ctrl.Antecedent(np.arange(-2, 12, 1), 'food_quality')
gratuity = ctrl.Consequent(np.arange(0, 22, 1), 'gratuity')

service_quality['BAD'] = fuzz.trapmf(service_quality.universe, [-2, 0, 2, 4])
service_quality['MEDIUM'] = fuzz.trimf(service_quality.universe, [3, 6, 8])
service_quality['HIGH'] = fuzz.trapmf(service_quality.universe, [7, 9, 12, 12])

food_quality['BAD'] = fuzz.trapmf(food_quality.universe, [-2, 0, 2, 4])
food_quality['MEDIUM'] = fuzz.trimf(food_quality.universe, [3, 6, 8])
food_quality['HIGH'] = fuzz.trapmf(food_quality.universe, [7, 9, 12, 12])

gratuity['POOR'] = fuzz.trapmf(gratuity.universe, [0, 0, 4, 6])
gratuity['AVERAGE'] = fuzz.trimf(gratuity.universe, [5, 10, 14])
gratuity['GENEROUS'] = fuzz.trapmf(gratuity.universe, [13, 17, 22, 22])

rules = [
    ctrl.Rule(service_quality['BAD'] & food_quality['BAD'], gratuity['POOR']),
    ctrl.Rule(service_quality['MEDIUM'] & food_quality['BAD'], gratuity['POOR']),
    ctrl.Rule(service_quality['BAD'] & food_quality['MEDIUM'], gratuity['POOR']),
    ctrl.Rule(service_quality['HIGH'] & food_quality['BAD'], gratuity['AVERAGE']),
    ctrl.Rule(service_quality['BAD'] & food_quality['HIGH'], gratuity['AVERAGE']),
    ctrl.Rule(service_quality['MEDIUM'] & food_quality['MEDIUM'], gratuity['AVERAGE']),
    ctrl.Rule(service_quality['MEDIUM'] & food_quality['HIGH'], gratuity['AVERAGE']),
    ctrl.Rule(service_quality['HIGH'] & food_quality['MEDIUM'], gratuity['AVERAGE']),
    ctrl.Rule(service_quality['HIGH'] & food_quality['HIGH'], gratuity['GENEROUS']),
]

gratuity_ctrl = ctrl.ControlSystem(rules)
sim = ctrl.ControlSystemSimulation(gratuity_ctrl)

values_food_quality = [2, 6, 9]
test_values = np.arange(-2, 8.5, 0.5)

for fq in values_food_quality:
    result = []
    for val in test_values:
        sim = ctrl.ControlSystemSimulation(gratuity_ctrl)
        sim.input['service_quality'] = val
        sim.input['food_quality'] = fq
        try:
            sim.compute()
            result.append(sim.output['gratuity'])
        except KeyError:
            print(f"Brak wyniku")
            result.append(np.nan)
    plt.plot(test_values, result, marker='x', label=f'Jakość: {fq}')


plt.title('Zależność jakości obsługi od napiwku')
plt.xlabel('Jakość obsługi')
plt.ylabel('Napiwek')
plt.show()
