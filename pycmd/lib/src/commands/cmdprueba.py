# print("commands/cmdfnprueba.py")
import os
import sys
from pprint import pprint
from pathlib import Path

import click
from contextlib import contextmanager

#clic_group convierte a fnprueba en otro decorador
@click.group()

# pycmd fnprueba
def fnprueba():
    """
    trabaja con ficheros y hace busquedas guardando el resultado en otro fichero
    """
    pass

# funcsgroup son todos los comandos (funciones)
funcsgroup = fnprueba