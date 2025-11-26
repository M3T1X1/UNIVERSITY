import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier

train = pd.read_csv('./dz1_train.csv', sep=';')
test = pd.read_csv('./dz1_test.csv', sep=';')

X_train = train.iloc[:, :-1]
y_train = train.iloc[:, -1]
X_test = test.iloc[:, :-1]
y_test = test.iloc[:, -1]

knn = KNeighborsClassifier(n_neighbors=5, metric='euclidean')
knn.fit(X_train, y_train)
y_pred_knn = knn.predict(X_test)

dt = DecisionTreeClassifier(
    criterion='entropy',
    max_depth=6,
    min_impurity_decrease=0.01
)
dt.fit(X_train, y_train)
y_pred_dt = dt.predict(X_test)

#  - 0 -> (TN, TP)
#  - 1 -> (FN: prawda=1, pred=0)
#  - 5 -> (FP: prawda=0, pred=1)

def oblicz_koszt(y_true, y_pred):
    koszt = 0
    for yt, yp in zip(y_true, y_pred):
        if yt == 1 and yp == 0:      # False Negative
            koszt += 1
        elif yt == 0 and yp == 1:    # False Positive
            koszt += 5
    return koszt

koszt_knn = oblicz_koszt(y_test, y_pred_knn)
koszt_dt = oblicz_koszt(y_test, y_pred_dt)

print(f'Koszt decyzji k-NN: {koszt_knn}')
print(f'Koszt decyzji drzewa: {koszt_dt}')


# Klasyfikator k-NN osiągnął koszt 327,
# natomiast drzewo decyzyjne osiągnęło koszt na poziomie 189.
