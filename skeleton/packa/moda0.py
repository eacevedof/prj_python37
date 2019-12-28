print("moda0 imported")
from pprint import pprint

class Moda0:

	def __init__(self,*a,**kw):
		print("class Moda0",a,kw)
		self.x = a[1]
		self.y = a[2]
		self.k1 = kw["k1"]
		print(self.x,self.y,self.k1)


if __name__ == "__main__":
	o = Moda0("a","x","y",k1="v1")
	pprint(o)


