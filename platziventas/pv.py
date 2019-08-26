import os
import sys
# framework de linea de comandos
import click
from pprint import pprint

#del módulo clients importa commands y llamalo clients_commands
from clients import commands as clients_commands

ROOT_PATH = os.path.dirname(__file__)
CLIENTS_TABLE = ROOT_PATH +"/"+ ".clients.csv"
CLIENTS_TABLE = os.path.realpath(CLIENTS_TABLE)
# print("CLIENTS_TABLE: {}".format(CLIENTS_TABLE))
# sys.exit()

@click.group()
@click.pass_context
def cli(context):
    # print("cli llamado")
    # pprint(context)
    # diccionario
    context.obj = {}
    context.obj["clients_table"] = CLIENTS_TABLE

# se inyecta en el grupo cli todos los comandos de clientes
cli.add_command(clients_commands.all)

"""
1 - Si la app no está instalada:

- Tiene que existir la sentencia 
if __name__ == "__main__":
   cli()

se ejecutaría así:
py <archivo.py> <comando> <opcion>

ejemplo
py pv.py clients

Muestra todas las opciones

$ py pv.py clients create

Permite la interaccion

2 - Si la app está instalada:
    - Para esto se necesita el fichero setup.py configurado
    - Que se haya ejecutado: pip install --editable .

pv clients create
"""
# if __name__ == "__main__":
    # cli()