
list_a = [1, 2, 3]
list_b = [2, 3, 4]

listaNowa =[]



for i in range(list_a.__len__()):
    for j in range(list_b.__len__()):
        if list_a[i] == list_b[j]:
            listaNowa.append(list_a[i])

for i in range(listaNowa.__len__()):
    print(listaNowa[i])