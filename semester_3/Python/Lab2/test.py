words = ["listen", "silent", "enlist", "inlets", "hello", "below", "elbow"]
anagramy = {}

for word in words:
    klucz = ''.join(sorted(word))

    if klucz in anagramy:
        anagramy[klucz].add(word)
    else:
        anagramy[klucz] = {word}

slownik_anagramow = {word: anagramy[''.join(sorted(word))] - {word} for word in words}

print(slownik_anagramow)
