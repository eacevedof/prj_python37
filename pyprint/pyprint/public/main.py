import sys
import os


from debug import debugpy_start

debugpy_start()

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.routes.all import *


if __name__=="__main__":
    uvicorn.run("app.app:app",host='0.0.0.0', port=8080, reload=True, debug=True, workers=3)