# my_django

- [Instalación django by KeepCoding](https://youtu.be/sGYSPaXAlkg?list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl&t=475)
- `pip install virtualenvwrapper-win` wrapper para que funcione el siguiente comando, como en el mac del profesor
- `virtualenv --python=python venv` crea la carpeta de entorno (como el container)
- **`cd venv/Scripts`** entramos en los comandos propios del contenedor 
- ejecutar `activate`  ejecuta el fichero activate.bat
- el opuesto `deactivate`

```ssh
(venv) <project>\my_django\venv\Scripts>
```
- Dentro del entorno virtual ejecutar:
    - `pip install Django`
    - crea dentro de la carpeta scripts dos ficheros:
        - `django-admin.exe`
        - `django-admin.py` 
- `django-admin startproject frikr` (dentro de scripts) crea el proyecto por primera vez
    - crea una carpeta **frikr** dentro de scripts con un fichero `manage.py`
    - dentro de **frikr**
    ```py
    <project>\my_django\venv\Scripts\frikr>dir /s /b
    <project>\my_django\venv\Scripts\frikr\frikr
    <project>\my_django\venv\Scripts\frikr\manage.py
    <project>\my_django\venv\Scripts\frikr\frikr\settings.py
    <project>\my_django\venv\Scripts\frikr\frikr\urls.py
    <project>\my_django\venv\Scripts\frikr\frikr\wsgi.py
    <project>\my_django\venv\Scripts\frikr\frikr\__init__.py
    ```
    ```ssh
    $ pip install django
    Collecting django
      Downloading https://files.pythonhosted.org/packages/c7/87/fbd666c4f87591ae25b7bb374298e8629816e87193c4099d3608ef11fab9/Django-2.1.7-py3-none-any.whl (7.3MB)
    Collecting pytz (from django)
      Downloading https://files.pythonhosted.org/packages/61/28/1d3920e4d1d50b19bc5d24398a7cd85cc7b9a75a490570d5a30c57622d34/pytz-2018.9-py2.py3-none-any.whl (510kB)
    Installing collected packages: pytz, django
    Successfully installed django-2.1.7 pytz-2018.9
    ```
    ```py
    #!/usr/bin/env python
    import os
    import sys
    
    if __name__ == '__main__':
        os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'frikr.settings')
        try:
            from django.core.management import execute_from_command_line
        except ImportError as exc:
            raise ImportError(
                "Couldn't import Django. Are you sure it's installed and "
                "available on your PYTHONPATH environment variable? Did you "
                "forget to activate a virtual environment?"
            ) from exc
        execute_from_command_line(sys.argv)
    
    ```
- [Crear un entorno virutal con pycharm](https://youtu.be/ZX4Eg63aawY?list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl&t=417)
    - [File - settings] o **ctrl+alt+s**
    - Creamos una carpeta de proyecto **Frikr**
    - Dentro de esta un carpeta **venv**
    
- [Crear un nuevo proyecto](https://youtu.be/oX0SoU9OHnE?list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl&t=10)
	- Por norma el entorno virtual de un proyecto o entornos virtuales se deben de tener fuera de la raiz.
	- Por ejemplo en **<root>/mis_entornos/Frikr**
    - ![instalar paquetes con pycharm](https://trello-attachments.s3.amazonaws.com/5b014dcaf4507eacfc1b4540/5c8401cf1c6b4163c9b2419b/7eb4eb5b24cf7218212785080a8627f6/instalando-con-pycharm.png)
    - `(venv) <project>\my_django\Frikr>py ./venv/Scripts/django-admin.py .` con el **.** startproject frikr` crea el proyecto **frikr**
    - Por convenio todos los módulos y apps en python deben estar en minusculas. (**frikr**)
    - ![Como queda el arbol](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/232x203/e40af4b195b12f6230e62e5b9c91afd9/image.png)

- [El archivo de configuración settings](https://www.youtube.com/watch?v=IWc1pIH9wLc&list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl&index=21)
	- <project>\frikr\settings.py
	- **`SECRET_KEY`** Usa django para hacer el cifrado de las contraseñas de los usuarios. Deberiamos cambiarla en producción.
	- **`DEBUG`** En producción debe estar a False
	- **`ALLOWED_HOSTS`**  Desde donde el servidor puede recibir peticiones. Con 0.0.0.0 podría recibir desde cualquiera.
	- **`INSTALLED_APPS`** [(tupla de apps por defecto)](https://youtu.be/IWc1pIH9wLc?list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl&t=124) Aplicaciones por la que está formado mi proyecto.
		-  admin: Admin de django, el backend automático.
		-  auth: Módulo de autenticación, autorización de usuarios grupos y permisos
		-  contenttypes: orm??  Relacionado con los modelos
		-  sessions: Gestor de las sesiones de usuarios.
		-  messages: Se usa para pasar mensajes de una url a otra
		-  staticfiles: Se utiliza para servir archivos estáticos. (Imágenes, .js, .css, etc)
	- **`MIDDLEWARE_CLASSES`** (tupla) Nos ayuda a personalizar el comportamiento entre el framework (django) y nuestra app.
	- **`ROOT_URLCONF`** (string) Donde está el enrutador del proyecto
	- **`TEMPLATES`** (lista) Es el motor de templates de django
	- **`WSGI_APPLICATION`** (string) Web Server Gateway Interface
	- **`DATABASES`** (diccionario) Configuramos las bd de nuestro proyecto. Por defecto es una bd sqlite3. Se pueden definir varias bds.
	- **`AUTH_PASSWORD_VALIDATORS`** ???
	- **`LANGUAGE_CODE`** (string)
	- **`TIME_ZONE`** (string) UTC+2
	- **`USE_I18N`** (boolean) Internacionalización
	- **`USE_L10N`** (boolean) Localización
	- **`USE_TZ`** (boolean) Timezone
	- **`STATIC_URL`** (string) Subcarpeta elementos estáticos. Puede ser un servidor de elementos estáticos.  En producción se cambiaría a un https://&lt;servidor-cdn &gt; (content delivery network)
- [Tutorial más completo y Djangogirls.org](https://tutorial.djangogirls.org/es/django_start_project/)
	- `py manage.py migrate`  Crea la bd
	- `python manage.py runserver` Arranca el servidor
		- url: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
- [Modelos](https://tutorial.djangogirls.org/es/django_models/)
