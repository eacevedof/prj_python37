import os
import sys
# framework de linea de comandos
import click

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
    # diccionario
    context.obj = {}
    context.obj["clients_table"] = CLIENTS_TABLE

# ejecución sin __name__

cli.add_command(clients_commands.all)

# if __name__ == "__main__":
    # cli.add_command(clients_commands.all)