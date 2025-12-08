import numpy as np
from pyit2fls import Mamdani, min_t_norm, max_s_norm, IT2FS, tri_mf, trapezoid_mf, \
    ltri_mf, rtri_mf, crisp, IT2FS_plot

# Uniwersum zmiennych wejściowych
metraz_universe = np.linspace(20.0, 100.0, 1000)      # m²
dystans_universe = np.linspace(0.0, 25.0, 1000)       # km od centrum
wiek_universe = np.linspace(0.0, 50.0, 1000)         # lata
cena_universe = np.linspace(0.0, 3000000.0, 1000)     # PLN

# ZBIORY PRZEDZIAŁOWO-ROZMYTE DLA METRAŻU
maly_metraz = IT2FS(metraz_universe, rtri_mf, [50, 20, 1.0], rtri_mf, [45, 20, 0.98])
sredni_metraz = IT2FS(metraz_universe, tri_mf, [40, 60, 80, 1.0], tri_mf, [45, 60, 75, 0.99])
duzy_metraz = IT2FS(metraz_universe, ltri_mf, [70, 90, 1.0], ltri_mf, [75, 95, 0.98])

# ZBIORY PRZEDZIAŁOWO-ROZMYTE DLA DYSTANSU
blisko = IT2FS(dystans_universe, rtri_mf, [5, 0, 1.0], rtri_mf, [3, 0, 0.98])
srednio = IT2FS(dystans_universe, tri_mf, [3, 12, 18, 1.0], tri_mf, [5, 12, 16, 0.99])
daleko = IT2FS(dystans_universe, ltri_mf, [20, 25, 1.0], ltri_mf, [22, 27, 0.98])

# ZBIORY PRZEDZIAŁOWO-ROZMYTE DLA WIEKU
nowy = IT2FS(wiek_universe, rtri_mf, [15, 0, 1.0], rtri_mf, [10, 0, 0.98])
sredni_wiek = IT2FS(wiek_universe, tri_mf, [10, 25, 35, 1.0], tri_mf, [15, 25, 30, 0.99])
stary = IT2FS(wiek_universe, ltri_mf, [40, 50, 1.0], ltri_mf, [42, 52, 0.98])

# ZBIORY WYJŚCIOWE DLA CENY
tani_cena = IT2FS(cena_universe, rtri_mf, [1200000, 0, 1.0], rtri_mf, [900000, 0, 0.98])
sredni_cena = IT2FS(cena_universe, tri_mf, [900000, 1600000, 2200000, 1.0], tri_mf, [1100000, 1550000, 2100000, 0.99])
drogi_cena = IT2FS(cena_universe, tri_mf, [1800000, 2400000, 2800000, 1.0], tri_mf, [1900000, 2350000, 2750000, 0.99])
luksusowy_cena = IT2FS(cena_universe, ltri_mf, [2500000, 3000000, 1.0], ltri_mf, [2600000, 3100000, 0.98])

# TYLKO WIZUALIZACJA ZBIORÓW - każda zmienna osobno + cena
IT2FS_plot(maly_metraz, sredni_metraz, duzy_metraz, legends=["mały", "średni", "duży metraż"])
IT2FS_plot(blisko, srednio, daleko, legends=["blisko", "średnio", "daleko centrum"])
IT2FS_plot(nowy, sredni_wiek, stary, legends=["nowy", "średni", "stary budynek"])
IT2FS_plot(tani_cena, sredni_cena, drogi_cena, luksusowy_cena, legends=["tani", "średni", "drogi", "luksusowy"])

# STEROWNIK PRZEDZIAŁOWO-ROZMYTY MAMDANI
controller = Mamdani(t_norm=min_t_norm, s_norm=max_s_norm, method="Centroid", algorithm="KM")
controller.add_input_variable('metraz')
controller.add_input_variable('dystans')
controller.add_input_variable('wiek')
controller.add_output_variable('cena')

# REGUŁY
controller.add_rule([('metraz', maly_metraz), ('dystans', daleko), ('wiek', stary)], [('cena', tani_cena)])
controller.add_rule([('metraz', maly_metraz), ('dystans', srednio), ('wiek', sredni_wiek)], [('cena', tani_cena)])
controller.add_rule([('metraz', maly_metraz), ('dystans', blisko), ('wiek', nowy)], [('cena', sredni_cena)])

controller.add_rule([('metraz', sredni_metraz), ('dystans', daleko), ('wiek', stary)], [('cena', tani_cena)])
controller.add_rule([('metraz', sredni_metraz), ('dystans', srednio), ('wiek', sredni_wiek)], [('cena', sredni_cena)])
controller.add_rule([('metraz', sredni_metraz), ('dystans', blisko), ('wiek', nowy)], [('cena', drogi_cena)])

controller.add_rule([('metraz', duzy_metraz), ('dystans', daleko), ('wiek', stary)], [('cena', sredni_cena)])
controller.add_rule([('metraz', duzy_metraz), ('dystans', srednio), ('wiek', sredni_wiek)], [('cena', drogi_cena)])
controller.add_rule([('metraz', duzy_metraz), ('dystans', blisko), ('wiek', nowy)], [('cena', luksusowy_cena)])

# TESTOWE WYCENY
testy = [[30,18,40], [60,8,25], [85,2,5], [50,12,35]]
for metraz, dystans, wiek in testy:
    it2out, tr = controller.evaluate({"metraz":metraz, "dystans":dystans, "wiek":wiek})
    print(f"{metraz}m², {dystans}km, {wiek}lat → {crisp(tr['cena']):,.0f} PLN")
