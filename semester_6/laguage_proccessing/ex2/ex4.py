import nltk
import pandas as pd
import string
from nltk import word_tokenize
from nltk.corpus import stopwords

nltk.download('punkt_tab')
nltk.download('stopwords')

def remove_punctuation(text):
    return "".join([char for char in text if char not in string.punctuation])

def tokenize(text):
    return word_tokenize(text.lower())

def remove_stopwords(tokens):
    stop_words = set(stopwords.words('english'))
    return [word for word in tokens if word not in stop_words]

data = pd.read_csv('SPAM text message 20170820 - Data.csv', sep=',')

data['Message_Clean'] = data['Message'].apply(remove_punctuation)
data['Message_Token'] = data['Message_Clean'].apply(tokenize)
data['Message_Stopword'] = data['Message_Token'].apply(remove_stopwords)

data.to_csv('po_zmianach.csv', index=False)

print(f"{data['Message_Clean'].head()}\n\n")
print(f"{data['Message_Token'].head()}\n\n")
print(f"{data['Message_Stopword'].head()}\n\n")