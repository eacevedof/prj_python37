import os
import sys
# framework de linea de comandos
import click
# mis librerias
from src.bootstrap.builtins_ext import *        #inyecta en builtin
from src.components.component_log import *
from src.commands import cmd_regex as cmdregex
from src.commands import cmd_prueba as cmdprueba

@click.group()
@click.pass_context
def shell(context):

    x = 0
    bug(context)
    diefalsy(x,"context")
    pr("hola x")
    # lgsql("shell","titulo",1)
    # lgerr("shell","titulo err",1)
    # lgd("shell","titulo debug",1)
    #click.clear()
    # diccionario
    # pprint(context)
    context.obj = {}
    # print_format_table()

# se inyecta en el grupo cli todos los comandos de clientes
shell.add_command(cmdregex.funcsgroup)
shell.add_command(cmdprueba.funcsgroup)

# pycmd regex matchfile
#if __name__ == "__main__":
#    shell()