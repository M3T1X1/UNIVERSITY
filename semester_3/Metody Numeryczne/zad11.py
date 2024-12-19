from sympy import Matrix

A = [[4, 1, 3],
     [2, 5, 6],
     [12, 8, 3]]

# Wektor prawej strony b
b = [7, 5, 8]

def gauss(A, b):
    # Tworzymy rozszerzoną macierz
    macierzRozszerzona = Matrix(A).row_join(Matrix(b))

    # Obliczamy postać schodkową zredukowaną macierzy
    # Druga wartość (lista indeksów pivotów) jest ignorowana, ponieważ _ oznacza że nie potrzebujemy jej do dalszych obliczeń
    # Pivot to pierwszy niezerowy element w każdym wierszu macierzy po lewej stronie, gdy macierz jest przkształcana w postać schodkową
    macierzZredukowana, _ = macierzRozszerzona.rref()  # rref() zwraca macierz zredukowaną i listę pivotów

    # Wyciągamy ostatnią kolumnę macierzy zredukowanej, która zawiera rozwiązania
    #  : Oznacza, że wybieramy wszystkie wiersze macierzy.
    # -1 Oznacza indeks ostatniej kolumny. Indeks -1 w Pythonie oznacza "ostatni element" (działa to również na listach i innych iterowalnych strukturach).
    wynik = macierzZredukowana[:, -1]

    return list(wynik)


rozw = gauss(A, b)
print("Rozwiązanie układu Ax = b:", rozw)


"""
1. Macierz A rozbijamy na dwie prostsze macierze:

- L – macierz dolna, która ma 1 na przekątnej i inne liczby poniżej,
- U – macierz górna, która ma liczby tylko nad przekątną.

2. Rozkład LU:
 - Dla każdego wiersza w macierzy A (od pierwszego do ostatniego):
 - Dla elementów nad przekątną (czyli w macierzy U):
 - Przekształcasz elementy A w U, obliczając je na podstawie wcześniej obliczonych elementów z L i U.
 - Dla elementów poniżej przekątnej (czyli w macierzy L):
 - Obliczasz elementy L, korzystając z tych samych zasad. Elementy w L zależą od wcześniej obliczonych elementów w U.

3. Po rozkładzie są dwie macierze:
 - L (z jedynkami na przekątnej i wartościami poniżej),
 - U (z wartościami tylko nad przekątną).

4. Teraz, gdy są już L i U, rozwiązujemy układ równań Ax = b:
 - Najpierw rozwiązujesz układ Ly = b (tzw. "podstawienie w przód"):
 - Zaczynasz od pierwszego elementu y[0], potem kolejno obliczasz wszystkie pozostałe elementy y[i].
 - Potem rozwiązujesz układ Ux = y (tzw. "podstawienie wsteczne"):
 - Mając wynik y, zaczynasz od ostatniego elementu x[n-1] i kolejno wstecz obliczasz wszystkie elementy x[i].

5. Końcowy wynik to wektor x, który jest rozwiązaniem układu równań Ax = b.
"""