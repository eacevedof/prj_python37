# Platzigram

#### Python 3.7 - Django 2.1.7
- `py --version` Para versión de python
- `(env): py manage.py --version` Para versión de Django

## [Parte 4 - Clases Django](https://platzi.com/clases/django/) 

#### 3 Video. Preparación del entorno de trabajo
- Entornos virtuales 
- `python -m venv .env`  Crea la carpeta del entorno virtual. Aqui se instalarán todas los paquetes necesarios para Django
- <details>
	<summary>.env (tree en windows)</summary>
    <p>
    
    ```
    D:.
    ├───Include
    ├───Lib
    │   ├───site-packages
    │   │   ├───pip
    │   │   │   ├───_internal
    │   │   │   │   ├───commands
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───models
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───operations
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───req
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───utils
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───vcs
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───cachecontrol
    │   │   │   │   │   ├───caches
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───certifi
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───chardet
    │   │   │   │   │   ├───cli
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───colorama
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───distlib
    │   │   │   │   │   ├───_backport
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───html5lib
    │   │   │   │   │   ├───filters
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treeadapters
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treebuilders
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───treewalkers
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───_trie
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───idna
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───lockfile
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───msgpack
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───pkg_resources
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───progress
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───pytoml
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───requests
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───urllib3
    │   │   │   │   │   ├───contrib
    │   │   │   │   │   │   ├───_securetransport
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───packages
    │   │   │   │   │   │   ├───backports
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   ├───ssl_match_hostname
    │   │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   ├───util
    │   │   │   │   │   │   └───__pycache__
    │   │   │   │   │   └───__pycache__
    │   │   │   │   ├───webencodings
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───pip-10.0.1.dist-info
    │   │   ├───pkg_resources
    │   │   │   ├───extern
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───setuptools
    │   │   │   ├───command
    │   │   │   │   └───__pycache__
    │   │   │   ├───extern
    │   │   │   │   └───__pycache__
    │   │   │   ├───_vendor
    │   │   │   │   ├───packaging
    │   │   │   │   │   └───__pycache__
    │   │   │   │   └───__pycache__
    │   │   │   └───__pycache__
    │   │   ├───setuptools-39.0.1.dist-info
    │   │   └───__pycache__
    │   └───tcl8.6
    └───Scripts    
    ```
    
    </p>
</details>

- En una ventana de cmd: `platzigram>..\.env\scripts\activate`
- `deactivate` es el comando opuesto
- Instalación de Django con pip dentro de nuestro (.env)
	- `python -m pip install --upgrade pip` Actualizamos pip
	- `pip install django -U` -U: última version
	- `pip freeze` Comprobamos que está instalado
	```sh
    (.env) <project>\platzigram>pip freeze
    Django==2.1.7
    pytz==2018.9
    ``` 


#### 4 Manual. Como instalar python en windows.
- Solo lectura

#### 5 Video. [Creación del proyecto Platzigram / Tu primer Hola, mundo en Django](https://platzi.com/clases/1318-django/12402-creacion-del-proyecto-platzigram-tu-primer-hola-mu)

- Nos posicionamos en nuestro entorno virtual.
- `django-admin startproject platzigram .` Creación de un proyecto de Django
- Archivos creados dentro de platzigram/platzigram:
    -  urls.py: Mapea rutas a controladores
    ```py
    from django.contrib import admin
    from django.urls import path

    urlpatterns = [
        path('admin/', admin.site.urls),
    ]        
    ```
    - wsgi.py: Es la interfaz que se ejecuta en producción
    ```py
    import os
    from django.core.wsgi import get_wsgi_application
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'platzigram.settings')
    application = get_wsgi_application()        
    ```
    - manage.py: Nunca vamos a tocar pero interactuaremos con el en todo el desarrollo. Es una interfaz sobre djangoadmin. Es un comando de consola de django.
    - settings.py: 
        - BASE_DIR: la ruta raíz del proyecto
        - SECRET_KEY: hashing de contraseñas
        - DEBUG: muestra trazas
        - ALLOWED_HOSTS: los hosts permitidos
        - INSTALLED_APPS: Apps instaladas
        - MIDDLEWARES:
        - ROOT_URLCONF: Nuestra url raiz al proyecto
        - TEMPLATES:
        - WSGI_APPLICATION:
        - DATABASES:
        - AUTH_PASSWORD_VALIDATORS: Todas las contraseñas pasan por todos estos filtros.
        - [Más datos](https://github.com/eacevedof/prj_python37/blob/master/keepcoding/README.md)
        - <details>
            <summary>`python manage.py`</summary>
            <p>

            ```
            Available subcommands:

            [auth]
                changepassword
                createsuperuser

            [contenttypes]
                remove_stale_contenttypes

            [django]
                check
                compilemessages
                createcachetable
                dbshell
                diffsettings
                dumpdata
                flush
                inspectdb
                loaddata
                makemessages
                makemigrations
                migrate
                sendtestemail
                shell
                showmigrations
                sqlflush
                sqlmigrate
                sqlsequencereset
                squashmigrations
                startapp
                startproject
                test
                testserver

            [sessions]
                clearsessions

            [staticfiles]
                collectstatic
                findstatic
                runserver           
            ```

            </p>
        </details>
	- **`python manage.py runserver`**  Arranca el servidor en:
		- [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
	```js
    Performing system checks...
    System check identified no issues (0 silenced).
    You have 15 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
    Run 'python manage.py migrate' to apply them.
    March 17, 2019 - 17:09:02
    Django version 2.1.7, using settings 'platzigram.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CTRL-BREAK.    
    ```
    - Si navegamos a esa dirección veremos la página de inicio de django en local.
    - Tocamos el fichero urls.py
    ```py
    from django.urls import path
    from django.http import HttpResponse

    def hello_world(request):
        return HttpResponse("Hello World")

    urlpatterns = [
    	# path(ruta-slug,<vista,función o clase que recibe la petición>)
        path("hello-world/",hello_world)
    ]
    ```

#### 6 Video. [El objeto Request](https://platzi.com/clases/1318-django/12403-el-objeto-request2427)
- [Gestión de petición (request) de Django](https://docs.djangoproject.com/en/2.1/topics/http/urls/#how-django-processes-a-request) 
- Las funciones que reciben las peticiónes (requests) django las entiende como vistas.
- Creamos fichero `views.py`
- `from datetime import datetime`
- `print(request)`  `<WSGIRequest: GET '/hi/'>`
- [El objeto request](https://docs.djangoproject.com/en/2.1/ref/request-response/#django.http.HttpRequest)
- Uso del módulo **pdb**
```py
pdb.set_trace()
> <project>\platzigram\views.py(18)hi()
-> return HttpResponse("hi")
(Pdb)
aqui permite pedir trazas sobre el objeto request. Por ejemplo:
request.POST
request.GET
presionando c + enter sigue la ejecución
```
- **Tarea**
	- Queda recibir por GET numbers=10,4,50,32 y devolverlos por json no por HTML de forma ordenada.
	- [http://127.0.0.1:8000/hi/?numbers=10,4,50,32](http://127.0.0.1:8000/hi/?numbers=10,4,50,32)
	- **solución:**
	- `import json` 
	```py
	def hi(request):
    """Hi."""
        # request.GET = <QueryDict: {'numbers': ['10,4,50,32']}>
        sNumbers = request.GET["numbers"]
        lstNumbers = sNumbers.split(",")
        lstNumbers = [int(sI) for sI in lstNumbers]
        lstNumbers.sort()
		return HttpResponse(json.dumps(lstNumbers), content_type="application/json") 
	```
    
#### 7 Video. [Solución al reto - Pasando argumentos en la URL](https://platzi.com/clases/1318-django/12404-solucion-al-reto-pasando-argumentos-en-la-url/)
```py
numbers = [int(i) for i in request.GET["numbers"].split(",")]
nsorted = sorted(numbers)
data = {
    "status": "ok",
    "numbers": nsorted,
    "message": "Integers sorted susccesfully."
}
return HttpResponse(
    json.dumps(data,indent=4),
    content_type="application/json"
)
```

```py
def say_hi(request,name,age):
    """hi/<str:name>/<int:age>/"""
    # pdb.set_trace()
    # con GET no va, pq realmente no hay nada en la url como: ?k=v&k2=v2
    name = request.GET["nombre"]
    age = request.GET["edad"]
    if age<12:
        message = "Sorry {}, you are not allowed here".format(name)
    else:
        message = "Hello {}!, Welcome to Platzigram".format(name)
    return HttpResponse(message)
```
#### 8 Video. [Creación de la primera app](https://platzi.com/clases/1318-django/12405-creacion-de-la-primera-app/)
- Se crea una nueva app dentro de: **(env) ~/platzigram** con **`py manage.py startapp appposts`** el nombre de app procuremos que sea siempre en plural.
- Crea un módulo migrations que se encarga de guardar los cambios en la bd.
- Archivo **admin.py** se encarga de guardar los modelos en el administrador de django.
- **apps.py** aqui se de clara toda la configuración de nuestra app de modo público y hace que nuestra app sea reutilizable.  Se puede definir ciertas variables.
- **models.py** se usa para definir los modelos de nuestros datos.
- **test.py** archivo de pruebas
- **views.py**
- La app de django no es estricta en lo que a su arbol de carpetas se refiere. Se puede adaptar y escalar según las necesidades de cada proyecto.
- [**`<appposts>/app.py`**](https://docs.djangoproject.com/en/2.1/ref/applications/)
	- En la doc, define que es una app, que variables recibe y como configurarla.
	- Nos interesa dos variables:
		- **.name**  El nombre común de nuestra app
		- **.verbose_name** El mismo nombre anterior pero en plural
- Despues de configurar app.py tenemos que configurar `<project>/platzigram/settings.py`
	- En la lista **INSTALLED_APPS** agregamos
	```py
    # Local apps
    "appposts", #hace referencia al módulo <project>/appposts
    ```
- Configuramos una vista:
	- Actualizamos **urls.py**
	```js
    path("posts/",posts_views.list_posts),
	AttributeError: module 'appposts.views' has no attribute 'list_posts'
    ```
    - Configuramos **`<project>/appposts/views.py`**
    	- defino `list_posts(request):`
		- defino lista de posts: `posts = [...]`
		- interesante **\*\*post**: explota el array items de forma ordenada y se concatean automaticamente en las posiciones del string
		```py
        contents = []
        for post in posts:
            contents.append("""
                <p><strong>{name}</strong></p>
                <p><strong>{user} - <i>{timestamp}</i></strong></p>
                <figure><img src="{picture}"/></figure>
            """.format(**post))

        return HttpResponse("<br/>".join(contents))
        ```
- Se muestra el listado de posts con foto.

#### 9 Video. [Introducción al template system](https://platzi.com/clases/1318-django/12406-introduccion-al-template-system/)
- El template system está inspirado en [jinja2](http://jinja.pocoo.org/) (a full featured template engine for Python) con lo cual comparten mucha similitud.
- Repasando el flujo de una petición:
	- url (se traducirá en una función)
	- vista (que es una función definida en el fichero views.py)
	- La función (`def somefunc(request):`) procesa la entrada usando parámetros y el objeto request
	- La función procesa una respuesta usando el objeto HttpResponse (del módulo: django.http)
- Los templates los definimos en el archivo **<project>/platizgram/settings.py**
- Usamos la variable **TEMPLATES** que admite diferentes backends.
- Creamos una carpeta dentro de nuestra **app** de django (appposts).
- en `apposts\views.py` ya no se usa `from django.http import HttpResponse`
- se reemplaza por `from django.shortcuts import render`
```py
def list_posts(request):
    """List existing posts"""
    return render(request,"feed.html")
```
- Como hace Django para encontrar el template?:
	- En la variable settings.py TEMPLATES["APPS_DIRS"]:True se le indica que busque las plantillas dentro de la subcarpeta templates.
		- Probemos con la subcarpeta **borrame**. No, no funciona.
		```js
        django.template.loaders.app_directories.Loader: <prj_python37>\.env\lib\site-packages\django\contrib\admin\templates\feed.html (Source does not exist)
        django.template.loaders.app_directories.Loader: <prj_python37>\.env\lib\site-packages\django\contrib\auth\templates\feed.html (Source does not exist)
        django.template.loaders.app_directories.Loader: <prj_python37>\platzigram\appposts\templates\feed.html (Source does not exist)
        ```
- El tercer parámetro de render es un [contexto](https://docs.djangoproject.com/en/2.1/ref/templates/api/#django.template.Context), un diccionario, son las variables que se pasarán a la plantilla si es necesario.
```py
return render(request,"feed.html",{"name":"Eduardo A.F"})
# en la vista
Tu nombre es: {{ name }}
```
- Instalo bootstrap en feed.html y retoco la generación de los posts
```html
{% for post in posts %}
    <div class="col-lg-4 offset-lg-4">
        <div class="media">
            <img class="mr-3 rounded-circle" src="{{ post.user.picture }}" alt="{{ post.user.name }}">
            <div class="media-body">
                <h5 class="mt-0">{{ post.user.name }}</h5>
                {{ post.timestamp }}
            </div>
        </div>
        <img class="img-fluid mt-3 border rounded" src="{{ post.photo }}" alt="{{ post.title }}">
        <h6 class="ml-1 mt-1">{{ post.title }}</h6>
    </div>
{% endfor %}
```

- [Documentación sobre tags en los templates](https://docs.djangoproject.com/en/2.1/ref/templates/builtins/) Los `% operador % {{ mi_variable }}`

#### 10 Video. [Patrones de diseño](https://platzi.com/clases/1318-django/12407-patrones-de-diseno-y-django/)
- MVC Model View Controller
- Django es cercano al MVC
- **MTV** Model Template View. es el patrón de Django y tiene similitud con MVC
	- Model Define la estructura de los datos
	- Template Presentación de datos
	- View Recupera los datos y los pasa al template

#### 11 Video. [La M en el MTV](https://platzi.com/clases/1318-django/12408-la-quotmquot-en-el-mtv/)
- **settings.py** 
	- Configurando la bd [Doc. oficial](https://docs.djangoproject.com/en/2.1/ref/databases/) 
	- **Migraciones**. El mensaje: `You have 14 unaplied mig (...) to apply them`
	- Detenemos el servidor http.
	- comando: `<project>\prj_python37\platzigram>py manage.py migrate`
	```js
    # settings.py
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }
    }

	# despues de ejecutar el comando:
    Operations to perform:
      Apply all migrations: admin, auth, contenttypes, sessions
    Running migrations:
      Applying contenttypes.0001_initial... OK
      Applying auth.0001_initial... OK
      Applying admin.0001_initial... OK
      Applying admin.0002_logentry_remove_auto_add... OK
      Applying admin.0003_logentry_add_action_flag_choices... OK
      Applying contenttypes.0002_remove_content_type_name... OK
      Applying auth.0002_alter_permission_name_max_length... OK
      Applying auth.0003_alter_user_email_max_length... OK
      Applying auth.0004_alter_user_username_opts... OK
      Applying auth.0005_alter_user_last_login_null... OK
      Applying auth.0006_require_contenttypes_0002... OK
      Applying auth.0007_alter_validators_add_error_messages... OK
      Applying auth.0008_alter_user_username_max_length... OK
      Applying auth.0009_alter_user_last_name_max_length... OK
      Applying sessions.0001_initial... OK    
    ```
    - ![db_django sqlite3 - SQLiteStudio](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/254x239/77c0d9fa7babde5f35cda87397a64b65/image.png)
	- Django usa un ORM para trabjar con multiples sistemas de bd.
	- Cramos un modelo de usuarios.
	- [Doc. Campos](https://docs.djangoproject.com/en/2.1/ref/models/fields/)
	```js
    ERRORS:
    appposts.User.first_name: (fields.E120) CharFields must define a 'max_length' attribute.
    appposts.User.last_name: (fields.E120) CharFields must define a 'max_length' attribute.
    appposts.User.password: (fields.E120) CharFields must define a 'max_length' attribute.
    ```
    - Despues de corregir el modelo
    ```py
    email = models.EmailField(unique=True) 
    password = models.CharField(max_length=100)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)

    bio = models.TextField(blank=True) #permite el campo vacio
    birthdate = models.DateField(blank=True,null=True)

    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)
    ```
    - Ejecutamos comando dentro de env: `python manage.py makemigrations`.
    ```js
    Migrations for 'appposts':
    appposts\migrations\0001_initial.py
    Create model User

    crea fichero en platzigram/appposts/migrations/0001_initial.py
    se ejecuta el manage migrate

    python manage.py migrate
    se ha creado la tabla **appposts_user**
    ```
    - ![Tabla appposts_user](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/200x276/da4d0d55a93673bc80feb7c2dc272cac/image.png)
    - makemigrations busca los cambios en nuestros modelos
    - migrate aplica cambios en la bd

#### 12 Video. [El ORM de Django](https://platzi.com/clases/1318-django/12409-el-orm-de-django/)
- Por defecto Django agrega un id a la tabla. Por esto no hemos definido un campo identificador en el modelo.
- Modificamos el modelo. Se crea campo **is_admin**
- **makemigrations** genera un nuevo fichero 0002_user_is_admin.py
- ![Nuevo campo is_admin](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/600x158/c5b3f5c56f579cf2a9554d21b569181f/image.png)
- ![Nuevo campo en sqlite](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/226x286/9fd63243c39be16b12a71c60ed55c665/image.png)
- Cargando el **shell de Django**
- En (.env): **`py manage.py shell`**
- ![shell python](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/784x68/d060e5f39142641f23268f476378407c/image.png)
```py
from appposts.models import User
eaf = User.objects.create(
	email="hola@gmail.com",
    password = "1234567",
    first_name = "Eduardo",
    last_name = "A.F"
)
eaf.email
eaf.id
eaf.pk
eaf.email = "eaf@email.com"
eaf.save()
eaf.created
eaf.modified

art = User()
art.pk
art.email = "arturo@plzi.com"
art.first_name = "Arturo"
art.last_name = "Mrt"
art.password = "MSIComputer"
art.is_admin = True
art.save()

art.delete()
```

- ![Dato creado](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/600x150/4160147625ee0a5944a32e37605c8816/image.png)
- Creando usuarios:
```py
from datetime import date

users = [
    {
        'email': 'userone@anemail.com',
        'first_name': 'User O',
        'last_name': 'Ne',
        'password': '1234567',
        'is_admin': True
    },
    {
        'email': 'usertwo@anemail.com',
        'first_name': 'Usr',
        'last_name': 'Twoo',
        'password': '987654321'
    },
    {
        'email': 'userthree@anemail.com',
        'first_name': 'Usuario',
        'last_name': 'Tres',
        'password': 'qwerty',
        'birthdate': date(1990, 12,19)
    },
    {
        'email': 'cuatro@anemail.com',
        'first_name': 'Un Usuario',
        'last_name': 'Cuatro',
        'password': 'msicomputer',
        'is_admin': True,
        'birthdate': date(1981, 11, 6),
        'bio': "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    }
]
from appposts.models import User
for user in users:
    obj = User(**user)
    obj.save()
    print(obj.pk, ':', obj.email)
```
- Obteniendo usuarios
```py
from appposts.models import User
user = User.objects.get(email="userone@anemail.com")

users = User.objects.filter(email__endswith="@anemail.com")
users
users = User.objects.all()
users = User.objects.filter(email__endswith="@anemail.com").update(is_admin=True)
users
users = User.objects.filter(email__endswith="@anemail.com")
for u in users:
	print(u.email,":",u.is_admin)
```

#### 13 Doc. [Glosario](https://platzi.com/clases/1318-django/12410-glosario6134/)
- Glosario de: ORM, Templates, Models.

#### 14 Video. [Extendiendo el modelo de usuario](https://platzi.com/clases/1318-django/12411-extendiendo-el-modelo-de-usuario/)
- [Doc. Extending the existing User Model](https://docs.djangoproject.com/en/2.1/topics/auth/customizing/#extending-the-existing-user-model)
- Debemos añadir la siguiente info:
	- website
	- biography
	- phone_number
	- profile picture
	- created
	- modified
- Vamos a crear una nueva app
- Primero borramos la bd: `rm db.sqlite3`
- `py manage.py startapp appusers`
	- Nos crea una app parecida a appposts
- Agrego la nueva app en **settings.py**
- Modificamos **apps.py** (`<project>/platzigram/appusers/apps.py`) `class UsersConfig(AppConfig):`
- Modificamos **models.py**
	- `class Profile(models.Model):` Aqui se configuran los nuevos campos
	- [appusers.models.py class Profile(models.Model):](https://github.com/eacevedof/prj_python37/blob/master/platzigram/appusers/models.py)
	- La tabla asociada se llamará **appusers_profile**
- Definimos relación 1:1 **OneToOneField**
	```ssh
    Applying contenttypes.0001_initial... OK
    Applying auth.0001_initial... OK
    Applying admin.0001_initial... OK
    Applying admin.0002_logentry_remove_auto_add... OK
    Applying admin.0003_logentry_add_action_flag_choices... OK
    Applying appposts.0001_initial... OK
    Applying appposts.0002_user_is_admin... OK
    Applying contenttypes.0002_remove_content_type_name... OK
    Applying auth.0002_alter_permission_name_max_length... OK
    Applying auth.0003_alter_user_email_max_length... OK
    Applying auth.0004_alter_user_username_opts... OK
    Applying auth.0005_alter_user_last_login_null... OK
    Applying auth.0006_require_contenttypes_0002... OK
    Applying auth.0007_alter_validators_add_error_messages... OK
    Applying auth.0008_alter_user_username_max_length... OK
    Applying auth.0009_alter_user_last_name_max_length... OK
    Applying sessions.0001_initial... OK
    ```
- Antes de ejecutar `makemigrations` hay que instalar **pillow**
- En (.env): `pip install pillow` Es necesario para campos tipo **imageField**
- `migrate` crea la tabla **app_users_profile**
	- ![tabla app_users_profile](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/810x367/3d4eaf0b1aefdd7d9dc96182b7cc4d25/image.png)
- Se publica el modelo **Profile**
	```py
    """platzigram/appusers/admin.py"""
    from django.contrib import admin
    # Register your models here.
    from .models import Profile
    admin.site.register(Profile)
    ```
- **Para entrar al panel de administración**
	- [http://localhost:8000/admin/](http://localhost:8000/admin/)
	- Hay que configurar la ruta así: (**urls.py**)
		```py
        from django.urls import path
        from django.contrib import admin
        urlpatterns = [
            path('admin/', admin.site.urls),
        ]
        ```
	- (.env):`python manage.py createsuperuser`
	```js
    # datos de acceso
    Username: admin
    Email address: admin@somedomain.com
    Password: 1234
    Password (again): 1234
    Superuser created successfully.
    ```
    - `createsuperuser` escribe en la tabla **auth_user**
	- ![tabla auth_user](https://trello-attachments.s3.amazonaws.com/5b014dcaf4507eacfc1b4540/5c8401cf1c6b4163c9b2419b/90f79aa8eaeefab392d3ae3d06e082c2/image.png)

#### 16 Video. [Explorando el dashboard de administración](https://platzi.com/clases/1318-django/12413-explorando-el-dashboard-de-administracion/)
- Registrando el **modelo Profile** en el administrador. #registrar modelo
- Para hacer que aparezca el modelo **Profile** en el panel de administración hay que tocar el fichero [**appusers.admin.py**](https://github.com/eacevedof/prj_python37/blob/master/platzigram/appusers/admin.py)
```py
@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    """Profile admin."""
    # esta variable configura la visualización de las columnas del grid
    list_display = ("pk","user","phone_number","website","picture")
    # botones de enlaces en el listado para que vaya al detalle del perfil
    list_display_links = ("pk","user")
    # permitir que se editen campos directamente en el grid de perfiles
    # un campo o es un link o es editable
    list_editable = ("phone_number","website","picture")
    # campos por los que se desea buscar
    search_fields = ("user__username","user__email","user__first_name","user__last_name","phone_number")
    # filtros
    list_filter = ("user__is_active","user__is_staff","created","modified",)
```

#### 17 Video. [Dashboard de Administración](https://platzi.com/clases/1318-django/12414-dashboard-de-administracion/)
- Se adapta el [**admin.py**](https://github.com/eacevedof/prj_python37/blob/master/platzigram/appusers/admin.py) con las siguientes lineas, estas permiten interactuar en la ficha del usuario con los campos del perfil.
- Cuando se cree un usuario se podra ingresar datos del perfil.
- Estos pasos están en la doc oficial de python. (link más arriba)
- **admin.StackedInline**
```py
    # configuración del detalle del perfil
    fieldsets = (
        # Profile es el texto de la barra azul
        ("Profile",{
            "fields":(
                ("user","picture"),
                # ("phone_number", "website"),
            ),
        }),
        ("Extra info", {
            "fields": (
                ("website", "phone_number"),
                ("biography"),
            ),
        }),
        ("Metadata", {
            "fields": (
                ("created", "modified"),
            ),
        }),
    )

    # para poder declarar los campos como metadata deben estar en readonly_fields ya que estos no
    # se pueden modificar
    readonly_fields = ("created","modified")

# sirve para gestionar el perfil en el detalle del usuario
class ProfileInline(admin.StackedInline):
    """Profile in-line admin for users"""
    model = Profile
    can_delete = False
    verbose_name_plural = "Profiles INLINE"

class UserAdmin(BaseUserAdmin):
    """Add profile admin to base user admin """
    inlines = (ProfileInline,)
    list_display = ("username","email","first_name","last_name","is_active","is_staff")

admin.site.unregister(User)
admin.site.register(User,UserAdmin)
```

#### 18 Video. [Creación del modelo de posts](https://platzi.com/clases/1318-django/12415-creacion-del-modelo-de-posts/)
- `# <modulo>.<modelo>` para evitar referencias circulares
	- `profile = models.ForeignKey("appusers.Profile",on_delete=models.CASCADE)`
- Una vez definido el modelo (en .env):
	- `py manage.py makemigrations`  #crea el fichero de migracion
	- `py manage.py migrate` #crea la tabla en la bd
	- `py manage.py runserver`
	- ![Tabla appposts_post](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/326x269/08875254125365aef5f6db7c57af9445/image.png)
- Queda registrar el **modelo Posts** en el administador (reto)
	```py
    #platzigram/appposts/admin.py
    from django.contrib import admin
    # Models
    from .models import Post
    admin.site.register(Post)
    ```
- Queda corregir la visualizacion de la imagén del usuario en el administrador
	- Cuando se hace click sobre el nos lleva a la raiz del administrador
	- Django por defecto no esta preparado para servir "la media"
	- Para esto hay que usar un hack
		- `] + static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)`
		- Hay que editar las URLS urls.py y settings.py
		- En settings.py se definen dos nuevas rutas, que le indicarán a Django que cada vez que se pida un archivo de **media** debe buscar en esas rutas
- La imagen se ha subido a:
	- `<project>/platzigram/media/users/pictures/bob-sponja.jpg`

#### 19 Video. [Templates y archivos estáticos](https://platzi.com/clases/1318-django/12416-templates-y-archivos-estaticos/)
- Vamos a juntar todos los estilos y templates
- La barra de navegación se va a mantener mientras se navega por la app.
- Mientras se hace login se mantiene el contenedor con el logo
- Una **app reutilizable**. Tiene todos los componentes dentro de ella y es portable.
- Creamos una carpeta que se comparta por todas nuestras apps.
- Tenemos que inidcar a Django que nuestros templates estarán en dicha carpeta. (**settings.py - TEMPLATES.DIRS**)
	- `os.path.join(BASE_DIR,"templates")` 
- Carpeta templates:
	```js
    ├───templates
    │   ├───posts
    │   └───users    
    ```
- Movemos **feed.html** dentro de **posts**
- Descomponemos feed en plantillas
	```js
	├───templates    
    │   base.html
    │   nav.html
    ├───posts
    │       feed.html
    └───users
            base.html
    ```
- En settings.py
	```py
    # ruta de donde se recuperarán las vistas
    'DIRS': [
        os.path.join(BASE_DIR,"templates")
    ],    
    ... 
    # se configura la ruta estatica real
    STATICFILES_DIRS = (
        os.path.join(BASE_DIR,"static"),
    )
    STATICFILES_FINDERS = [
        "django.contrib.staticfiles.finders.FileSystemFinder",
        "django.contrib.staticfiles.finders.AppDirectoriesFinder"
    ]    
    ```
- En `templates.base.html`
	```html
        {% block head_content %}{% endblock %}
    	{% load static %}
    	...
        {% include "nav.html" %}
    <div class="container mt-5">
        {% block container %}
        {% endblock %}
    </div>
    ```
- En `posts.feeds.html` **{% extends "base.html" %} **
	```html
    {% extends "base.html" %}
    
    {% block head_content %}
    <title>Platzigram feed</title>
    {% endblock %}

    {% block container %}
        <div class="row">
            {% for post in posts %}
            <div class="col-lg-4 offset-lg-4">
            	...
            </div>
            {% endfor %}
        </div>
    {% endblock %}
    ```
    
#### 20 Video. [Login](https://platzi.com/clases/1318-django/12417-login/)
- Vamos a implementar nuestro login y restringir el acceso al Feed
- Como autenticar peticiones web
	- Se usa el middleware de sesión (el filtro que tiene que pasar la petición)
	- Este middleware nos proveera de **request.user.is_authenticated**
	- Se usa el módulo: `django.contrib.auth`: funciones: `authenticate, login`
	- Recibimos en request.POST las variables de acceso y las evaluamos con la función authenticate(...)
	- Si todo ha ido bien guardamos el usuario como "logado" con la fn: login(r,u)
- La pantalla de login está conformada por dos templates. Base y Login
- Se retocan las rutas y se aplica alias con name="<alias>" de modo que se les  pueda tener identificadas en caso de que cambien
	- Ejemplo en el form
	- `<form method="post" action="{% url "login" %}">`
- En los forms hay que usar `{% csrf_token %}`
- Para poder hacer redirecciones se usa: `from django.shortcuts import render, redirect`
	- En la vista: `return redirect(<alias>)`
- Para los redirects en caso de no estar "logado" se configura en settings.py
	- `LOGIN_URL = "/users/login/"`
- Para hacer el redirect según la sesión se usa en la vista de posts
	```py
	from django.contrib.auth.decorators import login_required
    ...
    @login_required
	def list_posts(request):
    	return render(request,"posts/feed.html",{"posts":posts})
	```

#### 21 Video. [Logout](https://platzi.com/clases/1318-django/12418-logout6923/)
- Para saber como "deslogar" un usuario se puede consultar la [doc how to log a suer out](https://docs.djangoproject.com/en/2.2/_modules/django/contrib/auth/#logout)
- Creamos la ruta `users/logout`
- Creamos una vista en el módulo de usuarios (`appusers.views.py`): **logout_view** 
- Se hace redirect al login en el logout.
- Se usa el docorador **login_required** `from django.contrib.auth.decorators import login_required` para evitar que haga logout de una sesión inexistente.

#### 22 Video. [Signup](https://platzi.com/clases/1318-django/12419-signup/)
- Comprobamos la doc oficial [creating users](https://docs.djangoproject.com/en/2.2/topics/auth/default/#creating-users)
- Se necesita:
	- django.contrib.auth.models 
- El modelo de usuarios (`appusers.models.py`) extiende usando un modelo proxy
- Django tiene señales (**signals**), que son como triggers, cada vez que se crea un usuario entonces creale un perfil.
- Definimos una ruta `users/signup`
- Creamos la **vista y el template signup**
- Configuramos el método **signup_view(request)**
- No sé, si controlando la excepción, es la única forma de comprobar que ya existe el **username** 
```py
# try ya que puede fallar si ya existiera el username
try:
    user = User.objects.create_user(username = username,password = passw)
except IntegrityError:
    return render(request,"users/signup.html", {"error":"Username already exists"})
```
#### 23 Video. [Middlewares](https://platzi.com/clases/1318-django/12420-middlewares9277/)
- Qué son los middlewares.
- Cómo funcionan.
- Qué nos ayudan a resolver.
- **Definición**
	- Es una serie de hooks y una API de bajo nivel que permiten modificar el objeto **`REQUEST y RESPONSE`** antes de que llegue a la vista y despues de que salga de la vista.
- [Django doc - Writing your own middleware](https://docs.djangoproject.com/en/2.2/topics/http/middleware/#writing-your-own-middleware)
```py
def simple_middleware(get_response):
    # One-time configuration and initialization.
    def middleware(request):
        # Code to be executed for each request before
        # the view (and later middleware) are called.
        response = get_response(request)
        # Code to be executed for each request/response after
        # the view is called.
        return response
    return middleware
```
- También se puede usar clases para su interceptación
- Tienen varios métodos
- En **settings.py.MIDDLEWARE (lista)** se definen los middlewares
	- SecurityMiddleware
	- SessionMiddleware
	- CommonMiddleware (debug)
	- CsrfViewMiddleware (token)
	- AuthenticationMiddleware (request.user o anonymous user de las vistas)
	- MessageMiddleware (mensajes de django, te permite definir un mensaje para una petición sin necesidad de mantener un estado)
	- XFramewOptionsMiddleware (seguridad para clickjacking)
- Crearemos nuestro propio middleware que:
	- Nos va a decir que si el usuario no tiene una foto de perfil o no tiene biografia no puede usar la plataforma.
- Definimos ruta `users/me/profile`
- Una vista **users_profile.html**
- Un middleware **platzigram/middleware.py.ProfileCompletionMiddleware**
```py
"""platzigram\middleware.py"""
import pdb
from django.shortcuts import redirect
from django.urls import reverse

class ProfileCompletionMiddleware:
    def __init__(self, fn_get_response):
        self.get_response = fn_get_response

    # __call__ implements function call operator.
    # de modo que se pueda hacer un o = Foo() o(call_arg1,call_arg2...)
    def __call__(self, request):
        if not request.user.is_anonymous:
            profile = request.user.profile
            if not profile.picture or not profile.biography:
                # si la url es update_profile o logout no se aplica el redirect
                if request.path not in [reverse("update_profile"),reverse("logout")]:
                    return redirect("update_profile")

        # pdb.set_trace()
        # get_response es una función
        response = self.get_response(request)
        return response
```

#### 24 Video. [Formularios en Django](https://platzi.com/clases/1318-django/12421-formularios-en-django6487/)
- [Doc. Froms in Django](https://docs.djangoproject.com/en/2.2/topics/forms/#django-s-role-in-forms)
- La clase utilitaria para formularios de Django nos ayuda a resolver mucho del trabajo que se realiza de forma repetitiva. La forma de implementarla es muy similar a la implementación de la clase models.model.
- Algunas de las clases disponibles en Django al implementar form, son:
	- BooleanField
	- CharField
	- ChoiceField
	- TypedChoiceField
	- DateField
	- DateTimeField
	- DecimalField
	- EmailField
	- FileField
	- ImageField
- La validación en el formulario se hará de forma más automática, usando solo la clase forms.Form y el objeto request. En forms.Form se configurarán los **filtros** del request.
- Se usarán las siguientes clases: **ModelForm** y **forms.Form**
- En la doc indica como crear un formulario
- Se define un fichero: **appusers.forms.py** que es una clase tipo: `class NameForm(forms.Form):`
	- Como atributos se toman los campos con sus respectivas validaciones
	- `your_name = forms.CharField(label="Your name",max_length=100)`
- En **views.py**
	- En el método con parámetro **request**
	- Se crea una instancia de la clase **forms.Form(request.POST)**
	- Para validar solo se usa el método **form.is_valid()**
	- [Doc. validar campos en forms](https://docs.djangoproject.com/en/2.2/ref/forms/fields/)
	- Para configurar las validaciones nos podemos apoyar en las restricciones de configuración del módelo
- Cuando se envia datos con **enctype="multipart/form-data"** las imágenes no llegan en **request.POST** sino en **request.FILES**
- Otra cosa importante es que cuando recargamos no reenviamos el formulario esto es gracias al **redirect**. Esto hace que lo que recarguemos seá la última petición, que es un GET.
- `{% load static %}`
- `<img src="{% static 'img/default-profile.png' %}" class="rounded-circle" height="50" />`


## Notas
- `django-admin startproject platzigram .` Creación de un proyecto de Django
- `(env) ~/platzigram con py manage.py startapp appposts` Creación de una app en Django
	- **8 Video.** Tengo que recuperar la **subcarpeta** borrada platzigram
		- Hago copia del proyecto
		- ejecuto: **`git checkout feea6ec -- platzigram/platzigram`** donde `<hash>` es el último punto donde existía la subcarpeta platzigram.
		- Reemplazo los ficheros con el backup.
- Me daba este error:
	- MEDIA_ROOT error : _getfullpathname: path should be string, bytes or os.PathLike, not tuple
	- Tengo que tener cuidado con las `,` despues de una asignación pq aunque parezca un simple string se transforma en una tupla
- Me daba este error:
	- dictionary update sequence element #0 has length 1; 2 is required
	- habia que pasar como alias de la ruta el parámetro name="alias" y no solamente "alias"


