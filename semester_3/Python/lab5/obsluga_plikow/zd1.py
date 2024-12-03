import os

def main():
    username = input("Enter username: ")
    password = input("Enter password: ")

    while True:
        command = input("Input command: ")
        parts = command.split(" ", 2)
        action = parts[0]
        args = parts[1:]

        if action == "read" and args:
            try:
                with open(args[0], "r") as file:
                    print(file.read())
            except FileNotFoundError:
                print(f"File '{args[0]}' has not been found.")

        elif action == "write" and len(args) > 1:
            try:
                with open(args[0], "w") as file:
                    file.write(args[1].strip('"'))
                print(f"File written '{args[0]}' ")
            except Exception as e:
                print(f"Error : {e}")

        elif action == "append" and len(args) > 1:
            try:
                with open(args[0], "a") as file:
                    file.write(args[1].strip('"') + "\n")
                print(f"Appended to file '{args[0]}' ")
            except Exception as e:
                print(f"Error:{e}")

        elif action == "delete" and args:
            try:
                os.remove(args[0])
                print(f"File '{args[0]}' deleted ")
            except FileNotFoundError:
                print(f"File '{args[0]}' not found")

        elif action == "quit":
            print("Exiting ")
            break

        else:
            print("Unknown command")

if __name__ == "__main__":
    main()
