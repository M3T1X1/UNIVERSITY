import pandas as pd

dane = {
    'Imię': ['Anna', 'Jan', 'Kasia', 'Piotr'],
    'Wiek': [25, 30, 28, 35],
    'Pensja': [5000, 6000, 4500, 7000],
    'Miasto': ['Warszawa', 'Kraków', 'Gdańsk', 'Wrocław']
}

df = pd.DataFrame(dane)

print("===== WYŚWIETLANIE =====")

print(df.head(2)) # wyświetla pierwsze n wierszy (bazowo 5)
print(df.shape) # wyświetla ile jest wierszy i kolumn
print(df.describe()) # wyświetla podstawowe statystyki
print(df["Imię"]) # wyświetla wartości kolumny "Imię"
print(df.loc[1,"Imię"]) #wyświetla pierwszą komórkę z kolumny "Imię"

print("\n\n\n===== AKTUALIZACJA WARTOŚCI =====")

df["Pensja"] = df["Pensja"] * 1.1  # +10% do pensji
print("Po podwyżkach:", df["Pensja"].tolist())

df.loc[df['Wiek'] < 30, 'Wiek'] = 18  # Wiek < 30 → 18
print("Po zmianie wieku:", df[['Imię', 'Wiek']])