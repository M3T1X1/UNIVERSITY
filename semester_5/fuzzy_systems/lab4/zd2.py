import numpy as np
from pyit2fls import T1TSK, T1FS, tri_mf, trapezoid_mf
from plotly import graph_objects as go

items_universe = np.linspace(0.0, 160.0, 10)

zero_items = T1FS(items_universe, trapezoid_mf, [-1, 0, 0, 1, 1.0])
low_items = T1FS(items_universe, trapezoid_mf, [-1, 0, 48, 50, 1.0])
medium_items = T1FS(items_universe, trapezoid_mf, [45, 50, 55, 65, 1.0])
high_items = T1FS(items_universe, trapezoid_mf, [55, 60, 99, 101, 1.0])
very_high_items = T1FS(items_universe, trapezoid_mf, [100, 110, 150, 160, 1.0])


def no_bonus(x):
    return 0

def low_bonus(x):
    return 5*(x - 50)

def medium_bonus(x):
    return 10*(x - 50)

def warning(x):
    return float(-20)

def high_bonus(x):
    return 20*(x - 50)

ctrl = T1TSK()

ctrl.add_input_variable('items')
ctrl.add_output_variable('bonus')

ctrl.add_rule([('items',zero_items)],[('bonus',warning)])

ctrl.add_rule([('items',low_items)],[('bonus',no_bonus)])
ctrl.add_rule([('items',medium_items)],[('bonus',low_bonus)])
ctrl.add_rule([('items',high_items)],[('bonus',medium_bonus)])

ctrl.add_rule([('items',very_high_items)],[('bonus',high_bonus)])

items_values = [0,50,60,70,80,90,110,140]
values = []

for item in items_values:
    output = ctrl.evaluate({'items':item}, (item,))
    print(f"{output} -> dla {item} przedmiotów")
    values.append(float(output['bonus']))

fig = go.Figure()

fig.add_trace(go.Scatter(x=items_values,
                         y=values,
                         mode='lines+markers',
                         name = "bonus"))

fig.update_layout(
    title = "Bonus w zaleznosci od ilosci produktow",
    xaxis_title="Items",
    yaxis_title="Bonus"
)

fig.show()


"""
{'bonus': np.float64(-10.0)}
{'bonus': np.float64(0.0)}
{'bonus': np.float64(83.33333333333333)} <- tutaj mamy dziwną wartośc ponieważ jest ona na skraju obu regół przez co brana jest wartość ważona z obu
{'bonus': np.float64(200.0)}
{'bonus': np.float64(300.0)}
{'bonus': np.float64(400.0)}
{'bonus': np.float64(1200.0)}
{'bonus': np.float64(1800.0)}
"""