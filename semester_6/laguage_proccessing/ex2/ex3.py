import re

tekst_bazowy = "Kontakt: admin@strona.pl, biuro@firma.com. Cena zestawu to 100.00 PLN. Kod produktu: 12-345."

print("--- 1. re.findall ---")
maile = re.findall(r'[\w\.-]+@[\w\.-]+', tekst_bazowy)
print(f"Znalezione maile: {maile}")

print("\n--- 2. re.split ---")
czesci = re.split(r'[ ,.]+', tekst_bazowy)
print(f"Podzielony tekst: {czesci[:5]}...")

print("\n--- 3. re.sub ---")
zamieniony = re.sub(r'\d', 'X', tekst_bazowy)
print(f"Po zamianie: {zamieniony}")

print("\n--- 4. re.search ---")
szukaj = re.search(r'\d+\.\d+', tekst_bazowy)
if szukaj:
    print(f"Pierwsza znaleziona kwota: {szukaj.group()} (pozycja: {szukaj.start()})")

print("\n--- 5. re.match ---")
dopasowanie_poczatku = re.match(r'Kontakt', tekst_bazowy)
print(f"Czy zaczyna się od 'Kontakt'?: {'Tak' if dopasowanie_poczatku else 'Nie'}")

print("\n--- 6. re.fullmatch ---")
kod = "12-345"
czy_kod_poprawny = re.fullmatch(r'\d{2}-\d{3}', kod)
print(f"Czy '{kod}' to poprawny format kodu?: {'Tak' if czy_kod_poprawny else 'Nie'}")

print("\n--- 7. re.finditer ---")
print("Znalezione liczby i ich lokalizacje:")
for m in re.finditer(r'\d+', tekst_bazowy):
    print(f" - Liczba: {m.group()}, Start: {m.start()}, Koniec: {m.end()}")

print("\n--- 8. re.escape ---")
problemowy_string = "Czy to kosztuje $100.00?"
bezpieczny_wzorzec = re.escape(problemowy_string)
print(f"Oryginał: {problemowy_string}")
print(f"Wzorzec po re.escape: {bezpieczny_wzorzec}")

czy_znaleziono = re.search(bezpieczny_wzorzec, "Tak, Czy to kosztuje $100.00? Oczywiście.")
print(f"Czy znaleziono dosłowny tekst?: {'Tak' if czy_znaleziono else 'Nie'}")