#Zadanie 11. Dla danych z pliku rezygnacje.csv wykonać standaryzację następujących cech:
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
#Po wykonaniu standaryzacji tablicę zapisać do pliku rezygnacje_stand.csv

import pandas as pd
from sklearn.preprocessing import StandardScaler

data = pd.read_csv('rezygnacje.csv')

df = pd.DataFrame(data)

selected_columns = [
    'CZAS_POSIADANIA', 'L_WIAD_POCZTA_G',
    'DZIEN_MIN', 'DZIEN_L_POL', 'DZIEN_OPLATA',
    'WIECZOR_MIN', 'WIECZ_L_POL', 'WIECZ_OPLATA',
    'NOC_MIN', 'NOC_L_POL', 'NOC_OPLATA',
    'MIEDZY_MIN', 'MIEDZY_L_POL', 'MIEDZY_OPLATA',
    'L_POL_BIURO', 'REZYGN'
]

df_selected = data[selected_columns]

scaler = StandardScaler()
scaled_data = scaler.fit_transform(df_selected)

df_scaled = pd.DataFrame(scaled_data, columns=selected_columns)

print("Dane przed standaryzacją:")
print(df_selected.head(10))

print("\nDane po standaryzacji:")
print(df_scaled.head(10))

df_scaled.to_csv('rezygnacje_stand.csv', index=False)
