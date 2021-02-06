import builtins
import sys
from pprint import pprint

def pr(text, title=""):
    vtype = type(text)
    if title:
        print(f"\n{title}:")
    if isinstance(text, str):
        print(f"type:{vtype}\n")
        print(f"{text}\n")
    else:
        print(f"type:{vtype}\n")
        pprint(text)


def pd(text, title=""):
    pr(text, title)
    sys.exit()


builtins.pr = pr
builtins.pd = pd


import sys
import os
import pathlib

pathpublic = pathlib.Path(__file__).parent.absolute()
#pr(pathpublic,"pathpublic")
pathroot = os.path.abspath(pathpublic.parent)
#pr(pathroot,"pathroot 2 debe ser pyprint/pyprint")

sys.path.append(pathroot)