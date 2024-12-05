from sympy import Matrix

A = [[2, 3, 1],
     [4, 7, 7],
     [6, 18, 22]]

# Wektor prawej strony b
b = [5, 6, 8]

def gauss(A, b):
    # Tworzymy rozszerzoną macierz [A | b]
    roz_matrix = Matrix(A).row_join(Matrix(b))

    # Obliczamy postać schodkową  (RREF) macierzy
    rref_matrix, _ = roz_matrix.rref()  # rref() zwraca macierz RREF i listę pivotów

    # Wyciągamy ostatnią kolumnę macierzy RREF, która zawiera rozwiązania
    rozw = rref_matrix[:, -1]

    return list(rozw)

rozw = gauss(A, b)
print("Rozwiązanie układu Ax = b:", rozw)









"""
1. Macierz A (kwadratową, np. 3x3) rozbijamy na dwie prostsze macierze:
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