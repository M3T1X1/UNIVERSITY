import numpy as np
from pyit2fls import T1TSK, T1FS, tri_mf, trapezoid_mf
import matplotlib.pyplot as plt

food_universe = np.linspace(0.0, 10.0, 1000)
service_universe = np.linspace(0.0, 10.0, 1000)

very_low = T1FS(food_universe, trapezoid_mf, [-1, 0, 1, 2, 1.0])
very_low.plot('very low food')
low = T1FS(food_universe, trapezoid_mf, [2, 3, 5, 6, 1.0])
low.plot('low food')
medium = T1FS(food_universe, tri_mf, [3, 5, 7, 1.0])
medium.plot('medium food')
high = T1FS(food_universe, trapezoid_mf, [6, 7, 10, 11, 1.0])
high.plot('high food')

very_low_service = T1FS(service_universe, trapezoid_mf, [-1, 0, 1, 2, 1.0])
low_service = T1FS(service_universe, trapezoid_mf, [2, 3, 5, 6, 1.0])
medium_service = T1FS(service_universe, tri_mf, [3, 5, 7, 1.0])
high_service = T1FS(service_universe, trapezoid_mf, [6, 7, 10, 11, 1.0])

def low_tip(x1, x2):
    return 0 + 0.5 * x1 + 0.5 * x2


def medium_tip(x1, x2):
    return 0 + 0.7 * x1 + 0.7 * x2


def high_tip(x1, x2):
    return 0 + x1 + x2

def no_tip(x1, x2):
    return 0

controller = T1TSK()

controller.add_input_variable('food')
controller.add_input_variable('service')
controller.add_output_variable('tip')

controller.add_rule([("food",very_low)], [("tip", no_tip)])
controller.add_rule([("service",very_low_service)], [("tip", no_tip)])

controller.add_rule([('food', low), ('service', low_service)], [('tip', low_tip)])
controller.add_rule([('food', low), ('service', medium_service)], [('tip', low_tip)])
controller.add_rule([('food', low), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', medium), ('service', low_service)], [('tip', low_tip)])
controller.add_rule([('food', medium), ('service', medium_service)], [('tip', medium_tip)])
controller.add_rule([('food', medium), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', high), ('service', low_service)], [('tip', medium_tip)])
controller.add_rule([('food', high), ('service', medium_service)], [('tip', high_tip)])
controller.add_rule([('food', high), ('service', high_service)], [('tip', high_tip)])

values = [[0,0],[10,0],[0,10],[10,10],[5,5],[0,5],[5,0]]

for quality, service in values:
    output = controller.evaluate({"food":quality, "service":service}, (quality, service,))
    print(output)
print("\n")

value = controller.evaluate({"food":6.5, "service":5}, (6.5, 5,))
print(value)


"""
{'tip': np.float64(0.0)} no tip [0,0]
{'tip': np.float64(0.0)} no tip [10,0]
{'tip': np.float64(0.0)} no tip [0,10]
{'tip': np.float64(20.0)} high tip [10,10]
{'tip': np.float64(5.5)} medium tip [5,5]
{'tip': np.float64(0.0)} no tip [0,5]
{'tip': np.float64(0.0)} no tip [5,0]
"""

"""
{'tip': np.float64(10.35)} 

tip = (w1 * tip1 + w2 * tip2) / (w1 + w2) = (0.25 * 8.05 + 0.5 * 11.5) / (0.25 + 0.5) = (2.0125 + 5.75) / 0.75 = 7.7625 / 0.75 = 10.35
"""