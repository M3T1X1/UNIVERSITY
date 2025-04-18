import pandas as pd

filePath = 'zakupy-online.xlsx'

dataFrame0910 = pd.read_excel(filePath, sheet_name="Year 2009-2010")
dataFrame1011 = pd.read_excel(filePath, sheet_name="Year 2010-2011")

dataFrame0911 = pd.concat([dataFrame0910, dataFrame1011], ignore_index=True)

#kraje i ich ilość
customerNationality = dataFrame0911['Country'].unique()
nationalityCount = len(customerNationality)

#print(f"Liczba krajów: {nationalityCount}")
#print(customerNationality)

"""
United Kingdom' 'France' 'USA' 'Belgium' 'Australia' 'EIRE' 'Germany'
 'Portugal' 'Japan' 'Denmark' 'Nigeria' 'Netherlands' 'Poland' 'Spain'
 'Channel Islands' 'Italy' 'Cyprus' 'Greece' 'Norway' 'Austria' 'Sweden'
 'United Arab Emirates' 'Finland' 'Switzerland' 'Unspecified' 'Malta'
 'Bahrain' 'RSA' 'Bermuda' 'Hong Kong' 'Singapore' 'Thailand' 'Israel'
 'Lithuania' 'West Indies' 'Lebanon' 'Korea' 'Brazil' 'Canada' 'Iceland'
 'Saudi Arabia' 'Czech Republic' 'European Community'
 
 Liczba krajów: 43
"""
#najlepsze produkty
countProducts = dataFrame0911['Description'].value_counts()
top5MostFrequentylBoughtProducts = countProducts.head(5)

#print(f"Najczęściej kupowane produkty: {top5MostFrequentylBoughtProducts}")

"""
Najczęściej kupowane produkty: Description
WHITE HANGING HEART T-LIGHT HOLDER    5918
REGENCY CAKESTAND 3 TIER              4412
JUMBO BAG RED RETROSPOT               3469
ASSORTED COLOUR BIRD ORNAMENT         2958
PARTY BUNTING                         2765
"""

#zmienność liczby transakcji
dataFrame0911['InvoiceDate'] = pd.to_datetime(dataFrame0911['InvoiceDate'])
transactionsPerEachMonth = dataFrame0911.groupby(dataFrame0911['InvoiceDate'].dt.to_period('M')).size()

#print(f"Liczba transakcji w każdym miesiącu: {transactionsPerEachMonth}")

"""
Liczba transakcji w każdym miesiącu: InvoiceDate
2009-12    45228
2010-01    31555
2010-02    29388
2010-03    41511
2010-04    34057
2010-05    35323
2010-06    39983
2010-07    33383
2010-08    33306
2010-09    42091
2010-10    59098
2010-11    78015
2010-12    65004
2011-01    35147
2011-02    27707
2011-03    36748
2011-04    29916
2011-05    37030
2011-06    36874
2011-07    39518
2011-08    35284
2011-09    50226
2011-10    60742
2011-11    84711
2011-12    25526
"""

#najwyższe transakcje w danym miesiącu

dataFrame0911['month'] = dataFrame0911['InvoiceDate'].dt.to_period('M')

# Znalezienie maksymalnej wartości transakcji w każdym miesiącu
maxTransactionsPerMonth = dataFrame0911.groupby('month')['Price'].max()
highestTransactionMonth = transactionsPerEachMonth.idxmax()

#print(f"Miesiąc z najwyższą transakcją: {highestTransactionMonth}")

"""
Najwyższe transakcje w każdym miesiącu: month
2009-12     1998.49
2010-01     8985.60
2010-02     1508.65
2010-03    10953.50
2010-04     5876.34
2010-05     2396.61
2010-06    25111.09
2010-07     3610.50
2010-08    18910.69
2010-09    10468.80
2010-10    10468.80
2010-11     6706.71
2010-12    13541.33
2011-01    16888.02
2011-02     5575.28
2011-03     5693.05
2011-04     2382.92
2011-05     8142.75
2011-06    38970.00
2011-07     6497.47
2011-08    11062.06
2011-09     7427.97
2011-10     5942.57
2011-11     8286.22
2011-12    17836.46
"""

#na jakich artykułach najwięcej zarobiono

dataFrame0911['calosc'] = dataFrame0911['Quantity'] * dataFrame0911['Price']

salesGrouped = dataFrame0911.groupby('Description')['calosc'].sum()
salesGroupedAndSorted = salesGrouped.sort_values(ascending=False)
top5Sales = salesGroupedAndSorted.head(5)

#print(f"5 produktów na których zarobiono najwięcej: {top5Sales}")

"""
5 produktów na których zarobiono najwięcej: Description
REGENCY CAKESTAND 3 TIER              327813.65
DOTCOM POSTAGE                        322647.47
WHITE HANGING HEART T-LIGHT HOLDER    257533.90
JUMBO BAG RED RETROSPOT               148800.64
PARTY BUNTING                         147948.50
"""