import sympy as sp

def interpolacjaLagrangea(wartosciX, wartosciY):
    x = sp.Symbol('X')
    n = len(wartosciX)
    wielomian = 0

    for i in range(n):
        czynnik = wartosciY[i]
        for j in range(n):
            if i != j:
                czynnik *= (x - wartosciX[j]) / (wartosciX[i] - wartosciX[j])
        wielomian += czynnik

    return sp.simplify(wielomian)

# Węzły interpolacji
wartosci_x = [1, 2, 3]
wartosci_y = [5, 7, 6]

# Wyznaczanie wielomianu interpolacyjnego
wielomian = interpolacjaLagrangea(wartosci_x, wartosci_y)
print("Wielomian interpolacyjny:", wielomian)
