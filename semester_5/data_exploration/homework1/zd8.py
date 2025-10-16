#Zad 8. Napisz program który odczytuje tablicę danych rezygnacje.csv, wybiera z niej kolumny:
#CZAS_POSIADANIA, PLAN_MIEDZY, POCZTA_G, L_WIAD_POCZTA_G, L_POL_BIURO, REZYGN. Ponadto, wybiera tych
#klientów, którzy mają plan miedzynarodowy (PLAN_MIEDZY=1), ale nie mają poczty głosowej (POCZTA_G=0) oraz dzwonili
#przynajmniej raz do biura obsługi klienta (L_POL_BIURO>0) .
#Wybraną podtablicę zapisujemy do pliku rezygnacje_sel2.csv. Wypisz 5 pierwszych i 5 ostatnich wierszy tej podtablicy.

import pandas as pd

data = pd.read_csv('rezygnacje.csv')

df = pd.DataFrame(data)

selected_columns = df[['CZAS_POSIADANIA','PLAN_MIEDZY','POCZTA_G','L_WIAD_POCZTA_G','L_POL_BIURO','REZYGN']]
filters = selected_columns[
    (selected_columns['PLAN_MIEDZY'] == 1) &
    (selected_columns['POCZTA_G'] == 0) &
    (selected_columns['L_POL_BIURO'] > 0)
]
filters.index.name = 'ID_osoby'
filters.to_csv('rezygnacje_sel2.csv')

print(f"Górne 5 osob:{filters.head()} \n\n Dolne 5 osób: {filters.tail()}")