import numpy as np
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier

#Odczytanie tablicy treningowej i testowej
datasetTR_origin = pd.read_csv('rezygnacje.csv') #Odczytanie zbioru danych
datasetTST_origin = pd.read_csv('czy_zrezygnuja.csv')
# wyodrębnienie kolumn: CZAS_POSIADANIA, PLAN_MIEDZY, POCZTA_G, L_WIAD_POCZTA_G, L_POL_BIURO, REZYGN.
datasetTrain = datasetTR_origin[['CZAS_POSIADANIA', 'PLAN_MIEDZY', 'POCZTA_G', 'L_WIAD_POCZTA_G', 'L_POL_BIURO', 'REZYGN']]
datasetTest = datasetTST_origin[['CZAS_POSIADANIA', 'PLAN_MIEDZY', 'POCZTA_G', 'L_WIAD_POCZTA_G', 'L_POL_BIURO']]

noColumn = datasetTrain.shape[1]

features_train = datasetTrain.iloc[:,:noColumn-1] #Część warunkowa tablicy treningowej
labels_train = datasetTrain.iloc[:,[noColumn-1]] #Kolumna decyzyjna tablicy treningowej

features_test = datasetTest #Część warunkowa tablicy testowej

model = KNeighborsClassifier(n_neighbors=3,metric='euclidean')
model.fit(features_train, np.ravel(labels_train)) #Uczenie klasyfikatora

labels_predicted = model.predict(features_test) #Testowanie tablicy testowej

print("Decyzje wygenerowane:",labels_predicted)

res = datasetTest.copy()
res['PRED'] = np.ravel(labels_predicted)
print(res)

res.to_csv('results.csv')
