import os
import sys
sys.path.append("..")
from pprint import pprint
from components.t import go       # ModuleNotFoundError: No module named 'components'
# from ../components/t.py import go # SyntaxError: invalid syntax
# from apis.components.t import go  # ModuleNotFoundError: No module named 'apis'
# from components import t          # ModuleNotFoundError: No module named 'components'
# import components.t               # ModuleNotFoundError: No module named 'components'
# import apis.components.t          # ModuleNotFoundError: No module named 'apis'
# from .components.t import go      # ModuleNotFoundError: No module named '__main__.components'; '__main__' is not a package
# import .apis.components.t.go      # SyntaxError: invalid syntax
# from ..components.t import go     # ValueError: attempted relative import beyond top-level package

"""
E:.
|   main.py
|   __init__.py
|
+---components
|   |   component_file.py
|   |   component_log.py
|   |   component_request.py
|   |   t.py
|   |   __init__.py
|
\---uploadco
    |   main.py
    |   README.md
    |   __init__.py
    |
    \---config
            .env
            .env_example
"""

if __name__=="__main__":
  print("file: main.py")
  print("os.getcwd(): " + os.getcwd())
  go("this is my uploadco.main.py file")
