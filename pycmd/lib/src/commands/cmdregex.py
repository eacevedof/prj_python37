# print("commands/cmdregex.py")
# ejecucion: pycmd regex matchfile
import os
import sys
from pprint import pprint
from pathlib import Path

import click

from contextlib import contextmanager
from src.components.file import fopen

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
    click.clear()
    click.echo(b'\xe2\x98\x83', nl=False)
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

@regex.command()
@click.option("-n","--name",type=str,prompt=True,help="The client's name")
@click.option("-c","--company",type=str,prompt=True,help="The client's company")
@click.option("-e","--email",type=str,prompt=True,help="The client's email")
@click.option("-p","--position",type=str,prompt=True,help="The client's position")
@click.pass_context
def create(context,name,company,email,position):
    """Creates a new client"""
    oClient = Client(name,company,email,position)
    #print(context.obj["clients_table"])
    #print(dir(oClient))
    #pprint(vars(oClient))
    #print(os.path.realpath(__file__))
    #sys.exit()
    sPathFile = context.obj["clients_table"]
    # print("File to open: {}".format(sPathFile))
    client_service = ClientService(sPathFile)
    # pprint(client_service)
    client_service.create_client(oClient)

@regex.command()
@click.pass_context
def list(context):
    """List all clients"""
    oClientServ = ClientService(context.obj["clients_table"])
    lstClients = oClientServ.list_regex()

    print(" ID | NAME | COMPANY | EMAIL | POSITION")
    click.echo("*" * 100)
    for dicClient in lstClients:
        click.echo("{uid} | {name} | {company} | {email} | {position} | ".format(
            uid = dicClient["uid"],
            name = dicClient["name"],
            company = dicClient["company"],
            email = dicClient["email"],
            position = dicClient["position"]
        ))

def _update_client_flow(oClient):
    click.echo("Leafe empty if you dont want to modify the value")

    oClient.name        = click.prompt("New name", type=str, default=oClient.name)
    oClient.company     = click.prompt("New company", type=str, default=oClient.company)
    oClient.email       = click.prompt("New email", type=str, default=oClient.email)
    oClient.position    = click.prompt("New position", type=str, default=oClient.position)
    return oClient

@regex.command()
@click.argument("client_uid",type=str)
@click.pass_context
def update(context,client_uid):
    """Updates a client"""
    oClientServ = ClientService(context.obj["clients_table"])
    lstClient = oClientServ.list_regex()
    # print(lstClient)
    # sys.exit()
    dicClient = [dicClient for dicClient in lstClient if dicClient["uid"] == client_uid]
    # pprint(dicClient)
    # pprint(dicClient[0])
    # pprint(**dicClient[0])

    if dicClient:
        oClient = _update_client_flow(Client(**dicClient[0]))
        oClientServ.update_client(oClient)
        click.echo("Client updated!")
    else:
        click.echo("Client not found")

# funcsgroup son todos los comandos (funciones)
funcsgroup = regex