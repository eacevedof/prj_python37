print("moda2 imported")
from pprint import pprint
from moda0 import Moda0

class Moda2(Moda0):

	def __init__(self,*a,**kw):
		print("class Moda2",a,kw)
		self.k1 = kw["k1"]

if __name__ == "__main__":
	o = Moda2("x2","y2",k1="m2")
	o.printself()
