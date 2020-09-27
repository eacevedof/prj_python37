# hack para importar 
#if __name__ == "__main__" and __package__ is None:
import sys
from sys import path
from os.path import dirname as dir

# print(path[0]); sys.exit()
path.append(dir(path[0]))
# __package__ = "core"