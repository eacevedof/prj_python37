import json

path_json = "/Users/eduardoacevedo/projects/temper/json/a.json"

def file_get_contents(filename):
    with open(filename, 'r') as f:
        # Cargar el contenido del archivo en una variable de Python
        datos = json.load(f)
    return datos

data = file_get_contents(path_json)

# Extraer las claves
keys = set()
for value in data.values():
    keys |= set(value.keys())
    ks = value.keys()
    for k in ks:
        if isinstance(value[k], str) or value[k] is None:
            continue
        keys |= set(value[k].keys())

for k in keys:
    print(k)
