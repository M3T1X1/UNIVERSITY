#Zad 9. Napisz program który odczytuje tablicę danych rezygnacje.csv, wybiera z niej kolumny:
#CZAS_POSIADANIA, PLAN_MIEDZY, POCZTA_G, L_WIAD_POCZTA_G, L_POL_BIURO, REZYGN.
#Następnie w wybranej podtablicy w kolumnie REZYGN wymienia wartość 1 na 'TAK', a wartość 0 na 'NIE'.
#Wybraną podtablicę zapisujemy do pliku rezygnacje_TAK_NIE.csv. Wypisz 5 pierwszych i 5 ostatnich wierszy tej
#podtablicy.

import pandas as pd

data = pd.read_csv('rezygnacje.csv')

df = pd.DataFrame(data)

selected_columns = df[['CZAS_POSIADANIA', 'PLAN_MIEDZY', 'POCZTA_G', 'L_WIAD_POCZTA_G', 'L_POL_BIURO', 'REZYGN']].copy()

selected_columns['REZYGN'] = selected_columns['REZYGN'].map({0 : 'NIE', 1 : 'TAK'})

#pd.set_option('display.max_columns', None)
#pd.set_option('display.max_rows', None)

print(selected_columns)

selected_columns.to_csv('rezygnacje_TAK_NIE.csv', index=False)
