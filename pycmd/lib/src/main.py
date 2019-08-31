import os
import sys
# framework de linea de comandos
import click
from pprint import pprint

from src.components.component_log import lg
from src.commands import cmdregex as regex
from src.commands import cmdprueba as prueba
from colorama import init
init()

ROOT_PATH = os.path.dirname(__file__)
CLIENTS_TABLE = ROOT_PATH +"/"+ ".clients.csv"

def print_format_table():
    """
    https://stackoverflow.com/questions/287871/how-to-print-colored-text-in-terminal-in-python
    prints table of formatted text format options
    """
    for style in range(8):
        for fg in range(30,38):
            s1 = ''
            for bg in range(40,48):
                format = ';'.join([str(style), str(fg), str(bg)])
                s1 += '\x1b[%sm %s \x1b[0m' % (format, format)
            print(s1)
        print('\n')

@click.group()
@click.pass_context
def shell(context):
    lg("shell","titulo")
    # click.clear()
    # diccionario
    # pprint(context)
    context.obj = {}
    # print_format_table()

# se inyecta en el grupo cli todos los comandos de clientes
shell.add_command(regex.funcsgroup)
shell.add_command(prueba.funcsgroup)

# pycmd regex matchfile
#if __name__ == "__main__":
#    shell()