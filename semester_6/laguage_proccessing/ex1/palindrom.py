def is_palindrome():
    word = input("Enter a word:")
    if word == word[::-1]:
        return True
    return False

print(is_palindrome())
