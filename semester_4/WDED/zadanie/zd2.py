import pandas as pd

filePath = 'zakupy-online.xlsx'

dataFrame0910 = pd.read_excel(filePath, sheet_name="Year 2009-2010")
dataFrame1011 = pd.read_excel(filePath, sheet_name="Year 2010-2011")

dataFrame0911 = pd.concat([dataFrame0910, dataFrame1011], ignore_index=True)

dataFrame0911 = dataFrame0911.dropna(subset=['Customer ID'])
dataFrame0911 = dataFrame0911[dataFrame0911['Quantity'] >= 0]

print(dataFrame0911)
