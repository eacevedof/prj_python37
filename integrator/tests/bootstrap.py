print("bootstrap.py hack core loader")
# agrega el dicrectorio tests a la ruta de sistema de modo que este pueda ver los otros módulos

# hack para importar 
#if __name__ == "__main__" and __package__ is None:
import sys
from sys import path
from os.path import dirname as dir

# print(path[0]); sys.exit()
path.append(dir(path[0]))
# __package__ = "core"

import warnings

def decorator_warnings(fn_method):
    def fn_final(self, *args, **kwargs):
        #with warnings.catch_warnings():
            #warnings.simplefilter("ignore")
        fn_method(self, *args, **kwargs)
    return fn_final