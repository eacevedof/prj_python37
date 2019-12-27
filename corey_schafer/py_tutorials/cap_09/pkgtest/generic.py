# generic.py
print("pkgtest.generic.py")

import sys
from pprint import pprint

def argskwargs(*args,**kwargs):
	print("args:\n")
	print(args)
	print("kwargs:\n")
	print(kwargs)

def syspath():
	print(sys.path)