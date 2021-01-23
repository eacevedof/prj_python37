import sys
import os

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.boot.fastapi import app
