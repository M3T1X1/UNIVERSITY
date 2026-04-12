import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer


df = pd.read_csv('SMSSpamCollection.tsv', sep='\t', names=['label', 'message'])

sample_data = df['message'].head(10).tolist()

cv = CountVectorizer(stop_words='english')
cv_matrix = cv.fit_transform(sample_data)
df_cv = pd.DataFrame(cv_matrix.toarray(), columns=cv.get_feature_names_out())

print("COUNT VECTORIZER")
print(df_cv.iloc[:, :8])
print("\n" + "="*60 + "\n")

ngram_cv = CountVectorizer(ngram_range=(2, 2), stop_words='english')
ngram_matrix = ngram_cv.fit_transform(sample_data)
df_ngram = pd.DataFrame(ngram_matrix.toarray(), columns=ngram_cv.get_feature_names_out())

print("N-GRAM")
print(df_ngram.iloc[:, :5])
print("\n" + "="*60 + "\n")


tfidf = TfidfVectorizer(stop_words='english')
tfidf_matrix = tfidf.fit_transform(sample_data)
df_tfidf = pd.DataFrame(tfidf_matrix.toarray(), columns=tfidf.get_feature_names_out())

print("TF-IDF")
print(df_tfidf.iloc[:, :8].round(3))