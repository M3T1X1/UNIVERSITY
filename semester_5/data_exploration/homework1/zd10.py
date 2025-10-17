#Zadanie 10. Dla danych z pliku rezygnacje.csv wykonać skalowanie następujących cech:
#CZAS_POSIADANIA,
#L_WIAD_POCZTA_G,
#DZIEN_MIN,
#DZIEN_L_POL,
#DZIEN_OPLATA,
#WIECZOR_MIN,
#WIECZ_L_POL,
#WIECZ_OPLATA,
#NOC_MIN,
#NOC_L_POL,
#NOC_OPLATA,
#MIEDZY_MIN,
#MIEDZY_L_POL,
#MIEDZY_OPLATA,
#L_POL_BIURO,REZYGN
#
#Po wykonaniu skalowania tablicę zapisac do pliku rezygnacje_skal.csv

import pandas as pd
from sklearn.preprocessing import MinMaxScaler

data = pd.read_csv('rezygnacje.csv')

selected_columns = [
    'CZAS_POSIADANIA', 'L_WIAD_POCZTA_G',
    'DZIEN_MIN', 'DZIEN_L_POL', 'DZIEN_OPLATA',
    'WIECZOR_MIN', 'WIECZ_L_POL', 'WIECZ_OPLATA',
    'NOC_MIN', 'NOC_L_POL', 'NOC_OPLATA',
    'MIEDZY_MIN', 'MIEDZY_L_POL', 'MIEDZY_OPLATA',
    'L_POL_BIURO', 'REZYGN'
]

df_selected = data[selected_columns]

scaler = MinMaxScaler()
data_scaled = scaler.fit_transform(df_selected)

df_scaled = pd.DataFrame(data_scaled, columns=selected_columns)

print("Dane przed skalowaniem:")
print(df_selected.head())

print("\nDane po skalowaniu:")
print(df_scaled.head())

df_scaled.to_csv('rezygnacje_skal.csv', index=False)