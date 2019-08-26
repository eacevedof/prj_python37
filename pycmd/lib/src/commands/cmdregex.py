# print("commands/cmdregex.py")
import os
import sys
from pprint import pprint

import click

#clic_group convierte a clients en otro decorador
@click.group()
def cmdgroup():
    """Manages the clients lifecycle"""
    pass

@cmdgroup.command()
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

@cmdgroup.command()
@click.pass_context
def list(context):
    """List all clients"""
    oClientServ = ClientService(context.obj["clients_table"])
    lstClients = oClientServ.list_cmdgroup()

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

@cmdgroup.command()
@click.argument("client_uid",type=str)
@click.pass_context
def update(context,client_uid):
    """Updates a client"""
    oClientServ = ClientService(context.obj["clients_table"])
    lstClient = oClientServ.list_cmdgroup()
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

# alloptions son todos los comandos (funciones)
allfuncs = cmdgroup