import sys


def main(a: int, b: str):
    print(f"{a = }, {b = }")


"""
Bardzo prosty przykłąd przekazywania argumentów wywołania programu
"""
if __name__ == '__main__':
    if len(sys.argv) != 3:
        raise ValueError("Expected 2 program arguments")    # Pierwszy argument to ścieżka do uruchamianego skryptu!

    a = int(sys.argv[1])
    b = sys.argv[2]

    main(a, b)
