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

species = pd.get_dummies(df['species'])
df = pd.concat([df.drop(columns=['species']), species], axis=1)

correlations = ['pearson', 'spearman', 'kendall']

for correlation in correlations:
    corr = df.corr(method=correlation)
    species_corr = corr.loc[features.columns, species.columns]
    print(f"Ranking -> {correlation}")
    for specie in species.columns:
        rank = species_corr[specie].abs().sort_values(ascending=False)
        for column, value in rank.items():
            print(f"{column}: {value}")