#!/usr/bin/python
import builtins
import sys
import os
import uvicorn
import pathlib

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

pathpublic = pathlib.Path(__file__).parent.absolute()
pr(pathpublic,"pathpublic")

pathroot = os.path.abspath(pathpublic.parent)
pr(pathroot,"pathroot 2")

#pathroot = os.path.abspath("..") # asi funciona sin debug de vscode y apunta a pyprint/pyptint
#pd(pathroot,"pathroot old")

sys.path.append(pathroot)
from src.routes.all import *

if __name__ == "__main__":
    #uvicorn.run(app, host="0.0.0.0", port=5678)
    uvicorn.run(app, host="0.0.0.0", port=8080)