import numpy as np
import pandas as pd

#Zadanie 2. Wprowadzić jednym z powyższych sposobów tablicę danych ze strony https://en.wikipedia.org/wiki/Rough_set
#(chodzi o "Sample Information System" w sekcji "Example: equivalence-class structure").
#Wypisać rozmiary tej tablicy i nazwy kolumn. Za pomocą funkcji "iat" wyliczyć i wypisać sumy elementów
#w poszczególnych wierszach.

values = {
    'P1':[1,1,2,0,2,0,2,0,2,2],
    'P2':[2,2,0,0,1,0,0,1,1,0],
    'P3':[0,0,0,1,0,1,0,2,0,0],
    'P4':[1,1,1,2,2,2,1,2,2,1],
    'P5':[1,1,0,1,1,2,0,1,2,0]
}

df = pd.DataFrame(values)
print(f"Nazwa kolumn i typ danych: {df.columns}")

print(f"Wymiar dataframe: {df.size}")

for i in range(df.shape[0]):
    value = 0
    for j in range(df.shape[1]):
        value = value + df.iat[i,j]
    print(f"Rząd:{i} wartosc: {value}")

#zadanie 3

