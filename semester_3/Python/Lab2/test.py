elements = [1, "2", None, 0, False, True, 4, "3", 4, 3, False]
count_dict = {}

for elem in elements:
    key = (elem, type(elem))
    if key in count_dict:
        count_dict[key] += 1
    else:
        count_dict[key] = 1

print(count_dict)
