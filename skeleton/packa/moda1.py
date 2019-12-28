print("moda1 imported")

from .moda0 import Moda0

class Moda1(Moda0):
	def __init__(self,*a,**kw):
		print("class Moda1",a,kw)