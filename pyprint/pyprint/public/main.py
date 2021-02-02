#!/usr/bin/python
import sys
import os
import uvicorn

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.routes.all import *

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5678)