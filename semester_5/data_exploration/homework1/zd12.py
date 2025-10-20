#Zad 12. Napisz program który odczytuje tablicę danych nowotwory.csv i dokonuje na niej binaryzacji kolumn
#symbolicznych dla wszystkich kolumn oprócz ostatniej (czyli PRZY_ZG).
#Tablice po binaryzacji kolumn symbolicznych zapisujemy do pliku nowotwory_bin.csv.

import pandas as pd

data = pd.read_csv('nowotwory.csv')

data_bin = pd.get_dummies(data.drop(columns=['PRZY_ZG']))
data_bin['PRZY_ZG'] = data['PRZY_ZG']

data_bin.to_csv('nowotwory_bin.csv', index=False)


print(f"Dane przed binaryzacją : {data.head()}\n")
print(f"Dane po binaryzacji : {data_bin.head()}")