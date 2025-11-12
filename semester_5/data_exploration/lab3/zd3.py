import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import LeaveOneOut
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt

df = pd.read_csv('diabetes.csv')

X = df.drop(columns=['decision'])
y = df['decision']

k_values = list(range(2, 20))
accuracies = []

loo = LeaveOneOut()

for k in k_values:
    knn = KNeighborsClassifier(n_neighbors=k, metric='euclidean')
    y_true, y_pred = [], []

    for train_index, test_index in loo.split(X):
        X_train, X_test = X.iloc[train_index], X.iloc[test_index]
        y_train, y_test = y.iloc[train_index], y.iloc[test_index]

        knn.fit(X_train, y_train)
        y_pred.append(knn.predict(X_test)[0])
        y_true.append(y_test.values[0])

    accuracy = accuracy_score(y_true, y_pred)
    accuracies.append(accuracy)

plt.figure(figsize=(10, 6))
plt.plot(k_values, accuracies, marker='o')
plt.title('Dokładność Leave-One-Out')
plt.xlabel('Liczba sąsiadów k')
plt.ylabel('Dokładność')
plt.grid(True)
plt.show()

