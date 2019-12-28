print("moda2 imported")
from pprint import pprint
from packa.moda0 import Moda0
from packb.modb1 import ModB1

class Moda2(Moda0):

	def __init__(self,*a,**kw):
		print("class Moda2",a,kw)
		self.k1 = kw["k1"]

	def showmodb1(self):
		o = ModB1()
		o.foo("tradicional")
		o.class_foo("metodo de clase")
		o.static_foo("metodo estatico")
		

if __name__ == "__main__":
	o = Moda2("x2","y2",k1="m2")
	o.printself()
