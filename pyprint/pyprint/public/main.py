import sys
import os

from debuger import initialize_flask_server_debugger_if_needed

initialize_flask_server_debugger_if_needed()

pathsrc = os.path.abspath("..")
sys.path.append(pathsrc)
from src.routes.all import *
