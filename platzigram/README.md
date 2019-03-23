# Platzigram

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
- La app de django no es estricta en lo que a su arbol de carpetas se refiere. Se puede adaptar y escalar según las necesidades de cada proyecto
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

        














## Notas
- `django-admin startproject platzigram .` Creación de un proyecto de Django
- `(env) ~/platzigram con py manage.py startapp appposts` Creación de una app en Django
	- **8 Video.** Tengo que recuperar la **subcarpeta** borrada platzigram
		- Hago copia del proyecto
		- ejecuto: **`git checkout feea6ec -- platzigram/platzigram`** donde `<hash>` es el último punto donde existía la subcarpeta platzigram.
		- Reemplazo los ficheros con el backup.
