# print("commands/cmdfnprueba.py")
import os
import sys
from pprint import pprint
from pathlib import Path

import click
from contextlib import contextmanager

@click.group()
# pycmd fnprueba
def fnprueba():
    """
    Prueba
    """
    pass

# funcsgroup son todos los comandos (funciones)
funcsgroup = fnprueba