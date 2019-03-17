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
	- **`python manage.py runserver`**  Arranca el servidor
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
# request.GET = <QueryDict: {'numbers': ['10,4,50,32']}>
numbers = [int(i) for i in request.GET["numbers"].split(",")]
nsorted = sorted(numbers)
# pdb.set_trace()
return HttpResponse(json.dumps(nsorted), content_type="application/json")
```
