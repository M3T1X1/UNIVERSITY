import pandas as pd

fullCorpus = pd.read_csv(
    "SMSSpamCollection.tsv", sep='\t', header=None, names=['label', 'text']
)

print(fullCorpus.head())