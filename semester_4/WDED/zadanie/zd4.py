import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules


filePath = 'zakupy-online.xlsx'

dataFrame0910 = pd.read_excel(filePath, sheet_name="Year 2009-2010")
dataFrame1011 = pd.read_excel(filePath, sheet_name="Year 2010-2011")

dataFrame0911 = pd.concat([dataFrame0910, dataFrame1011], ignore_index=True)

dataFrame0911 = dataFrame0911.dropna(subset=['Customer ID'])
dataFrame0911 = dataFrame0911[dataFrame0911['Quantity'] >= 0]

"""
products = (dataFrame0911.groupby(['Invoice','Description'])['Quantity']
        .sum()
        .unstack()
        .fillna(0)
        .map(lambda x: 1 if x > 0 else 0)
        )

sumOfProducts = products.sum() / len(products)
min_sup = sumOfProducts.quantile(0.8)

setsOfProducts = apriori(products, min_support=min_sup, use_colnames=True)
print(f"Częste zbiory produktów: {setsOfProducts}")
"""
#numpy._core._exceptions._ArrayMemoryError: Unable to allocate 307. GiB for an array with shape (558096, 2, 36975) and data type int64

#Zbyt dużo unikalnych przedmiotów, przez co zapotrzebowanie na pamięć jest zbyt duże. W tym wypadku należy ograniczyć ilość przedmiotów

top200Products = dataFrame0911['Description'].value_counts().nlargest(200).index
top200Filtered = dataFrame0911[dataFrame0911['Description'].isin(top200Products)]

products = (top200Filtered
          .groupby(['Invoice', 'Description'])['Quantity']
          .sum()
          .unstack()
          .fillna(0)
          .astype(bool)
         )

sumOfProducts = products.sum() / len(products)
min_sup = sumOfProducts.quantile(0.8)

setsOfProducts = apriori(products, min_support=min_sup, use_colnames=True)
asocsRules = association_rules(setsOfProducts, metric="confidence", min_threshold=0.7)

print(setsOfProducts)
print(asocsRules[['antecedents', 'consequents', 'support', 'confidence', 'lift']])

"""
     support                              itemsets
0   0.042901              (6 RIBBONS RUSTIC CHARM)
1   0.055636         (60 TEATIME FAIRY CAKE CASES)
2   0.083596       (ASSORTED COLOUR BIRD ORNAMENT)
3   0.054911       (BAKING SET 9 PIECE RETROSPOT )
4   0.045612          (CHOCOLATE HOT WATER BOTTLE)
5   0.043658         (GIN + TONIC DIET METAL SIGN)
6   0.040978     (HAND OVER THE CHOCOLATE   SIGN )
7   0.054943               (HEART OF WICKER LARGE)
8   0.056077               (HEART OF WICKER SMALL)
9   0.057717            (HOME BUILDING BLOCK WORD)
10  0.040915   (HOT WATER BOTTLE TEA AND SYMPATHY)
11  0.045675      (JUMBO  BAG BAROQUE BLACK WHITE)
12  0.082335             (JUMBO BAG RED RETROSPOT)
13  0.047724                (JUMBO BAG STRAWBERRY)
14  0.052957   (JUMBO SHOPPER VINTAGE RED PAISLEY)
15  0.054028              (JUMBO STORAGE BAG SUKI)
16  0.046810            (LOVE BUILDING BLOCK WORD)
17  0.062949             (LUNCH BAG  BLACK SKULL.)
18  0.056645                 (LUNCH BAG CARS BLUE)
19  0.047913             (LUNCH BAG RED RETROSPOT)
20  0.059072          (LUNCH BAG SPACEBOY DESIGN )
21  0.049962                  (LUNCH BAG WOODLAND)
22  0.051601     (NATURAL SLATE HEART CHALKBOARD )
23  0.049742  (PACK OF 60 PINK PAISLEY CAKE CASES)
24  0.042491     (PACK OF 72 RETROSPOT CAKE CASES)
25  0.053303     (PAPER CHAIN KIT 50'S CHRISTMAS )
26  0.065502                       (PARTY BUNTING)
27  0.044099        (PLEASE ONE PERSON METAL SIGN)
28  0.056834                             (POSTAGE)
29  0.040253     (RECIPE BOX PANTRY YELLOW DESIGN)
30  0.051412    (RED HANGING HEART T-LIGHT HOLDER)
31  0.104590            (REGENCY CAKESTAND 3 TIER)
32  0.058536        (REX CASH+CARRY JUMBO SHOPPER)
33  0.045927        (SCOTTIE DOG HOT WATER BOTTLE)
34  0.057307      (STRAWBERRY CERAMIC TRINKET BOX)
35  0.045455     (VICTORIAN GLASS HANGING T-LIGHT)
36  0.046652                  (VINTAGE SNAP CARDS)
37  0.154079  (WHITE HANGING HEART T-LIGHT HOLDER)
38  0.055888         (WOODEN FRAME ANTIQUE WHITE )
39  0.052263   (WOODEN PICTURE FRAME WHITE FINISH)
Empty DataFrame
Columns: [antecedents, consequents, support, confidence, lift]
Index: []
"""