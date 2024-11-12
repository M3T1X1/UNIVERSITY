from product import Product
from risors import Resource

RadX = Resource(name="RadX",price=5)

nukaCola = Product(name="nukaCola",price=50,required_items=f"{RadX.name}: 3")
shotgunShell = Resource(name="shotgunShell",price=5)

print(nukaCola.get_info())
print(shotgunShell.get_info())