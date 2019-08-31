# print("commands/cmdregex.py")
# ejecucion: pycmd regex matchfile
import os
import sys
from pprint import pprint
from pathlib import Path

import click

from contextlib import contextmanager
from src.components.component_file import fopen
from src.components.component_log import lg

#clic_group convierte a regex en otro decorador
@click.group()
# esto se llamaría desde 
# pycmd regex
def regex():
    # esto se mostrará al ejecutar pycmd
    """
    trabaja con ficheros y hace busquedas guardando el resultado en otro fichero
    """
    pass
#def regex()

@regex.command()
@click.option("-o","--opt",type=str,prompt=True,help="")
def matchfile(opt):
    click.secho(opt,fg="green",bg="blue")
    """Matchfile"""
    click.echo("find pattern")
    regex          = click.prompt("Reg. Exp", type=str, default="[\d]+love")
    pathfilefrom   = click.prompt("Path file from", type=str, default="/path/of/origin/file.ext")
    pathfileto     = click.prompt("Path file to", type=str, default="/path/of/destiny/file.ext")

    try:
        with fopen(pathfilefrom) as f:
            contents = f.read()
    except NameError:
        print("an exception NameError")
    except Exception as e:
        s = str(e)
        print(s)

    # print(contents)
    if not os.path.isfile(pathfileto):
        if not os.access(pathfileto, os.R_OK):
            print("no access to "+pathfileto)
            return 
        else:
            print("with access")
            try:
                f = open(pathfileto)
                f.close()
            except FileNotFoundError:
                print("File "+pathfileto+" was not able to create")

    print("trying to write")
    with fopen(pathfileto,"w") as f:
        print("writing...")
        try:
            f.write(contents)
        except Exception:
            print("Error al escribir en "+pathfileto)

    # C:\Users\ioedu\Desktop\tmp.js
    # C:\Users\ioedu\Desktop\tmp_2.js
    # C:\Users\ioedu\Desktop\temp.sql

#def matchfile

# funcsgroup son todos los comandos (funciones)
funcsgroup = regex