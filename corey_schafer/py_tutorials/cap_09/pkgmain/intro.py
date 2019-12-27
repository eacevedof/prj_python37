# intro.py
print("pkgmain/intro.py")
# import os

# courses = ["History","Math", "Physics", "CompSci"]

# print(os.getcwd()) # E:\projects\prj_python37\corey_schafer\py_tutorials\cap_09
# print(os.__file__) # E:\programas\python\anaconda3\lib\os.py

# from modtest.generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 10, in <module>
    from modtest.generic import argskwargs,syspath
ModuleNotFoundError: No module named 'modtest'
'''
# from generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 19, in <module>
    from generic import argskwargs,syspath
ModuleNotFoundError: No module named 'generic'
'''
# from pkgtest.generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 28, in <module>
    from pkgtest.generic import argskwargs,syspath
ModuleNotFoundError: No module named 'pkgtest'
'''
# from ..pkgtest.generic import syspath
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 37, in <module>
    from ..pkgtest.generic import syspath
ValueError: attempted relative import beyond top-level package
'''

# Esto es un hack, la solución ortodoxa es trabajar con setup.py
# eso se describe aqui: https://stackoverflow.com/questions/6323860/sibling-package-imports
import sys, os
sys.path.insert(0, os.path.abspath('..'))

from pkgtest.generic import syspath