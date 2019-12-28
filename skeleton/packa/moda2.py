print("moda2 imported")
from pprint import pprint
from moda0 import Moda0

class Moda2(Moda0):

	def __init__(self,*a,**kw):
		print("class Moda2",a,kw)

if __name__ == "__main__":
	o = Moda2("x","y",k1="v1")
	o.printself()
	pprint(o)
