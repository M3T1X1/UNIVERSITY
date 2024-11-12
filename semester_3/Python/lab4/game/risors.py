from __init__ import Item

class Resource(Item):
   def get_info(self):
       return f"Zasob: {self.name}, cena: {self.price}"


