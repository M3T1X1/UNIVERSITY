import pandas as pd
from sklearn.model_selection import GridSearchCV, train_test_split
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.linear_model import LogisticRegression

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
pd.set_option('display.max_colwidth', None)
pd.set_option('display.width', 1000)

data = pd.read_csv('SMSSpamCollection.tsv', sep='\t', names=['label', 'text'])

X_train, X_test, Y_train, Y_test = train_test_split(data['text'], data['label'], test_size=0.3, random_state=42)

pl = Pipeline([
    ('vect', CountVectorizer()),
    ('clf', LogisticRegression(max_iter=1000))
])


params = [
    {
        'vect' : [CountVectorizer()],
        'vect__ngram_range' : [(1,1), (1,2)],
    },
    {
        'vect' : [TfidfVectorizer()],
        'vect__ngram_range' : [(1,1), (1,2)],
    }
]

grid = GridSearchCV(pl, params, cv=5, n_jobs=-1, verbose=1)
grid.fit(X_train, Y_train)

result = pd.DataFrame(grid.cv_results_)
result_disp = result[[
    'params',
    'mean_test_score',
    'std_test_score',
    'mean_fit_time',
    'std_fit_time',
    'rank_test_score'
]]

result_disp = result_disp.sort_values(by='rank_test_score', ascending=True)

print(result_disp)