#Zad 6. Napisz program który dokonuje analizy statystycznej kolumn zbioru danych rezygnacje.csv, przy czym kolumny
#o wartościach symbolicznych (nominalne) analizuje inaczej, a kolumny o wartościach numerycznych inaczej.
#Porównaj, czy uzyskane wyniki zgadzają się z tym co wypisze funkcja describe() dla całej tablicy.
import numpy as np
import pandas as pd

data = pd.read_csv('rezygnacje.csv')

df = pd.DataFrame(data)

#count,mean,min,25%,50%,75%,max

mean_values = df.mean(numeric_only=True)
count_values = df.count()
min_values = df.min()
max_values = df.max()
quantile_25_values = df.quantile(0.25, numeric_only=True)
quantile_50_values = df.quantile(0.5, numeric_only=True)
quantile_75_values = df.quantile(0.75, numeric_only=True)

result = pd.DataFrame({
    'mean' : mean_values,
    'count' : count_values,
    'min' : min_values,
    'max' : max_values,
    '25%' : quantile_25_values,
    '50%' : quantile_50_values,
    '75%' : quantile_75_values,
})

print(f"{result}\n\n")
print(df.describe())

