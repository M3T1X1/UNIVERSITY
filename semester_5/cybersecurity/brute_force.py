print("---------- Usernames ----------")

for i in range(150):
    if i % 3:
        print("carlos")
    else:
        print("wiener")

print("-------- Passwords --------")

with open('passwds.txt', 'r') as f:
    lines = f.readlines()

i = 0
for passw in lines:
    if i % 3:
        print(passw.strip('\n'))
    else:
        print("peter")
        print(passw.strip('\n'))
        i += 1
    i += 1