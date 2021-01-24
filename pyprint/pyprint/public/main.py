import sys
import os

from debug import debugpy_start

debugpy_start()

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.routes.all import *
