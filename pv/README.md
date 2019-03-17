# Clases Python Parte 1 - App. Platzi Ventas

### [Python](https://platzi.com/clases/python/)
Prueba de concepto con Python 3.7.2 y Anaconda

- [Link interesante de instalación de Python](https://aasanchez.wordpress.com/2013/09/20/django-en-windows-y-no-morir-en-el-intento/)

- Instalar pip
- `which pip`
- Ambientes virtuales
    - venv: virtual enviroment
    - virtualenv `which virtualvnv --distribute`
    - virtualenv venv 
    - source venv/bin/activate
    - `.\sevidor\venv\Scripts\activate` (windows cmd)
    - `pip freeze` muestra lo que está instalado hasta este momento
    - `pip install flask` libreria que crea servidor web
- Generar servidor web
    - main.py levanta un servidor web

- Definiremos comando Platzi Ventas (pv)
- `pv --help`

- Funciones
    - Con `"""esto es un comentario para ser recuperado con help(mi_funcion)"""`
    - `_funcion_nombre` se empieza con **_** como marca de función auxiliar
    - palabra clave **def**
    ```py
    def sum_two_numbers(x,y):
        return x + y
    ```
- `pass` place holder
- `type(1)` devuelve el tipo
- `un_entero = int('5')`
- `print(un_entero)` imprime por pantalla 

- Ambito de variables
    - palabra `global`
    - Hay que dejar dos lineas entre funciones. Convención de python
- Se puede listar y añadir clientes
    - Se trabaja con una variable global clientes

- Operadores lógicos de comparación
    - `=, ==, !=,~, and, or, ...`
    - Repasar curso de matemáticas discretas con Sergio

- `print('*'*50)` imprime 50 veces *
- `client_name = input('What is the client name? ')` captura input

- Strings
    - Se encierran caracteres entre **`''`**
    - `len(mi_string)`
    - Son inmutables. Cada vez que se transforma un string se genera un nuevo objeto en memoria.
    - `print(mi_string[0])`
    - `print(mi_string[-2]`
    - `id(mi_string)` Consulta la dirección de memoria donde se almacena
    - funciones: `upper, lower, find, startswith, endswith, capitalize`
    - operadores: `in, not in`
    - **'a' != 'A'** puesto que python usa un id distinto para cada uno
    - función `dir(mi_string)`: Hace un dump del objeto 
        ```py
		['__add__', '__class__', '__contains__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__',
        '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__gt__', '__hash__', '__init__',
        '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', 
        '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__',
        '__sizeof__', '__str__', '__subclasshook__', 'capitalize', 'casefold', 'center', 'count', 'encode', 
        'endswith', 'expandtabs', 'find', 'format', 'format_map', 'index', 'isalnum', 'isalpha', 'isascii', 
        'isdecimal', 'isdigit', 'isidentifier', 'islower', 'isnumeric', 'isprintable', 'isspace', 'istitle',
        'isupper', 'join', 'ljust', 'lower', 'lstrip', 'maketrans', 'partition', 'replace', 'rfind',
        'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip',
        'swapcase', 'title', 'translate', 'upper', 'zfill']        
        ```
    - Thunder methods `__<metodo>__` configuran como python se ejecuta.
        - Se podrian modificar y afectaria al comportamiento del objeto
    - función `help(mi_funcion)` imprime por pantalla los comentarios de la función
- Ejemplo comprobación substring `if client_name in clients:`
- CRUD Completo dentro de un string

- Slices
    - **somestring[i-origen:i-final:i-saltos],**
    - **::  todo el string**
    - **`my_string = 'abcdefghijklmnopqrstuvwxyz'`**
    - `my_string[0:3]`      Desde el 0 hasta el 3 no inclusivo
        - `abc`
    - `my_string[::2]`      Recorre todo el string de 2 en 2
        - `acegikmoqsuwy`
    - `my_string[3:]`       Desde el indice 3 hasta el final
        - `defghijklmnopqrstuvwxyz`
    - `my_string[:8:3]`     Desde el principio hasta la pos 8 de 3 en 3
        - `adg`
    - `my_string[:10]`      Desde el principio hasta la pos 10
        - `abcdefghij` 
    - `my_string[:]`        Recorre todo el string
    - `my_string[::]`       Recorre todo el string
    - `my_string[::-1]`     Recorre todo el string pero del fin hacia el prin
        - `zyxwvutsrqponmlkjihgfedcba`
    - `my_string[1:-1:2]`   Recorre desde la pos 1 hasta (fin-1) de 2 en 2
        - `bdfhjlnprtvx`

- for loops
    - `for i in range(10)`
    - Función search client en main.py
    - `clients.split(',')` explode en php
    - `print('The client: {} is not in our client\'s list'.format(client_name))` usando wildcards
    - [Yield y Generators by Corey Schafer](https://www.youtube.com/watch?v=bD05uGo_sVI)
    - Los [**Generators**](http://book.pythontips.com/en/latest/generators.html) son estructuras que se pueden recorrer solo una vez ya que van creando el elemento en el que se está en tiempo de ejecución puesto que su información no se almacena en memoria.
    - Los generadores se recomiendan para arrays con grandes volumenes de información de modo que no se tenga que guardar en memoria para ser procesada.


- while
    ```python
    import sys

    def _get_client_name():
        client_name = None

        while not client_name:
            client_name = input('What is the client name? ')
            type(client_name)
            print('Nombre aportado -->{} {}'.format(client_name,type(client_name)))
            if client_name.lower() == 'exit':
                client_name = None
                break

        if not client_name:
            sys.exit()

        return client_name  
    ```
- 21 listas
    - se pueden definir con [] o con el building function list `list()`
    - copiar listas, `clone en PHP` se usa el módulo copy: `otra_lista = copy.copy(mi_lista)`
    - 22 operadores
        - suma y multiplicación
        ```python
        a = [1,2]
        b = [2,3]
        a + b = [1,2,2,3] # es como un array_merge(ar1,ar2) en php

        a.append(0) # [1,2,0]
        eliminado = a.pop() # elimina el último valor en la lista y lo devuelve
        a.sort() # [0,1,2] o newlist = a.sorted() # [0,1,2]
        del a[-1]  # elimina 2
        a.remove("valor") # elimina los items que tengan ese valor
        ```
    - `import random`
    ```python
    # foreach(clients as idx => client) en php
    for idx, client in enumerate(clients):
        print('{}:{}'.format(idx,client))
    ```
- 24 diccionarios
    - También se les conoce como hashmaps
    - Equivalente a los arrays asociativos en PHP
    - Asociación clave => valor
    - Los diccionarios tienen varios métodos
    - Ejemplo en consola
    ```py
    oDiccionario.keys()
    oDiccionario.values()
    oDiccionario.items()
    myvar = oDiccionario.get("somekey","some txt if key does not exist")
    ```
    - 25 Refactor de main.py
        - refactor de list_clients
        - Queda pendiente **Update**, **Search** y **Delete**
        - Pista: en lugar de usar client["name"] es mejor usar el indice
        ```py
        def _get_idx_by_name(client_name):
            return (next((i for (i,item) in enumerate(clients) if item["name"]==client_name),None))
        ```
        - `sys.exit()` El `die()` o `exit()`
        - Update:
        ```py
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
        ```
        - Search:
        ```py
        def search_client(client_name):
            idx = _get_idx_by_name(client_name)
            if idx!=None:
                return True
            return False
        ```
        - Delete:
        ```py
        def delete_client(client_name):
            # global clients
            idx = _get_idx_by_name(client_name)

            if idx!=None :
                del clients[idx]
            else:
                print("Client is not in client\'s list")
        ```
- 26 Tuplas (tuples) y Conjuntos (sets)
    - Tuplas son como las listas pero son inmutables (como constantes) `mi_tupla = (3,7,9)`
    - Sets, son mutables. Tienen métodos: **set**, **add**, **remove**
    - Conjuntos ejemplos:
        - Mejor inicializarlos con **.set()**
        - Los conjuntos no tienen orden por lo tanto no se guardan con indices
        - Los sets no pueden tener duplicados
    - 27 Tuplas
    ```py
    #conjuntos
    conjunto_a & conjunto_b  #a inner join b
    conjunto_a - conjunto_b  #a left outer join b
    conjunto_b - conjunto_a  #a right outer join b

    conjunto_a = set([1,2,3])
    conjunto_b = {3,4,5}

    #tuplas
    tupla_a = (1,1,1,2,3,4)
    #error de inmutabilidad
    tupla_a[0] = 10
    tupla_a.count(1) #veces que aparece 1 -> 3
    ```
    - 28 Ejemplo extendiendo del módulo **collections** **UserDict** y **NamedTuple**
    ```py
    # 1 UseDict
    class SecretDict(collections.UserDict):

    def _password_is_valid(self, password): #self = this en php
            …

        def _get_item(self, key):
            … 

        def __getitem__(self, key):
            password, key = key.split(‘:’)
            
            if self._password_is_valid(password):
                return self._get_item(key)
            
            return None

    my_secret_dict = SecretDict(...)
    my_secret_dict[‘some_password:some_key’] # si el password es válido, regresa el valor 

    #2 NamedTuple
    Coffee = collections.NamedTuple(‘Coffee’, (‘size’, ‘bean’, ‘price’))
    def get_coffee(coffee_type):
        If coffee_type == ‘houseblend’:
            return Coffee(‘large’, ‘premium’, 10)    

    #3
    >>> from collections import namedtuple
    >>> Point = namedtuple('Point', ['x', 'y'])  # Define namedtuple
    >>> p = Point(10, y=20)  # Creating an object
    >>> p
    Point(x=10, y=20)
    >>> p.x + p.y
    30
    >>> p[0] + p[1]  # Accessing the values in normal way
    30
    >>> x, y = p     # Unpacking the tuple
    >>> x
    10
    >>> y
    20
    ```
- 29 Comprehensions
    - Estructura que nos permite generar secuencias a partir de otras secuencias
    - El trabajo realizado con una **comprehension** es equivalente al realizado por un loop
    - La ventaja de una comprehension frente a un loop es que es más optima y más legible al tener menos cantidad de código.
    - función **`zip(clave,valor)`**
    - **List comprehensions**
        - Genera una lista con los items de una lista
        - `[item for item in listitems if somecondition]`
        - `pares = [i for i in l if i % 2 == 0]`
    - **Dictionary comprehensions**
        - Genera un diccionario {key:value} con dos elementos 
        - `{key: element for element in element_list if element_meets_condition}`
        - `stud_m = {uid: studitem for uid, studitem in zip(s_uid,stud)}`
    - **Sets comprehensions**
        - `{element for element in element_list if elements_meets_condition}`
        - `norep = {i for i in rnd}`
- 30 Busquedas binarias (busqueda dicotómica)
    - Búsqueda binaria lo único que hace es tratar de encontrar un resultado en una lista ordenada de tal manera que podamos razonar. Si tenemos un elemento mayor que otro, podemos simplemente la mitad de la lista cada vez.
    - Pasos:
        - Ordenar la lista de items a evaluar de forma creciente
        - buscar el item medio: i_medio = math.floor(num_items / 2)
        - evaluar: i_buscado > lista[i_medio]
            - True => buscar de i_medio hacia adelante
                - i_medio = math.floor((num_items - i_medio)/2)
            - False => buscar de i_medio hacia atras
                - i_medio = math.floor(i_medio /2)
            - i_buscado > lista[i_medio]
    

    ```py
    def _get_position(iSearch,lstData):
        iSearch = int(iSearch)
        # ya vienen ordenados
        #lstData.sort()
        iChars = 70
        print("="*iChars)
        print(lstData)
        print("="*iChars)
        iLast = lstData[-1]
        
        # entrada inicial
        iMin = 0
        iMax = len(lstData)-1
        iMiddle = _get_middle(iMin,iMax)

        while (not (iMax<0 or iMin>iMax)):
            iValMiddle = lstData[iMiddle]
            print("iMin:{}, iMax:{}, iMiddle:{}, valMiddle:{} vs {}".format(iMin,iMax,iMiddle,iValMiddle,iSearch))
            if iSearch == iValMiddle:
                return iMiddle
            # no encontrado, busca por derecha
            elif iSearch > iValMiddle:
                iMin = iMiddle + 1
                iMiddle = iMin + _get_middle(iMin,iMax)
            # no encontrado busca por izquierda
            else: #iSearch < iValMiddle
                iMax = (iMiddle - 1)
                iMiddle = _get_middle(iMin,iMax)
            print("vals for next loop: iMin:{}, iMax:{}, iMiddle:{}".format(iMin,iMax,iMiddle))

        return None
    #end _get_position
    ```
- 31 Manipulación de archivos
    - `f = open("some_file")`
    - `context managers` estructuras que gestionan los instantes previos y finales a una operación
        - palabra reservada **with** 
    ```py
    with open(tmp_table_name, mode="w") as f:
        writer = csv.DictWriter(f,fieldnames=CLIENT_SCHEMA)
        writer.writerows(clients)
        os.remove(CLIENT_TABLE)
    
    # ojo con esta linea que está mal en el video, debe estar fuera de WITH
    os.rename(tmp_table_name,CLIENT_TABLE) 
    ```

- 32 **Uso de objetos y módulos** Decoradores
    - Currificación y Closuras
    - Función que envuelve a otra función para modificar su comportamiento
    - Funciones que devuelven funciones
    - Funciones que reciben funciones
    - 33 Deoradores en python
    - Una función decoradora **publica** la función que se le pasa como argumento si se cumple una condición dentro del decorador. Esta encapsulación asegura parte del código.
        - se usa `@funcion_decoradora`
        - hacer un forward de los argumentos `def wrapper(*args, **kwargs):`
        - la función `wrapper()` no tiene que llamarse así. 
        ```py
        def funcion_decoradora(func_arg):
            def wrapper():
                ...
                return func_arg()
                ...
            return wrapper

        @funcion_decoradora
        def funcion_argumento():
            ...
        ```
- 35 Programación orientada a objetos
    - Encapsulación
    - Abstracción
    - Herencia
    - Polimorfismo
    - 36 Implementación en python
        - `class` keyword
        - convención las clases empiezan con mayusculas y siguen con camelcase
        - `thunder __init__` constructor  `__construct() en php`
        - `self.`
        - creamos **personas.py**
        ```py
        class Persona:
            def __init__(self,name,age):
                self.name = name
                self.age = age

            def say_hello(self):
                print("Hello, my name is {} and I am {} years old".format(self.name, self.age))


        if __name__ == "__main__":
            #new no se usa en python
            person = Persona("David",34)
            person.say_hello()        
        ```
    - 37 Scopes and namespaces
        - <img src="https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/452x430/584c0564ef69cacdb53e25af44a5475c/nested-namespaces-python.jpg" width="100" height="200" title="Scopes" />
        - Scope es la parte del programa en el que podemos tener acceso a un namespace sin necesidad de prefijos.<br>
        En cualquier momento determinado, el programa tiene acceso a tres scopes:<br>
        El scope dentro de una función (que tiene nombres locales)<br>
        El scope del módulo (que tiene nombres globales)<br>
        El scope raíz (que tiene los built-in names)<br>
        Cuando se solicita un objeto, Python busca primero el nombre en el scope local, luego en el global, y por último, en el raíz. Cuando anidamos una función dentro de otra función, su scope también queda anidado dentro del scope de la función padre.
        ```py
        def outer_function(some_local_name):
            def inner_function(other_local_name):
                # Tiene acceso a la built-in function print y al nombre local some_local_name
                print(some_local_name) 
                
                # También tiene acceso a su scope local
                print(other_local_name)
        ```
        Para poder manipular una variable que se encuentra fuera del scope local podemos utilizar los keywords **global** y **nonlocal**.
        ```py
        some_var_in_other_scope = 10

        def some_function():
            global some_var_in_other_scope     
            Some_var_in_other_scope += 1
        ```
    - 38 Introducción al framework: **click**
        - Usaremos un framework para trabajar con lineas de comandos
        - El framework es capaz de interpretar los siguientes **decoradores**
            - **@click_group**: Agrupa una serie de comandos
            - **@click_command**: Aca definiremos todos los comandos de nuestra apliacion
            - **@click_argument**: Son parámetros necesarios
            - **@click_option**: Son parámetros opcionales
        - click realiza las conversiones de forma automática (trabajo que nos ahorra)
        - 39 Definición de API Pública
            - Nuevos ficheros:
                - pv.py
                - setup.py
                - clients/commands.py
            - En python los subdirectorios se conocen como **módulos**
            - Se trabaja en un ambiente virtual
            - Nuestra app se instala en el ambiente virtual
            - Hay que probarlo
            - **Lanzar entorno virtual en Windows**
            - El entorno virtual se utiliza para no instalar de modo global la aplicación que vamos a probar
            - Pasos:
                - `pip install virtualenvwrapper-win` wrapper para que funcione el siguiente comando, como en el mac del profesor
                - `virtualenv --python=python venv`
                - `cd venv/Scripts`
                - ejecutar `activate`
            - Instalación de nuestra app: `\prj_python37\src>pip install --editable .`
                - El flag `--editable` indica que la instalación se refrescara con cada modificación de nuestra app
                ```py
                (venv) <project>\src>pip install --editable .
                Obtaining file:///<project>/src
                Requirement already satisfied: Click in <project>\servidor\venv\lib\site-packages (from pv==0.1) (7.0)
                Installing collected packages: pv
                Running setup.py develop for pv
                Successfully installed pv                
                ```
                - Crea una carpeta <project>/src/pv.egg-info
            - comprobar instalación `where pv` windows o `which pv` en linux
        - 40 Clients
            - Ficheros models.py y services.py
            - Organización de una app.
                - Interfaz, en nuestro caso los comandos
                - Lógica de negocio
                - Abstracciones
            - `uuid.uuid4()` genera ids únicos, d4 es el estandard 
        - 41 Lógica de negocio de nuestra aplicación
            - Se define el proceso de creacion de un cliente.
            - Stack de llamadas
                - [**pv.py**](https://github.com/eacevedof/prj_python37/blob/master/src/pv.py) es el archivo principal, importa los comandos (que son las funciones decoradas del CRUD)
                - [**commands.py**][https://github.com/eacevedof/prj_python37/blob/master/src/clients/commands.py] es un tipo de controlador con las funciones del CRUD. Importa el servicio y el modelo
                - [**models.py**](https://github.com/eacevedof/prj_python37/blob/master/src/clients/models.py) realmente es el modelo de clientes, tiene métodos **to_dic** y static.**schema**
                - [**services.py**](https://github.com/eacevedof/prj_python37/blob/master/src/clients/services.py) es el que interactua con el fichero, lee y escribe. Importa el modelo
        - 42 Interface de create: Comunicación entre servicios y el cliente
            - se usa click.echo() en lugar de print() ya que el comportamiento de este último varia según el S.O.
            - `pv --help`
            - `pv clients list`        
        - 43 Actualización de un cliente
            - Creo en services.py el método update
        - 44 Interface de actualización
            - Cada vez que se use **self** dentro de un método este objeto debe configurarse como parámetro. Ejemplo `def _save_to_disk(self,lstClients):`
            - Hacer el método **delete**
            - Delete creado

- 45 Manejo de errores y jerarquía de errores en Python
    - El programa de python termina cuando encuentra un error
    - Para lanzar un error utilizamos el keyword **raise**
    ```py
    def divide(n,deno):
        if deno == 0:
            raise ZeroDivisionError
    ```
    - Aunque python ya trae errores concretos para ser lanzados podemos declararar nuestros propios errores.
    - Para esto hay que crear una clase que extienda de BaseException:
    ```py
    class TakeOffError(BaseException)
    ```
    - Si nuestra intención es evitar que termine el programa cuando se lance un error, no podemos encapsular todo nuestro programa en un try catch
    - Try Catch se usa si analizamos que puede fallar por un "side effect"
    ```py
    try:
        airplane.takeoff()
    except TakeOffError as error:
        airplane.land()
    ```
    - <img src="https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/533x435/f9756de823fc93831346f8f4e299c688/image.png" width="100" height="200" title="Try Catch" />
    - <img src="https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/348x554/bb7be842e1ff9c2b1c119a76f80b6b30/image.png" width="100" height="200" title="Lista de errores" />
- 46 Context managers **with**
    - [Doc oficial](http://book.pythontips.com/en/latest/context_managers.html)
    ```py
    # Ejemplo sin contexto:
    file = open('some_file', 'w')
    try:
        file.write('Hola!')
    finally:
        file.close()

    # mismo ejemplo con with  
    with open('some_file','w') as opened_file:
        opened_file.write('Hola!')


    class CustomOpen(object):
        def __init__(self, filename):
            self.file = open(filename)

        # enter y exit son utilizados por with para ejecutar acciones
        # de inicialización, entrada y salida del contexto
        def __enter__(self):
            return self.file

        def __exit__(self, ctx_type, ctx_value, ctx_traceback):
            self.file.close()

    with CustomOpen('file') as f:
        contents = f.read()

    # contexto como generador
    # generator son iterandos que solo se pueden recorrer una vez
    from contextlib import contextmanager

    @contextmanager
    def custom_open(filename):
        f = open(filename)
        try:
            yield f
        finally:
            f.close()

    with custom_open('file') as f:
        contents = f.read()   
    ```
- 47 Aplicaciones de Python en el mundo real
    - En CLI por si te gusta trabajar en la nube y con datacenters, para sincronizar miles de computadoras:
        - aws
        - gocloud
        - rebound
        - geeknote
    - Aplicaciones Web:
        - Django
        - Flask
        - Bottle
        - Chalice
        - Webapp2
        - Gunicorn
        - Tornado
- 48 Python 2 vs 3 (Conclusiones)
    - Future (migra de 2 a 3)
    - Six (ejecuta en 2 y 3)
    ```py
    No es recomendable empezar con Python 2 porque tiene fecha de vencimiento para el próximo año.
    PEP = Python Enhancement Proposals
    Los PEP son la forma en la que se define como avanza el lenguaje. Existen tres PEPs que debes saber.
    - PEP8 es la guía de estilo de cómo escribir programas de Python.Es importante escribir de manera similiar para que nuestro software sea legible para el resto de la comunidad
    - PEP257 nos explica cómo generar buena documentación en nuestro código
    - PEP20
    import this

    The Zen of Python, by Tim Peters

    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!    
    ```

## comandos
```py
python ./src/main.py
mv ./src/.clients.csv.tmp ./src/.clients.csv
```

## Errores

- ImportError: cannot import name 'flask' from 'flask' (E:\programas\python\python37-32\lib\site-packages\flask\__init__.py)
    - from Flask

- Error al leer .clients.csv
```py
$ python ./src/main.py
Traceback (most recent call last):
  File "./src/main.py", line 137, in <module>
    _initialize_clients_from_storage()
  File "./src/main.py", line 37, in _initialize_clients_from_storage
    with open(CLIENT_TABLE, mode='r') as f:
FileNotFoundError: [Errno 2] No such file or directory: '.clients.csv'


- Solución:
CLIENT_TABLE = "./src/.clients.csv"  #ok
#CLIENT_TABLE = ".clients.csv"       #error
```

- Error al escribir
```py
Traceback (most recent call last):
  File "./src/main.py", line 181, in <module>
    _save_clients_to_storage()
  File "./src/main.py", line 52, in _save_clients_to_storage
    os.rename(tmp_table_name,CLIENT_TABLE)
PermissionError: [WinError 32] El proceso no tiene acceso al archivo porque est▒ siendo utilizado por otro proceso: './src/.clients.csv.tmp' -> './src/.clients.csv'


- Solución:
# debia estar fuera de with
os.rename(tmp_table_name,CLIENT_TABLE)
```

- Error al intentar crear un cliente por linea de comandos en el entorno
```js
Traceback (most recent call last):
File "<project>servidor\venv\Scripts\pv-script.py", line 11, in <module> load_entry_point('pv', 'console_scripts', 'pv')()
File "<project>servidor\venv\lib\site-packages\click\core.py", line 764, in __call__
    return self.main(*args, **kwargs)
File "<project>servidor\venv\lib\site-packages\click\core.py", line 717, in main
    rv = self.invoke(ctx)
File "<project>servidor\venv\lib\site-packages\click\core.py", line 1137, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
File "<project>servidor\venv\lib\site-packages\click\core.py", line 1137, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
File "<project>servidor\venv\lib\site-packages\click\core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
File "<project>servidor\venv\lib\site-packages\click\core.py", line 555, in invoke
    return callback(*args, **kwargs)
File "<project>servidor\venv\lib\site-packages\click\decorators.py", line 17, in new_func
    return f(get_current_context(), *args, **kwargs)
File "<project>src\clients\commands.py", line 23, in create
    client_service.create_client(client)
File "<project>src\clients\services.py", line 12, in create_client
    writer.writerow(client.to_dict())
AttributeError: 'Client' object has no attribute 'to_dict'

solución:
Era to_dic ^^
```

- Error al intentar modificar, le paso un parámetro y me aparece lo siguiente:
```js
(venv) <project>\src>pv clients update 123
Usage: pv clients update [OPTIONS]
Try "pv clients update --help" for help.

Error: Got unexpected extra argument (123)


solucion:
Faltaba linea: @click.argument("client_uid",type=str)

//ya actualiza, faltaban varias cosas, el contexto en _save_to_disk, su llamada, el mode=a en open writer"
```