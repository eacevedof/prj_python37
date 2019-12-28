print("moda0 imported")
from pprint import pprint

class Moda0:

	def __init__(self, *l, **d):
		print("class Moda0.__init__",l,d)
		self.x = l[0]
		self.y = l[1]
		print("l?",l,"d?",d)
		self.k1 = d["k1"]

	def printself(self):
		print("PRINT SELF:\n self.x:",self.x,"self.y:",self.y,"self.k1",self.k1)

if __name__ == "__main__":
	# pass
	o = Moda0("x","y",k1="v1")
	o.printself()
	# pprint(o)


