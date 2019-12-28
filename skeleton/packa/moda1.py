print("moda1 imported")
from pprint import pprint
from moda0 import Moda0

class Moda1(Moda0):
	def __init__(self,*a,**kw):
		print("class Moda1.__init__",a,kw)
		# super().__init__(a, kw) # NO!
		# super().__init__(self, a, kw) # NO!
		super().__init__(*a, **kw)

if __name__ == "__main__":
	o = Moda1("x1","y1",k1="m1")
	o.printself()
	#pprint(o)
