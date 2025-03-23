from ucimlrepo import fetch_ucirepo
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# fetch dataset
iris = fetch_ucirepo(id=53)

# data (as pandas dataframes)
x = iris.data.features
y = iris.data.targets

df = pd.DataFrame(x, columns=iris.feature_names)
df['species'] = y

petal_lenght_mean = df.groupby('species').mean()
print(f"Average values:\n{petal_lenght_mean}")

sns.pairplot(df, hue="species", diag_kind="kde")
plt.show()