import builtins
import sys

def pd(text, title=""):
    if title:
        print(f"\n{title}:")
    print(f"{text}\n")
    sys.exit()

def pr(text, title=""):
    if title:
        print(f"\n{title}:")
    print(f"{text}\n")


builtins.pd = pd
builtins.pr = pr

import sys
import os
import pathlib

pathpublic = pathlib.Path(__file__).parent.absolute()
#pr(pathpublic,"pathpublic")
pathroot = os.path.abspath(pathpublic.parent)
#pr(pathroot,"pathroot 2 debe ser pyprint/pyprint")

sys.path.append(pathroot)