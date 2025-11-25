import numpy as np
import pandas as pd

from sklearn import metrics, datasets
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix

# Drzewo losowe charakteryzuje się tym że w przeciwieństwie do drzewa decyzyjnego trenujemy wiele drzew, z czego każde
# otrzymuje tylko próbki początkowe obserwacji, a każdy węzeł (node) analizuje jedynie podzbiór cech podczas
# wybierania najlepszego sposobu rozgałęzienia. Można powiedzieć że las losowych drzew głosuje, aby ustalić prognozowaną klase

data = pd.read_csv("serce.csv")

liczba_kolumn = data.shape[1]
print(f"Ilość: kolumn: {liczba_kolumn}")

wartosci_cech = data.iloc[:, :liczba_kolumn - 1]
wartosc_decyzji = data.iloc[:, liczba_kolumn - 1]

#print(f"Wartości cech''\n:{wartosci_cech}")
#print(f"Wartość decyzji\n{wartosc_decyzji}")

#W tym miejscu dzielimy nasz zbiór danych na część treningową i testową.
datas = train_test_split(wartosci_cech, wartosc_decyzji, test_size=0.6, random_state=1234)

cechy_train = datas[0]
cechy_test = datas[1]
decyzja_train = datas[2]
decyzja_test = datas[3]

# Może być też "entropy"
kryterium = "gini"

# Glebokosc drzewa. Wartość None powoduje, że drzewo będzie się rozrastało aż do
# chwili, gdy wszystkie liście będą jednorodne (składające się z obiektów mających taką samą decyzję).
# Z kolei wartość w postaci liczby całkowitej praktycznie oznacza „przycięcie” drzewa do podanej głębokości
max_glebokosc = 5

#Minimalna liczba obserwacji w węźle, zanim nastąpi jego rozgałęzienie. Jeżeli wartością jest
#liczba całkowita, określa czyste minimum, zaś liczba zmiennoprzecinkowa określa wielkość
#procentową wszystkich obserwacji (domyślnie 2).
my_min_samples_split = 10

#Minimalna liczba obserwacji wymaganych do umieszczenia na liściu (domyślnie 1).
my_min_samples_leaf = 3 # !!!!!! dla 3 jest większa dokładność !!!!!!!!!

#Maksymalna liczba liści.
my_max_leaf_nodes = 30

#Minimalny wymagany spadek niejednorodności (zwieksenie czystości), aby został utworzoby podział węzła
my_min_impurity_decrease = 0.02

#Maksymalna liczba cech uwzględnianych w każdym węźle. Domyślnie będzie to sqrt(p) cech, gdzie p
#to całkowita liczba cech.
my_max_features = 10

#Określenie, czy próbki mają być ze zwracaniem. Wartością domyślną tego parametru jest True.
my_bootstrap = True

#Określenie liczby drzew decyzyjnych do utworzenia. Wartością domyślną tego parametru jest 100.
my_n_estimators = 20

#Okreslenie liczby wykorzystywanych rdzeni podczas obliczeńn_jobs. Przypisanie mu wartości -1
#pozwala na użycie wszystkich dostępnych rdzeni procesora.
my_n_jobs = -1

model = RandomForestClassifier(criterion=kryterium,
                               max_depth=max_glebokosc,
                               min_samples_split=my_min_samples_split,
                               min_samples_leaf = my_min_samples_leaf,
                               max_leaf_nodes = my_max_leaf_nodes,
                               min_impurity_decrease = my_min_impurity_decrease,
                               max_features = my_max_features,
                               bootstrap = my_bootstrap,
                               n_estimators = my_n_estimators,
                               random_state=0, n_jobs=my_n_jobs)

# Uczenie klasyfikatora na części treningowej
model.fit(cechy_train, np.ravel(decyzja_train))

#generowanie decyzji dla części testowej
decyzje_po_uczeniu = model.predict(cechy_test)

dokladnosc = metrics.accuracy_score(decyzja_test, decyzje_po_uczeniu)

print(f"Dokladnosc: {dokladnosc}\n\n")

print("============= WYNIKI KLASYFIKACJI ==========")
report = classification_report(decyzja_test, decyzje_po_uczeniu)
print(report)

print("============ MACIERZ POMYŁEK =============")
macierz_pomylek = confusion_matrix(decyzja_test, decyzje_po_uczeniu)
print(macierz_pomylek)



