from matplotlib import pyplot as plt
from ucimlrepo import fetch_ucirepo
import pandas as pd

#Zad 3. Wyznacz ranking skorelowania w danych irysy.csv columny 'gatunek' z innymi kolumnami. Podaj liste kolumn
#w porządku od nabardziej skorelowamych do najmniej skorelowanych wraz z podaniem współczynnika korelacji.
#Przetestuj wszystkie trzy rodzaje korelacji.

iris = fetch_ucirepo(id=53)

features = iris.data.features
target = iris.data.targets['class']

df = features.copy()
df['species'] = target

kendall = df.drop(columns=['species']).corr(method='kendall')
pearson = df.drop(columns=['species']).corr(method='pearson')
spearmen = df.drop(columns=['species']).corr(method='spearman')

"""print(f"Kendall: {kendall} \n")
print(f"Pearson: {pearson} \n")
print(f"Spearmen: {spearmen} \n")"""


