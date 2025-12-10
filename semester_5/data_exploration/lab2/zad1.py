# Napisz program który odczytuje tablicę danych rezygnacje.csv oraz wybiera z niej wszystkie wiersze oraz
#kolumny: CZAS_POSIADANIA, PLAN_MIEDZY, POCZTA_G, L_WIAD_POCZTA_G, L_POL_BIURO, REZYGN.
#Następnie wykonuje szereg eksperymentów z tworzeniem klasyfikatorów i testowaniem ich metodą Train&Test, przy czym
#jest to zawsze klasyfikator k-NN (te same parametry tworzenia) występujący w powyższych 2 przykładach przy
#atrybucie decyzyjnym 'REZYGN'. Eksperymenty są wykonywane przy następującyh wielkościach tablicy
#treningowej: 90%, 80%, 70%, 60%, 50%, 40%, 30%, 20% i 10%.
#Oczywiście, jeśli np. tablica treningowa liczy 70% całych danych, to tablica testowa liczy 100% - 70% = 30%.
#Wykonać wykres porównujący jakości klasyfikacji (accuracy) dla wszystkich eksperymemntów i wyciągnąć wniosek
#czy i jak proporcja podziału danych ma wpływ na jakośc klasyfikacji. Odpowiedni wniosek zapisać słownie
#w komentarzu na końcu komórki z rozwiązaniem.

import numpy as np
import pandas as pd
from networkx.classes import neighbors
from sklearn import metrics, datasets
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix

data = pd.read_csv('../praca_wlasna2/rezygnacje.csv')

column_number = data.shape[1]
row_number = data.shape[0]

print(f"Liczba kolumn: {column_number}")
print(f"Liczba wierszy: {row_number}")

value_attributes = data.iloc[:,column_number-1]
decision_attribute = data.iloc[:,[column_number-1]]

neighbors_number = 5
metric = 'euclidean'

train_size = [0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1]

for i in train_size:
    print(f"Wartości dla wielkosci testu : {i}")
    datasets = train_test_split(value_attributes, decision_attribute, test_size=i, random_state=1234)

    x_train, x_test, y_train, y_test = datasets


    model = KNeighborsClassifier(n_neighbors=neighbors_number, metric=metric)
    model.fit(x_train, np.ravel(y_train))  

    labels_predicted = model.predict(x_test)

    accuracy = metrics.accuracy_score(y_test, labels_predicted)

    print("Dokładnośc klasyfikacji=", accuracy)