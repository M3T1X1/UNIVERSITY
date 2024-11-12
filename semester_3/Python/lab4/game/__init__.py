from abc import ABC, abstractmethod


class Item(ABC):
    def __init__(self, name: str, price: float):
        if name is None:
            raise ValueError("Podaj nazwe")
        if price < 0:
            raise ValueError("Cena musi być większa bądź równa 0")

        self._name = name
        self._price = price

    @property
    def name(self):
        return self._name

    @property
    def price(self):
        return self._price

    @price.setter
    def price(self, value: float):
        if value < 0:
            raise ValueError("Cena przedmiotu nie może być ujemna.")
        self._price = value

    @abstractmethod
    def get_info(self):
        print(self.name, self.price)

    def __lt__(self, other):
        if isinstance(other, Item):
            return self.name < other.name

    def __le__(self, other):
        if isinstance(other, Item):
            return self.name <= other.name

    def __gt__(self, other):
        if isinstance(other, Item):
            return self.name > other.name

    def __ge__(self, other):
        if isinstance(other, Item):
            return self.name >= other.name

