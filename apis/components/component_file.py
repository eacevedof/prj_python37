# print("components/component_file.py")
from contextlib import contextmanager

@contextmanager
def fopen(pathfile, opt="r"):
    f = open(pathfile, opt)
    try:
        yield f
    finally:
        f.close()
#fopen

def fwrite(pathfile, strcontent):
    with fopen(pathfile,"a") as f:
        f.write(strcontent)
#fwrite

def foverwrite(pathfile, strcontent):
    with fopen(pathfile,"w") as f:
        f.write(strcontent) 
#foverwrite

def get_content(pathfile):
    return open(pathfile,'r').read()
# get_content