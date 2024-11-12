from __init__ import Item
from game.risors import Resource


class Product(Item):
   def __init__(self, name: str, price: float, required_items: Resource):
       super().__init__(name, price)
       self.required_items = required_items

   def get_info(self):
       return f"Produkt: {self.name}, cena: {self.price}, required_items: {self.required_items}"

