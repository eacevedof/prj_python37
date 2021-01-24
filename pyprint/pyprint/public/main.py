#import uvicorn

import sys
import os


# cuando se usa -m public.main
#from .debug import debugpy_start
from debug import debugpy_start

debugpy_start()

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.routes.all import *
#from src.boot.fastapi import app



if __name__=="__main__":
    pass
    #print("running uvicorn :)")
    #uvicorn.run(app, host='0.0.0.0', port=8080, reload=True, debug=True, workers=3, log_level="info")
