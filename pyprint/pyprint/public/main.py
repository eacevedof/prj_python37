import sys
import os

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
#pathsrc = os.path.abspath("../src")
#print("pathsrc:"+pathsrc)
# sys.exit()
#sys.path.append(pathsrc)
#sys.exit()
"""
/app/public
/usr/local/bin
/usr/local/lib/python38.zip
/usr/local/lib/python3.8
/usr/local/lib/python3.8/lib-dynload
/usr/local/lib/python3.8/site-packages
"""
from src.boot.fastapi import app
