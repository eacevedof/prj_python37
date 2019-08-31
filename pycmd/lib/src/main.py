import os
import sys
# framework de linea de comandos
import click
from pprint import pprint

from src.commands import cmdregex as regex
from src.commands import cmdprueba as prueba

ROOT_PATH = os.path.dirname(__file__)
CLIENTS_TABLE = ROOT_PATH +"/"+ ".clients.csv"

@click.group()
@click.pass_context
def shell(context):
    # diccionario
    context.obj = {}

# se inyecta en el grupo cli todos los comandos de clientes
shell.add_command(regex.funcsgroup)
shell.add_command(prueba.funcsgroup)

#if __name__ == "__main__":
#    shell()