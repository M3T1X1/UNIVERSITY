import pandas as pd

rawData =open("SMSSpamCollection.tsv").read()
rawData[0:20]

parsedData = rawData.replace('\t', '\n').split('\n')
parsedData[0:5]

labelList = parsedData[0::2]
textList = parsedData[1::2]

korpus = pd.DataFrame({
    "label": labelList,
    "text": textList
})

print(korpus.head())