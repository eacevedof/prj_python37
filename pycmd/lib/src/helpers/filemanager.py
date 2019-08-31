# print("helpers/filemanager.py")
from contextlib import contextmanager

@contextmanager
def fopen(filename, opt="r"):
    f = open(filename, opt)
    try:
        yield f
    finally:
        f.close()
#fopen

