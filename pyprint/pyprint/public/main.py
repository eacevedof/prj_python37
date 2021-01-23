from typing import Optional
from fastapi import FastAPI
import sys
import os


#sys.exit()
"""
/app/public
/usr/local/bin
/usr/local/lib/python38.zip
/usr/local/lib/python3.8
/usr/local/lib/python3.8/lib-dynload
/usr/local/lib/python3.8/site-packages
"""


#from ..src.controllers.home_controller import HomeController

app = FastAPI()

@app.get("/")
def read_root():
    #ctrl = HomeController()
    #return ctrl.index()
    paths = []
    for p in sys.path:
        p = os.path.realpath(p)
        paths.append(p)

    return {"hola":"Python Print","paths":paths}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}