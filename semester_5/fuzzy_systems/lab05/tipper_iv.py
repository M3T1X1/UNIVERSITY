import numpy as np
from pyit2fls import Mamdani, min_t_norm, max_s_norm, IT2FS, tri_mf, trapezoid_mf, ltri_mf, rtri_mf, TR_plot, crisp, \
    IT2FS_plot
import matplotlib.pyplot as plt

# definiujemy uniwersum - czyli zbiór ostry
# dla którego definiujemy funkcje przynależności
# do zbiorów przedziałowo-rozmytych

# definiujemy że uniwersum jakości jedzenia to zbiór od 0 do 10 (skala punktowa)
food_universe = np.linspace(0.0, 10.0, 1000)
# definiujemy że uniwersum napiwku to procenty od 0 do 20
tip_universe = np.linspace(0.0, 20.0, 1000)
# definiujemy że uniwersum jakosci obsługi to zbiór od 0 do 10
service_universe = np.linspace(0.0, 10.0, 1000)

# funkcje przynależności to dwie right triangular membership function
# o zadanych parametrach
rancid = IT2FS(food_universe, rtri_mf, [3.01, 0, 1.0], rtri_mf, [2, 0, 0.99])
rancid.plot(title='RANCID')
rancid.check_set()

# górna funkcja przynależności to funkcja trapezoidalna, natomiast dolna
# to funkcja trójkątna
medium = IT2FS(food_universe, tri_mf, [2, 5.1, 8, 1.0], tri_mf, [4, 5.1, 6, 0.99])
medium.plot(title='MEDIUM')
medium.check_set()

# funkcje przynależności to dwie left triangular membership function
# o zadanych parametrach
delicious = IT2FS(food_universe, ltri_mf, [7, 8, 1.0], ltri_mf, [8, 9, 0.99])
delicious.plot(title='DELICIOUS')
delicious.check_set()

low_tip = IT2FS(tip_universe, rtri_mf, [6, 0, 1.0], rtri_mf, [3, 0, 0.99])
low_tip.plot(title='LOW_TIP')
low_tip.check_set()

medium_tip = IT2FS(tip_universe, tri_mf, [4, 9, 14, 1.0], tri_mf, [8, 9, 10, 0.99])
medium_tip.plot(title='MEDIUM_TIP')
medium_tip.check_set()

generous_tip = IT2FS(tip_universe, ltri_mf, [12, 15, 1.0], ltri_mf, [15, 17, 0.99])
generous_tip.plot(title='GENEROUS_TIP')
generous_tip.check_set()

low_service = IT2FS(service_universe, rtri_mf, [3.01, 0, 1.0], rtri_mf, [2, 0, 0.99])
low_service.check_set()
low_service.plot(title='LOW SERVICE')
medium_service = IT2FS(service_universe, tri_mf,  [2, 5, 8, 1.0], tri_mf, [4, 5, 6, 1.0])
medium_service.plot(title='MEDIUM SERVICE')
medium_service.check_set()
high_service = IT2FS(service_universe, ltri_mf, [6, 8, 1.0], ltri_mf, [7, 9, 0.99])
high_service.plot(title='HIGH SERVICE')
high_service.check_set()

# tutaj funkcje przynależenia zbiorczo
IT2FS_plot(rancid, medium, delicious, legends=["rancid", "medium", "delicious"])
IT2FS_plot(low_service, medium_service, high_service, legends=["low", "medium", "high"])
IT2FS_plot(low_tip, medium_tip, generous_tip, legends=["low_tip", "medium_tip", "generous_tip"])


plt.show()

# definiujemy sterownik rozmyty
controller = Mamdani(t_norm=min_t_norm, s_norm=max_s_norm, method="Centroid", algorithm="KM")
# są 2 wejścia, jedno wyjście
controller.add_input_variable('food')
controller.add_input_variable('service')
controller.add_output_variable('tip')

# definiujemy reguły rozmyte
# spójnik pomiędzy wejściami to and
controller.add_rule([('food', rancid), ('service', low_service)], [('tip', low_tip)])
controller.add_rule([('food', rancid), ('service', medium_service)], [('tip', medium_tip)])
controller.add_rule([('food', rancid), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', medium), ('service', low_service)], [('tip', medium_tip)])
controller.add_rule([('food', medium), ('service', medium_service)], [('tip', medium_tip)])
controller.add_rule([('food', medium), ('service', high_service)], [('tip', medium_tip)])

controller.add_rule([('food', delicious), ('service', low_service)], [('tip', medium_tip)])
controller.add_rule([('food', delicious), ('service', medium_service)], [('tip', generous_tip)])
controller.add_rule([('food', delicious), ('service', high_service)], [('tip', generous_tip)])

# podajemy ostre wejścia i uzyskujemy wyjście
it2out, tr = controller.evaluate({"food": 0.0, "service": 5.0})
it2out["tip"].plot()
TR_plot(tip_universe, tr["tip"])
# wypisujemy wyjście po defuzzyfikacji
print('tip', crisp(tr["tip"]))


# rysujemy na wykresach wpływ jednej zmiennej na napiwek
# przy drugiej ustawionej na sztywną wartość
x = np.arange(0, 11.5, 0.5)

tip = [crisp(controller.evaluate({"food": food, "service": 0})[1]['tip']) for food in x]
print(tip)
plt.plot(x, tip)
plt.show()

tip = [crisp(controller.evaluate({"food": 0, "service": service})[1]['tip']) for service in x]
print(tip)
plt.plot(x, tip)
plt.show()

# rysujemy wykres 3D tej zależności
xs = np.arange(0, 10.25, 0.25)
ys = np.arange(0, 10.25, 0.25)
z = np.array([(x, y, crisp(controller.evaluate({'food': x, 'service': y})[1]['tip'])) for x in xs for y in ys])
print(z)

fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.scatter(z[:, 0], z[:, 1], z[:, 2])

ax.set_xlabel('food')
ax.set_ylabel('service')
ax.set_zlabel('tip')
plt.title('tipper IV')
plt.show()

# dodatkowo tworzymy plik csv, w którym możemy łatwiej
# sprawdzić konkretne wartości
import pandas as pd
pd.DataFrame({'x': z[:, 0], 'y': z[:, 1], 'z': z[:, 2]}).to_csv('../lab4/tipper_iv.csv')
