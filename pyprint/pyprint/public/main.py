#!/usr/bin/python
import bootstrap
import uvicorn

pr("public/main.py",":o)  ")
from src.routes.all import *


if __name__ == "__main__":
    #uvicorn.run(app, host="0.0.0.0", port=5678)
    uvicorn.run(app, host="0.0.0.0", port=8081)