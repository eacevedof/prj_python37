import sys
import os
import csv
from pprint import pprint

# print(os.path.realpath(__file__)) 
# sys.exit()

CLIENT_TABLE = "./src/.clients.csv"
#CLIENT_TABLE = ".clients.csv"
CLIENT_SCHEMA = ["name","company","email","position"] 

clients = []

def _initialize_clients_from_storage():
    print("\n LOADING clients from {} ...\n".format(CLIENT_TABLE))

    with open(CLIENT_TABLE, mode='r') as f:
        reader = csv.DictReader(f, fieldnames=CLIENT_SCHEMA)
        for row in reader:
            clients.append(row)
    # print(clients)
    # [OrderedDict([('name', 'mi nombre'), ('company', 'mi compania'), ('email', 'mi email'), ('position', 'mi puesto')])]
# def _initialize_clients_from_storage()

def _save_clients_to_storage():
    tmp_table_name = "{}.tmp".format(CLIENT_TABLE)
    print("SAVING clients into temporal: {}\n".format(tmp_table_name))
    with open(tmp_table_name, mode="w") as f:
        writer = csv.DictWriter(f,fieldnames=CLIENT_SCHEMA)
        writer.writerows(clients)
        print("REMOVING old csv {} ...\n".format(CLIENT_TABLE))
        os.remove(CLIENT_TABLE)
    
    print("RENAMING {} to {}  ...\n".format(tmp_table_name,CLIENT_TABLE))
    os.rename(tmp_table_name,CLIENT_TABLE)
    
def _get_idx_by_name(client_name):
    return (next((i for (i,item) in enumerate(clients) if item["name"]==client_name),None))

def list_clients():
    #print("clients:") 
    #print(clients)
    iWith = 70
    print("")
    print("="*iWith)
    for idx, dicClient in enumerate(clients):
        print('{uid} | {name} | {company} | {email} | {position}'
            .format(
                uid = idx,
                name = dicClient["name"],
                company = dicClient["company"],
                email = dicClient["email"],
                position = dicClient["position"]
            ))
    print("="*iWith)
    print("")
#def list_clients()

def create_client(dicClient):
    global clients
    if dicClient not in clients:
        clients.append(dicClient)
    else:
        print('Client already is in the client\'s list')

def update_client(client_name, new_name):
    # global clients
    # next(item for item in clients if(item["name"] == client_name))
    idx = _get_idx_by_name(client_name)
    if idx!=None :
        # print(dir(clients[idx]))
        # tmp = clients[idx]
        # sys.exit()
        clients[idx].update({"name":new_name})
    else:
        print("Client is not in client\'s list")


def delete_client(client_name):
    # global clients
    idx = _get_idx_by_name(client_name)

    if idx!=None :
        del clients[idx]
    else:
        print("Client is not in client\'s list")


def search_client(client_name):
    idx = _get_idx_by_name(client_name)
    if idx!=None:
        return True
    return False

def _print_welcome():
    print('WELCOME TO PLATZI VENTAS')
    print('*'*50)
    print('What would you like to do today?')
    print('[L]ist clients')
    print('[C]reate client')
    print('[U]pdate client')
    print('[D]elete client')
    print('[S]earch client')

def _get_client_field(fieldname):
    field = None
    while not field:
        field = input("What is the client's {}: ".format(fieldname))
    return field

def _get_client_name():
    client_name = None

    while not client_name:
        client_name = input('What is the client name? ')
        type(client_name)
        print('Nombre aportado: {} es de tipo: {}'.format(client_name,type(client_name)))
        if client_name.lower() == 'exit':
            client_name = None
            break

    if not client_name:
        sys.exit()

    return client_name


if __name__ == '__main__':
    # hace open(r) de .clients.csv
    _initialize_clients_from_storage()

    _print_welcome()
    command = input()
    command = command.upper()
    
    if command == 'L':
        list_clients()
    elif command == 'C':
        # client_name = _get_client_name()
        dicClient = {
            "name"      : _get_client_field("name"),
            "company"   : _get_client_field("company"),
            "email"     : _get_client_field("email"),
            "position"  : _get_client_field("position")
        }
        create_client(dicClient)
        #list_clients()
    elif command == 'D':
        client_name = _get_client_name()
        delete_client(client_name)
        #list_clients()
    elif command == 'U':
        client_name = _get_client_name()
        updated_name = input('What is the updated client name ')
        update_client(client_name,updated_name)
        #list_clients()

    elif command == 'S':
        client_name = _get_client_name()
        # print("traza: client_name_input: "+client_name)
        found = search_client(client_name)
        if found:
            print('The client IS in the client\'s list')
        else:
            print('The client: {} is NOT in our client\'s list'.format(client_name))
    else:
        print('Invalid command')

    # hace un open(w) 
    _save_clients_to_storage()