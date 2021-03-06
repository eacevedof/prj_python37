## [Platzi - Curso de Flask ](https://platzi.com/clases/flask/)

- Actualizar pip:
  - `python3 -m pip install --upgrade pip` 
  - `pip install pipenv`
- Ojo!! no confundir *pip install* con *pipenv install*

### [5 - Hello World Flask](https://platzi.com/clases/1540-flask/18443-hello-world-flask/)
- Entramos en nuestra carpeta **project**
- Ejecutamos 
  - **pipenv** es equivalente a pip pero dentro de la carpeta virtual, cuando no se tiene activo el entorno (haber ejecutado pipenv shell)
  - `pipenv --three` crea el entorno virtual
  - `pipenv install flask` 
  - creamos archivo. `requirements.txt` con la linea `Flask`
  - `pipenv install -r requirements.txt` r: recursive
- (env): `pip freeze`
```py
Click==7.0
Flask==1.1.1
itsdangerous==1.1.0
Jinja2==2.11.1
MarkupSafe==1.1.1
Werkzeug==1.0.0
```
- Dentro del *env* nos vamos a la carpeta de nuestro proyecto, cd <carpeta-project>
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/630x62/5ef40a10608154f818e43e5e202ecab3/image.png)
```py
# project/main.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World Flask"
```
- (env):`flask run`
- > Error: Could not locate a Flask application. You did not provide the "FLASK_APP" environment variable, and a "wsgi.py" or "app.py" module was not found in the current directory.
  - Falta declarar una variable de entorno (dentro de env)
  - (env):`export FLASK_APP=main.py`
- (env):`flask run`
  ```s
  (project)  <ruta>/project   master ●  flask run
  * Serving Flask app "main.py"
  * Environment: production
    WARNING: This is a development server. Do not use it in a production deployment.
    Use a production WSGI server instead.
  * Debug mode: off
  * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
  ```
- ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/630x91/dad81f743939f0d21449746f9ad4d744/image.png)

- > Cuando se entra en el shell de pipenv, al menos en mac, emula estár en otro ordenador pero con visibilidad sobre todos los recursos de la maquina
```s
── README.md
└── project
    ├── Pipfile
    ├── Pipfile.lock
    ├── main.py
    └── requirements.txt
```
### [6 - Debugging en Flask](https://platzi.com/clases/1540-flask/18444-debugging-en-flask/)
- Cada vez que hay un cambio en el código no se propaga al servidor web de la app.
- Hay que reiniciar el servicio
- Hay que activar el debug para que se auto refresque
- También mostrará el error si lo hubiera
- (env):`export FLASK_DEBUG=1`

### [7 - Request y Response](https://platzi.com/clases/1540-flask/18445-request-y-response/)
```py
# project/main.py
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def hello():
    userip = request.remote_addr
    return "Hola tu ip es {}".format(userip)
```
### [8 - Ciclos de Request y Response](https://platzi.com/clases/1540-flask/18446-ciclos-de-request-y-response/)
```py
# project/main.py
from flask import Flask, request, make_response, redirect

app = Flask(__name__)

@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    response.set_cookie("user_ip",user_ip+" :) ")
    return response

@app.route("/hello")
def hello():
    userip = request.cookies.get("user_ip")
    return "Hola tu ip es {}".format(userip)
```
### [9 - Templates con Jinja 2](https://platzi.com/clases/1540-flask/18447-templates-con-jinja-2/)
```py
# project/main.py
from flask import ... render_template

@app.route("/hello")
def hello():
    userip = request.cookies.get("user_ip")
    # return "Hola tu ip es {}".format(userip)
    return render_template("hello.html",user_ip=userip)
```
- hello.html:
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello</title>
</head>
<body>
  <h1>Hello {{ user_ip }}</h1>
</body>
</html>
```
### [10 - Estructuras de control](https://platzi.com/clases/1540-flask/18448-estructuras-de-control/)
```py
todos = ["TODO 1","TODO 2","TODO 3"]

@app.route("/hello")
def hello():
    userip = request.cookies.get("user_ip")
    context = {
        "user_ip":userip,
        "todos":todos
    }
    # spread operator
    return render_template("hello.html",**context)
```
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hello</title>
</head>
<body>
{% if user_ip %}
  <h1>Hello {{ user_ip }}</h1>
{% else %}
  <a href="{{ url_for("index") }}"> Ir a inicio</a>
{% endif %}
</body>
</html>

<body>
{% if user_ip %}
  <h1>Hello {{ user_ip }}</h1>
{% else %}
  <a href="{{ url_for("index") }}"> Ir a inicio</a>
{% endif %}

<ul>
  {% for todo in todos %}
    <li>{{ todo }}</li>
  {% endfor %}
</ul>
</body>
```

### [11 - Herencia de templates](https://platzi.com/clases/1540-flask/18449-herencia-de-templates/)
> Macro: son un conjunto de comandos que se invocan con una palabra clave, opcionalmente seguidas de parámetros que se utilizan como código literal. Los Macros son manejados por el compilador y no por el ejecutable compilado.
- macro.html:
```html
{% macro render_todo(todo) %}
    <li>descripcion: {{ todo }}</li>
{% endmacro %}
```
- base.html:
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{% block title %} Flask {% endblock %}</title>
</head>
<body>
{% block content %}
{% endblock %}
</body>
</html>
```
- hello.html
```html
{% extends "base.html" %}
{% import "macro.html" as macros%}

{% block title %} {{ super() }} | Bienvenida {% endblock %}

{% block content %}
  {% if user_ip %}
    <h1>Hello {{ user_ip }}</h1>
  {% else %}
    <a href="{{ url_for("index") }}"> Ir a inicio</a>
  {% endif %}

  <ul>
    {% for todo in todos %}
      {{ macros.render_todo(todo) }}
    {% endfor %}
  </ul>
{% endblock %}
```
### [12 - Include y links](https://platzi.com/clases/1540-flask/18450-include-y-links/)
- Barra de navegación
```html
<!-- navbar.html -->
<nav>
  <ul>
    <li><a href="{{ url_for("index") }}">Home</a></li>
    <li><a href="http://eduardoaf.com" target="_blank">Eduardo site</a></li>
  </ul>
</nav>
<!-- /navbar.html -->

<!-- base.html -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{% block title %} Flask {% endblock %}</title>
</head>
<body>
  <header>
    {% include "navbar.html" %}
  </header>
{% block content %}
{% endblock %}
</body>
</html>
```
### [13 - Uso de archivos estáticos: imágenes](https://platzi.com/clases/1540-flask/18451-uso-de-archivos-estaticos-imagenes/)
- Crear directorio **project/static/**
- configuro bundle.js (no tutorial)
```s
project
    ├── Pipfile
    ├── Pipfile.lock
    ├── main.py
    ├── requirements.txt
    ├── static
    │   ├── css
    │   │   └── main.css
    │   ├── images
    │   │   ├── favicon.ico
    │   │   └── logo-brain.jpg
    │   └── js
    │       ├── bundle.js
    │       └── modules
    │           └── root
    │               └── root.js
    └── templates
        ├── base.html
        ├── hello.html
        ├── macro.html
        └── navbar.html
```
```html
<!-- base.html -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="static/images/favicon.ico"/>
  <title>{% block title %} Flask {% endblock %}</title>
  <link rel="stylesheet" href="static/css/main.css" />
  <script type="module" src="static/js/bundle.js" defer></script>
</head>
<body>
  <header>
    {% include "navbar.html" %}
  </header>
{% block content %}
{% endblock %}
</body>
</html>
<!-- navbar.html -->
<nav>
  <ul>
    <li><img src="{{ url_for("static", filename="images/logo-brain.jpg") }}" alt="mi-logo"></li>
    <li><a href="{{ url_for("index") }}">Home</a></li>
    <li><a href="http://eduardoaf.com" target="_blank">Eduardo site</a></li>
  </ul>
</nav>
<!-- /navbar.html -->
```

### [14 - Configurar páginas de error](https://platzi.com/clases/1540-flask/18452-configurar-paginas-de-error/)
- Tratando error 404. Not found
- Reto para error 500
- Creamos fichero **templates/404.html**
```html
<!-- 404.html -->
{% extends "base.html" %}
{% block title %}
  {{ super() }}
  404
{% endblock %}

{% block content %}
  <h1>Lo sentimos no encontramos lo que buscabas</h1>
  <p>
  {{ error }}
  </p>
{% endblock %}
<!--/404.html -->
```
```py
...
@app.errorhandler(404)
def not_found(error):
    return render_template("404.html",error=error)
```
#### Reto:
- crear fichero 500.html
- tratar el error con `app.errohandler(500)`
### [15 - Flask Bootstrap](https://platzi.com/clases/1540-flask/18453-flask-bootstrap/)
- > Framework: es un conjunto estandarizado de conceptos, prácticas y criterios para enfocar un tipo de problemática particular que sirve como referencia, para enfrentar y resolver nuevos problemas de índole similar.
- Las extensiones de flask nos permiten agregar funcionalidad a Flask, por ejemplo para enviar email
- En este caso agregaremos bootstrap4.css
- Agregamos: `flask-bootstrap4` en `requirements.txt`
- Ejecutamos: (env):`pip install -r requirements.txt`
- Una vez instalada la extensión hay que incializarla
```py
# project/main.py
from flask import Flask, request, make_response, redirect, render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)

bootstrap = Bootstrap(app)

@app.errorhandler(404)
def not_found(error):
  ...
```
```html
<!-- base.html -->
{% extends "bootstrap/base.html" %}

{% block head %}
  {{ super() }}
  <link rel="icon" href="static/images/favicon.ico"/>
  <title>{% block title %} Flask {% endblock %}</title>
  <link rel="stylesheet" href="static/css/main.css" />
  <!--al final tengo que incluir casi todo yo pq el que trae flask da error 403 y/o no incluye js-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
  <script type="module" src="static/js/bundle.js" defer></script>
{% endblock %}

{% block body %}
<!-- block-body -->
  {% block navbar %}
    {% include "navbar.html" %}
  {% endblock %}
  
  {% block content %} {% endblock %}  
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>  
<!-- /block-body -->  
{% endblock %}

<!-- navbar.html -->
<div class="navbar navbar-inverse" role="navigation">
  <div class="container">
      <div class="navbar-header">
          <button type="button"
                  class="navbar-toggle"
                  data-toggle="collapse"
                  data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="{{ url_for('index') }}">
            <img src="{{ url_for('static', filename='images/logo-brain.jpg') }}"
                 style="max-width: 48px"
                 alt="logo-brain logo">
        </a>          
      </div>

      <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
              <li><a href="{{ url_for('index') }}">Inicio</a></li>
              <li><a href="https://eduardoaf.com" target="_blank">eduardoaf.com</a></li>
          </ul>
      </div>
  </div>
</div>
<!-- /navbar.html -->
```
- **NO FUNCIONA BIEN LA EXTENSION!!!**

### [16 - Configuración de Flask](https://platzi.com/clases/1540-flask/18454-configuracion-de-flask/)
- >SESSION: es un intercambio de información interactiva semipermanente, también conocido como diálogo, una conversación o un encuentro, entre dos o más dispositivos de comunicación, o entre un ordenador y usuario.
-  Desactivar el debug para producción
- `export FLASK_ENV=development`
- Con esta variable de entorno se rescribe la de produccion (FLASK_DEBUG)
- Objeto SESSION
- Ejemplo cookie cifrada:
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/630x528/c044ca9baa5cc57dfee333db2feb6a60/image.png)
```py
from flask import  ..., session
# con esto se cifra la info de la cookie
# esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale
app.config["SECRET_KEY"] = "super secreto"
...
@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    # response.set_cookie("user_ip",user_ip+" :) ")
    session["user_ip"] = user_ip
    return response
...
@app.route("/hello")
def hello():
    # userip = request.cookies.get("user_ip")
    user_ip = session.get("user_ip")
    context = {
        "user_ip":user_ip,
        "todos":todos
    }
    # spread operator
    return render_template("hello.html",**context)
```
- Aparte de session Flask cuenta con otros dos objetos:
  - current_app
  - g (con cada request se limpia)
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/940x494/e7b03ccfc68f03adf4f75b927c1aad81/image.png)

### [17 - Implementación de Flask-Bootstrap y Flask-WTF](https://platzi.com/clases/1540-flask/18455-implementacion-de-flask-bootstrap-y-flask-wtf/)
- Instalar extension Flask-WTF  (What the forms)
- WTF es una libreria de python que permite renderizar formularios y funciona en cualquier app de python
- Agregamos en requirements: flask-wtf
- instalamos y arrancamos nuevamente el servidor: flask run
- Uso de validadores, existen también custom validadores
```py
from flask_wtf import FlaskForm
from wtforms.fields import StringField, PasswordField,SubmitField
from wtforms.validators import DataRequired

class LoginForm(FlaskForm):
    username = StringField("Nombre de usuario",validators=[DataRequired()])
    password = PasswordField("Password",validators=[DataRequired()])
    submit = SubmitField("Enviar")

def hello():
    # userip = request.cookies.get("user_ip")
    user_ip = session.get("user_ip")
    loginform = LoginForm()
    context = {
        "user_ip":user_ip,
        "todos":todos,
        "loginform":loginform
    }
    # spread operator
    return render_template("hello.html",**context)
```
```html
<!-- hello.html -->
{% extends "base.html" %}
{% import "macro.html" as macros%}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %} {{ super() }} | Bienvenida {% endblock %}

{% block content %}
  {% if user_ip %}
    <h1>Hello {{ user_ip }}</h1>
  {% else %}
    <a href="{{ url_for("index") }}"> Ir a inicio</a>
  {% endif %}

  <div class="clontainer">
<!--
    <form action="{{ url_for("hello") }}" method="POST">
      {{ loginform.username.label }}
      {{ loginform.username }}
      {{ loginform.password.label }}
      {{ loginform.password }}
    </form>
-->    
  {{ wtf.quick_form(loginform) }}
  </div>

  <ul>
    {% for todo in todos %}
      {{ macros.render_todo(todo) }}
    {% endfor %}
  </ul>
{% endblock %}
<!--/hello.html -->
```
- en este punto ya se ve el form pero al hacer submit muestra error **Method not allowed***
- lo veremos en el prox capítulo
### [18 - Uso de método POST en Flask-WTF](https://platzi.com/clases/1540-flask/18456-uso-de-metodo-post-en-flask-wtf/)
- > Flask acepta peticiones GET por defecto y por ende no debemos declararla en nuestras rutas. Pero cuando necesitamos hacer una petición POST al enviar un formulario debemos declararla de la siguiente manera, como en este ejemplo: `@app.route('/platzi-post', methods=['GET', 'POST'])`
- > Debemos declararle además de la petición que queremos, GET, ya que le estamos pasando el parámetro methods para que acepte solo y únicamente las peticiones que estamos declarando. De esta forma, al actualizar el navegador ya podremos hacer la petición POST a nuestra ruta deseada y obtener la respuesta requerida.
```py
from flask import Flask, request, make_response, redirect, render_template, session, redirect, url_for
...
@app.route("/hello",methods=["GET","POST"])
def hello():
    # userip = request.cookies.get("user_ip")
    user_ip = session.get("user_ip")
    loginform = LoginForm()
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":todos,
        "loginform":loginform,
        "username":username
    }

    if loginform.validate_on_submit():
        username = loginform.username.data
        session["username"] = username
        password = loginform.password.data
        return redirect(url_for("index"))

    # spread operator
    return render_template("hello.html",**context)
```
```html
<!-- hello.html -->
{% extends "base.html" %}
{% import "macro.html" as macros%}
{% import "bootstrap/wtf.html" as wtf %}

{% block title %} {{ super() }} | Bienvenida {% endblock %}

{% block content %}
  {% if username %}
    <h1>Bienvenido {{ username | capitalize }}</h1>
  {% endif %}
  {% if user_ip %}
    <h3>tu ip es: {{ user_ip }}</h3>
  {% else %}
    <a href="{{ url_for("index") }}"> Ir a inicio</a>
  {% endif %}

  <div class="clontainer">
  {{ wtf.quick_form(loginform) }}
  </div>

  <ul>
    {% for todo in todos %}
      {{ macros.render_todo(todo) }}
    {% endfor %}
  </ul>
{% endblock %}
<!--/hello.html -->
```
- ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/527x436/fee65f507cbae50b3ca133acf430406c/image.png)

### [19 - Desplegar Flashes (mensajes emergentes)](https://platzi.com/clases/1540-flask/18457-desplegar-flashes-mensajes-emergentes/)
- Mensaje de exito despues de iniciar la sesion  correctamente
```py
import , url_for, flash
@app.route("/hello",methods=["GET","POST"])
def hello():
    # userip = request.cookies.get("user_ip")
    user_ip = session.get("user_ip")
    loginform = LoginForm()
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":todos,
        "loginform":loginform,
        "username":username
    }

    if loginform.validate_on_submit():
        username = loginform.username.data
        session["username"] = username
        flash("Nombre de usuario registrado con exito")
        password = loginform.password.data
        return redirect(url_for("index"))

    # spread operator
    return render_template("hello.html",**context)
```
```html
<!-- base.html -->
{% extends "bootstrap/base.html" %}

{% block head %}
  {{ super() }}
  <link rel="icon" href="static/images/favicon.ico"/>
  <title>{% block title %} Flask {% endblock %}</title>
  <link rel="stylesheet" href="static/css/main.css" />
  <!--al final tengo que incluir casi todo yo pq el que trae flask da error 403 y/o no incluye js-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
  <script type="module" src="static/js/bundle.js" defer></script>
{% endblock %}

{% block body %}
<!-- block-body -->
  {% block navbar %}
    {% include "navbar.html" %}
  {% endblock %}
  
  {% for message in get_flashed_messages() %}
    <div class="alert alert-success alert-dismissable">
      <button type="button" data-dism="alert" class="close">&times;</button>
      {{ message }}
    </div>
  {% endfor %}

  {% block content %} {% endblock %}  

  {% block scripts %}{{ super() }}{% endblock%}  ->>> importante
  
<!-- /block-body -->  
{% endblock %}
```
- Ya importa los scripts de base() pero sigue sin funcionar la x de la alerta
- ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/577x235/eb2176f6d1f0c21c2b1e642ce3202ed2/image.png)

### [20 - Pruebas básicas con Flask-testing](https://platzi.com/clases/1540-flask/18458-pruebas-basicas-con-flask-testing/)
- > La etapa de pruebas se denomina testing y se trata de una investigación exhaustiva, no solo técnica sino también empírica, que busca reunir información objetiva sobre la calidad de un proyecto de software, por ejemplo, una aplicación móvil o un sitio web. El objetivo del testing no solo es encontrar fallas sino también aumentar la confianza en la calidad del producto, facilitar información para la toma de decisiones y detectar oportunidades de mejora.
- Instalamos: `flask-testing`
- Hay que crear un comando para que se ejecute cada vez que se hace algun cambio
```py
# projects/main.py
import unittest 

# se llamara con: flask test
@app.cli.command()
def test():
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)


# project/tests/test_base.py
print("test_base.py")
from flask_testing import TestCase
from flask import current_app, url_for

from main import app

class MainTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la app
    def create_app(self):
        app.config["TESTING"] = True
        app.config["WTF_CSRF_ENABLED"] = False
        return app

    def test_app_exists(self):        
        # self.assertIsNone(current_app)
        self.assertIsNotNone(current_app)

    def test_app_in_test_mode(self):
        self.assertTrue(current_app.config["TESTING"])
    
    def test_index_redirect(self):
        response = self.client.get(url_for("index"))
        # self.assertTrue(response.status_code)
        self.assertRedirects(response, url_for("hello"))

    def test_hello_get(self):
        response = self.client.get(url_for("hello"))
        self.assert200(response)

    # prueba de post
    def test_hello_post(self):
        dicformdata = {
            "username":"fake",
            "password":"fake-passs"
        }
        response = self.client.post(url_for("hello"),data=dicformdata)
        self.assertRedirects(response,url_for("index"))

```
```s
# ejemplo ejecución comando
(project)  ioedu@mbp2014  ~/projects/prj_python37/platziflask/project$ flask test
test_base.py
.....
----------------------------------------------------------------------
Ran 5 tests in 0.079s
OK
```
### [21 - Planteamiento del proyecto: To Do List](https://platzi.com/clases/1540-flask/18459-planteamiento-del-proyecto-to-do-list/)
- Se organizará mejor el código
- Se instalara extension de login
- Haremos uso de app-engine para el despliegue
### [22 - App Factory](https://platzi.com/clases/1540-flask/18460-app-factory/)
- Restructuramos codigo en ficheros y movemos las carpetas dentro de app
```py
# project/app/__init__.py
from flask import Flask
from flask_bootstrap import Bootstrap
from .config import Config

def create_app():
    app = Flask(__name__)
    bootstrap = Bootstrap(app)
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    return app

# project/app/config.py
class Config:
    SECRET_KEY = "SUPER_SECRET"

# project/app/forms.py
from flask_wtf import FlaskForm
from wtforms.fields import StringField, PasswordField,SubmitField
from wtforms.validators import DataRequired

class LoginForm(FlaskForm):
    username = StringField("Nombre de usuario",validators=[DataRequired()])
    password = PasswordField("Password",validators=[DataRequired()])
    submit = SubmitField("Enviar")

# project/main.py
from flask import request, make_response, redirect, render_template, session, redirect, url_for, flash
import unittest 

# from folder-app import __init__.py.def create_app
from app import create_app
from app.forms import LoginForm

app = create_app()

@app.errorhandler(404)
def not_found(error):
    ...
```
- Despues del refactor:
```s
project
    ├── Pipfile
    ├── Pipfile.lock
    ├── app
    │   ├── __init__.py
    │   ├── config.py
    │   ├── forms.py
    │   ├── static
    │   │   ├── css
    │   │   │   └── main.css
    │   │   ├── images
    │   │   │   ├── favicon.ico
    │   │   │   └── logo-brain.jpg
    │   │   └── js
    │   │       ├── bundle.js
    │   │       └── modules
    │   │           └── root
    │   │               └── root.js
    │   └── templates
    │       ├── 404.html
    │       ├── 500.html
    │       ├── base.html
    │       ├── hello.html
    │       ├── macro.html
    │       └── navbar.html
    ├── main.py
    ├── requirements.txt
    └── tests
        └── test_base.py
```
### [23 - Uso de Blueprints](https://platzi.com/clases/1540-flask/18461-uso-de-blueprints/)
- > Blueprints son módulos con los que se construyen las aplicaciones Flask. Los objetos Blueprints son similares a Flask, pero con la diferencia de que una aplicación sólo tendrá un objeto Flask, mientras que puede tener varios Blueprints. La ventaja de su uso es que para aplicaciones largas puedo distribuir el código en varios ficheros, en lugar de tenerlos todo en un único fichero.
- Son módulos en forma de plugins
- **Eror**
  - > runtimeError: Your version of Flask doesn't support signals. This requires Flask 0.6+ with the blinker module installed.
  - Señales es lo que usa flask para enviar mensajes a traves de contextos y/o librerias
  - Hay que instalar blinker (requirments.txt)
```py
# =================================
# project/app/auth/__init__.py
from flask import Blueprint

# todas las rutas que empiecen por /auth van a ser redirigidas a este blueprint
auth = Blueprint("auth",__name__,url_prefix="/auth")

# @auth.route("/login") importo funcion login()
from . import views

# =================================
# project/app/auth/views.py
from flask import render_template

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth

# blueprint.route("auth/<ruta>")
@auth.route("/login")
def login():
    context = {
        "loginform": LoginForm()
    }
    return render_template("login.html",**context)

# =================================
# project/app/__init__.py
from flask import Flask
from flask_bootstrap import Bootstrap
from .config import Config

# importo el blueprint: auth = Blueprint("auth",__name__,url_prefix="/auth")
from .auth import auth

def create_app():
    app = Flask(__name__)
    bootstrap = Bootstrap(app)
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    app.register_blueprint(auth)

    return app

# =================================
# project/tests/test_base.py
    # metodo obligatorio que tiene que devolver la app
    def create_app(self):
        app.config["TESTING"] = True
        app.config["WTF_CSRF_ENABLED"] = False
        return app
    ...

    def test_auth_blueprint_exists(self):
        self.assertIn("auth",self.app.blueprints)

    def test_auth_login_get(self):
        # auth.login: blueprint de auth, ruta login
        response = self.client.get(url_for("auth.login"))
        self.assert200(response)

    def test_auth_login_template(self):
        # aqui no se usa response, la comunicacion entre client.get y el assertemplate
        # se hace con signals
        self.client.get(url_for("auth.login"))
        self.assertTemplateUsed("login.html")
```
- Instalación de linker para las señales en los test
```html
<!--login.html-->
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %} ->>>>>>> importante
{% block title %}
  {{ super() }}
  Login
{% endblock %}

{% block content %}
  <div class="container">
    {{ wtf.quick_form(loginform) }}
  </div>
{% endblock %}
<!--/login.html-->
```
### [24 - Blueprints II](https://platzi.com/clases/1540-flask/18462-blueprints-ii/)
- Ya no aceptaremos POST en hello
```py
# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth

# blueprint.route("auth/<ruta>")
@auth.route("/login", methods=["GET","POST"])
def login():

    loginform = LoginForm()
    context = {
        "loginform": loginform
    }

    if loginform.validate_on_submit():
        username = loginform.username.data
        session["username"] = username
        flash("Nombre de usuario registrado con exito")
        password = loginform.password.data
        return redirect(url_for("index"))
        
    return render_template("login.html",**context)

# project/tests/test_base.py
print("test_base.py")
from flask_testing import TestCase
from flask import current_app, url_for

from main import app

class MainTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la app
    def create_app(self):
        app.config["TESTING"] = True
        app.config["WTF_CSRF_ENABLED"] = False
        return app
    ...
    # prueba de post
    def test_hello_post(self):
        response = self.client.post(url_for("hello"))
        # espero un Not Allowed
        self.assertTrue(response.status_code,405)

    ...
    def test_auth_login_post(self):
        dicformdata = {
            "username":"fake",
            "password":"fake-passs"
        }
        response = self.client.post(url_for("auth.login"),data=dicformdata)
        self.assertRedirects(response,url_for("index"))

# project/main.py
@app.route("/hello",methods=["GET","POST"])
def hello():
    user_ip = session.get("user_ip")
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":todos,
        "username":username
    }

    # spread operator
    return render_template("hello.html",**context)
```
```html
<!-- hello.html -->
  se quita el form de aqui
```
### [25 - Base de datos y App Engine con Flask](https://platzi.com/clases/1540-flask/18463-base-de-datos-y-app-engine-con-flask/)
- >Bases de Datos SQL: su composición esta hecha con bases de datos llenas de tablas con filas que contienen campos estructurados. No es muy flexible pero es el más usado. Una de sus desventajas es que mientras más compleja sea la base de datos más procesamiento necesitará.
- >Base de Datos NOSQL: su composición es no estructurada, es abierta y muy flexible a diferentes tipos de datos, no necesita tantos recursos para ejecutarse, no necesitan una tabla fija como las que se encuentran en bases de datos relacionales y es altamente escalable a un bajo costo de hardware.
- Flask no tiene un ORM como tal
- Hay extensiones como Flask SQLAlchemy
- Usaremos **google firestore**, el mongo de google.
- ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/970x306/bea4651d54b32a930cc7b3f67feeec27/image.png)

### [26 - Configuración de Google Cloud SDK](https://platzi.com/clases/1540-flask/18834-configuracion-de-google-cloud-sdk/)
- Para Windows dirígete a https://cloud.google.com/sdk/docs/quickstart-windows
- Para MacOS dirígete a link ~https://cloud.google.com/sdk/docs/quickstart-macos~ https://cloud.google.com/sdk/docs/downloads-interactive
  ```s
  curl https://sdk.cloud.google.com | bash
  exec -l $SHELL
  gcloud init
  ```
  - Crea entradas en el fichero del terminal:
  ```
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/Users/<my-user>/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/<my-user>/google-cloud-sdk/path.zsh.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/Users/<my-user>/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/<my-user>/google-cloud-sdk/completion.zsh.inc'; fi
  ```
- Para Linux dirígete a https://cloud.google.com/sdk/docs/quickstart-linux
- Resultado instalación: [Trello](https://trello.com/c/87odm7iZ/1-instalacion-del-sdk-en-mac)
### [27 - Configuración de proyecto en Google Cloud Platform](https://platzi.com/clases/1540-flask/18464-configuracion-de-proyecto-en-google-cloud-platform/)
- Creamos el proyecto un proyecto en **firestore**
- Vamos a la configuración: [flask-platzi-todo](https://console.cloud.google.com/firestore/welcome?project=flask-platzi-todo&folder=&organizationId=)
- Usaremos **Modo Nativo**
- ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/667x452/0a274c774dcfcf20ae633008af109d62/image.png)
- Creamos la bd: 
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/771x297/ea0ea71775af54f6b884811ae02abfde/image.png)
- Ejecutamos: 
  - `gcloud auth login`
  - Nos abrira la ventana del navegador para confirmar permisos
  ```
  You are now logged in as [XXX@XXX.YYY].
  Your current project is [flask-platzi-todo].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
  ```
  - **API:**
  - Para poder usar la API necesitamos otro comando:
  - `gcloud auth application-default login`
  - Pide permisos en el browser
  ```
  Credentials saved to file: [/Users/<my-user>/.config/gcloud/application_default_credentials.json]
  These credentials will be used by any library that requests Application Default Credentials (ADC).
  ```

### [28 - Implementación de Firestore](https://platzi.com/clases/1540-flask/18465-implementacion-de-firestore/)
- Instalamos firebase-admin (requirements)
  - `pip install -r requirements.txt`
- Parentesis: si tenemos seleccionado un proyecto en gcloud y no es el que debe ser, podemos cambiarlo con:
  - `gcloud config list`
  - `gcloud config set project flask-platzi-todo`

```py
# project/app/services/firestore.py
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

credential = credentials.ApplicationDefault()
firebase_admin.initialize_app(credential)

db = firestore.client()

def get_users():
    return db.collection("users").get()

def get_todos(userid):
    return db.collection("users")\
            .document(userid)\
            .collection("todos").get()

# project/main.py
...
from app.services.firestore import get_users, get_todos

@app.route("/hello",methods=["GET","POST"])
def hello():
    user_ip = session.get("user_ip")
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":get_todos(userid=username),
        "username":username
    }

    # devuelve un generator
    genusers = get_users()
    #pprint(users)
    #pprint(type(users))

    for objuser in genusers:
        #objuser: <google.cloud.firestore_v1.document.DocumentSnapshot object at 0x10eaec790>
        print(objuser.id)
        print(objuser.to_dict()["password"])

    # spread operator
    return render_template("hello.html",**context) 
```
```html
<!-- macro.html -->
{% macro render_todo(todo) %}
    <li>descripcion: {{ todo.to_dict().description }}</li>
{% endmacro %}
<!-- /macro.html -->
```
### [29 - Autenticación de usuarios: Login](https://platzi.com/clases/1540-flask/18466-autenticacion-de-usuarios-login/)
- Instalamos flask-login
- Implementamos un login manager 
- Proteccion de rutas con decoradores
```
Exception
Exception: Missing user_loader or request_loader. 
Refer to http://flask-login.readthedocs.io/#how-it-works for more info.
```
- Agregando definicion de parámetros en el comentario:
```py
  """
  ;param user_data: Userdata
  """
```
```py
# project/app/models/user.py
from flask_login import UserMixin
from app.services.firestore import get_user

class UserData:
    def __init__(self,username, password):
        self.username = username
        self.password = password

class UserModel(UserMixin):
    def __init__(self,user_data):
        """
        ;param user_data: Userdata
        """
        self.id = user_data.username
        self.password = user_data.password

    @staticmethod
    def query(userid):
        userdoc = get_user(userid)
        userdata = UserData(
            username = userdoc.id,
            password = userdoc.to_dict()["password"]
        )

        return UserModel(userdata)
# firestore.py
def get_user(userid):
    return db.collection("users").document(userid).get()

# project/app/__init__.py
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_login import LoginManager
from .config import Config
# importo el blueprint: auth = Blueprint("auth",__name__,url_prefix="/auth")
from .auth import auth
from app.models.user import UserModel

login_manager = LoginManager()
# print(login_manager)
login_manager.login_view = "auth.login"

@login_manager.user_loader
def load_user(username):
    return UserModel.query(username)

def create_app():
    app = Flask(__name__)
    bootstrap = Bootstrap(app)
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    login_manager.init_app(app)
    app.register_blueprint(auth)

    return app
```
- El error anterior se resolvia configurando el: `@login_manager.user_loader`
### [30 - Autenticación de usuarios: Logout](https://platzi.com/clases/1540-flask/18467-autenticacion-de-usuarios-logout/)
- 
```py
# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for
from flask_login import login_user, login_required, logout_user

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth
from app.services.firestore import get_user
from app.models.user import UserData, UserModel

# blueprint.route("auth/<ruta>")
@auth.route("/login", methods=["GET","POST"])
def login():

    loginform = LoginForm()

    if loginform.validate_on_submit():
        username = loginform.username.data
        password = loginform.password.data

        userdoc = get_user(username)
        if userdoc.to_dict() is not None:
            passdb = userdoc.to_dict()["password"]

            if passdb == password:
                userdata = UserData(username, password)
                #user = UserData(username, password)
                user = UserModel(userdata)
                login_user(user)
                flash("Bienvenido de nuevo")
                redirect(url_for("hello"))
            else:
                flash("La informacion no coincide")
        else:
            flash("El usuario no existe")

        return redirect(url_for("index"))
    
    context = {
        "loginform": loginform
    }        
    return render_template("login.html",**context)


@auth.route("logout")
@login_required
def logout():
    logout_user()
    flash("Regresa pronto")
    return redirect(url_for("auth.login"))

# project/main.py
@app.route("/hello",methods=["GET"])
@login_required
def hello():
    user_ip = session.get("user_ip")
    username = current_user.id
```
```html
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0 bg-dark">
        <li class="nav-item"><a class="nav-link text-white" href="{{ url_for('index') }}">Inicio</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="{{ url_for('auth.login') }}">Login</a></li>
        {% if current_user.is_authenticated %}
          <li class="nav-item"><a class="nav-link text-white" href="{{ url_for('auth.logout') }}">Logout</a></li>
        {% endif %}
        <li class="nav-item"><a class="nav-link text-white" href="https://eduardoaf.com" target="_blank">eduardoaf.com</a></li>
    </ul>
  </div>
</nav>
<!-- /navbar.html -->
```
### [31 - Signup](https://platzi.com/clases/1540-flask/18468-signup/)
```py
# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for
from flask_login import login_user, login_required, logout_user

from werkzeug.security import generate_password_hash

# clase LoginForm con el formulario
from app.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import auth
from app.services.firestore import get_user, user_put
from app.models.user import UserData, UserModel

# blueprint.route("auth/<ruta>")
@auth.route("/login", methods=["GET","POST"])
def login():

    loginform = LoginForm()

    if loginform.validate_on_submit():
        username = loginform.username.data
        password = loginform.password.data

        userdoc = get_user(username)
        if userdoc.to_dict() is not None:
            passdb = userdoc.to_dict()["password"]

            if passdb == password:
                userdata = UserData(username, password)
                #user = UserData(username, password)
                user = UserModel(userdata)
                login_user(user)
                flash("Bienvenido de nuevo")
                redirect(url_for("hello"))
            else:
                flash("La informacion no coincide")
        else:
            flash("El usuario no existe")

        return redirect(url_for("index"))
    
    context = {
        "loginform": loginform
    }        
    return render_template("login.html",**context)


@auth.route("signup",methods=["GET","POST"])
def signup():
    signupform = LoginForm()
    context = {
        "signupform":signupform
    }

    if signupform.validate_on_submit():
        username = signupform.username.data
        password = signupform.password.data

        userdoc = get_user(username)
        if userdoc.to_dict() is None:
            passwordhash = generate_password_hash(password)
            userdata = UserData(username, passwordhash)
            user_put(userdata)
            user = UserModel(userdata)
            login_user(user)
            flash("bienvenido")
            return redirect(url_for("hello"))
        else:
            flash("El usuario ya existe")


    return render_template("signup.html",**context)


@auth.route("logout")
@login_required
def logout():
    logout_user()
    flash("Regresa pronto")
    return redirect(url_for("auth.login"))

# project/app/services/firestore.py

def user_put(userdata):
    userref = db.collection("users").document(userdata.username)
    userref.set({"password":userdata.password})

```
```html
<!--signup.html-->
{% extends "base.html" %}
{% import "bootstrap/wtf.html" as wtf %}
{% block title %}
  {{ super() }}
  Signup
{% endblock %}

{% block content %}
  <div class="container">
    <h2>Registra una cuenta</h2>
    {{ wtf.quick_form(signupform) }}
  </div>
{% endblock %}
<!--/signup.html-->
```
### [32 - Agregar tareas](https://platzi.com/clases/1540-flask/18469-agregar-tareas/)
- creacion en cascada
```py
# project/app/services/firestore.py
def put_todo(userid,description):
    todoscollection = db.collection("users").document(userid).collection("todos")
    todoscollection.add({"description":description})
    
# project/app/forms.py    
class TodoForm(FlaskForm):
    description = StringField("Descripcion",validators=[DataRequired()])
    submit = SubmitField("Crear")

# project/main.py
from app.services.firestore import get_users, get_todos, put_todo

# from folder-app import __init__.py.def create_app
from app import create_app
from app.forms import LoginForm, TodoForm

@app.route("/hello",methods=["GET","POST"])
@login_required
def hello():
    user_ip = session.get("user_ip")
    username = current_user.id
    todoform = TodoForm()

    context = {
        "user_ip":user_ip,
        "todos":get_todos(userid=username),
        "username":username,
        "todoform":todoform
    }

    if todoform.validate_on_submit():
        put_todo(userid=username,description=todoform.description.data)
        flash("tu tarea se creó con éxito")
        return redirect(url_for("hello"))
  
    # spread operator
    return render_template("hello.html",**context)
```
```html
<!-- hello.html -->
 <div class="container">
    <h2>Crear una nueva tarea</h2>
    {{ wtf.quick_form(todoform) }}
  </div>
```

### [33 - Eliminar tareas](https://platzi.com/clases/1540-flask/18470-eliminar-tareas/)
```py
# project/app/services/firestore.py
def delete_todo(userid, todoid):
    todoref = db.document("users/{}/todos/{}".format(userid, todoid))
    todoref.delete()
    #todoref = db.collection("users").document(userid).collection("todos").document(todoid)

# project/app/forms.py
class DeleteTodoForm(FlaskForm):
    submit = SubmitField("Borrar")

# main.py
@app.route("/hello",methods=["GET","POST"])
@login_required
def hello():
    user_ip = session.get("user_ip")
    username = current_user.id
    todoform = TodoForm()
    deleteform = DeleteTodoForm()

    context = {
        "user_ip":user_ip,
        "todos":get_todos(userid=username),
        "username":username,
        "todoform":todoform,
        "deleteform":deleteform
    }

    if todoform.validate_on_submit():
        put_todo(userid=username,description=todoform.description.data)
        flash("tu tarea se creó con éxito")
        return redirect(url_for("hello"))
  
    # spread operator
    return render_template("hello.html",**context)

@app.route("/todos/delete/<todoid>",methods=["POST"])
def delete(todoid):
    userid = current_user.id
    delete_todo(userid=userid,todoid=todoid)
    return redirect(url_for("hello"))
```
```html
  <div class="container">
    <h2>Crear una nueva tarea</h2>
    {{ wtf.quick_form(todoform) }}
    <hr/>
    <ul class="list-group">
      {% for todo in todos %}
        {{ macros.render_todo(todo, deleteform) }}
      {% endfor %}
    </ul>    
  </div>
{% endblock %}
<!--/hello.html -->
<!-- macro.html -->
{% import "bootstrap/wtf.html" as wtf %}

{% macro render_todo(todo,deletform) %}
  <li class="list-group-item d-flex justify-content-between align-items-center">
    descripcion: {{ todo.to_dict().description }}
    <span class="badge badge-primary badge-pill">
      {{ todo.to_dict().done }}
    </span>
    {{ wtf.quick_form(deletform, action=url_for("delete",todoid=todo.id)) }}
  </li>
{% endmacro %}
<!-- /macro.html -->
```
### [34 - Editar tareas](https://platzi.com/clases/1540-flask/18471-editar-tareas/)
```py
# project/app/forms.py
class UpdateTodoForm(FlaskForm):
    submit = SubmitField("Actualizar")
# project/app/services/firestore.py
def delete_todo(userid, todoid):
    todoref = _get_todo_ref(userid,todoid)
    todoref.delete()
    #todoref = db.collection("users").document(userid).collection("todos").document(todoid)

def update_todo(userid,todoid,done):
    tododone = not bool(done)
    todoref = _get_todo_ref(userid,todoid)
    todoref.update({"done": tododone})
    
def _get_todo_ref(userid,todoid):
    return db.document("users/{}/todos/{}".format(userid,todoid))

# project/main.py
from app.services.firestore import get_users, get_todos, put_todo, delete_todo, update_todo
...
from app.forms import TodoForm, DeleteTodoForm, UpdateTodoForm
...
@app.route("/todos/update/<todoid>/<int:done>",methods=["POST"])
def update(todoid, done):
    userid = current_user.id
    update_todo(userid=userid,todoid=todoid,done=done)
    return redirect(url_for("hello"))
```
```html
<!-- macro.html -->
    {{ wtf.quick_form(updateform, action=url_for("update",todoid=todo.id, done=todo.to_dict().done)) }}
  </li>
<!-- hello.html -->
{% for todo in todos %}
        {{ macros.render_todo(todo, deleteform, updateform) }}
      {% endfor %}
    </ul>    
```
### [35 - Deploy a producción con App Engine](https://platzi.com/clases/1540-flask/18472-deploy-a-produccion-con-app-engine/)
- **App engine** es una plataforma de google cloud que va a vivir en nuestro proyecto al igual que firestore.
- AE soporta varios lenguajes: Java, Go, etc
- Creamos archivo app.yaml
- Creamos un proyecto de produccion en Google Cloud
  - **flask-platzi-prod**
- en local: `gcloud config set project flask-platzi-prod`
```yaml
# app.yaml
runtime: python37
```
- `gcloud app deploy app.yaml`
- Hay que quitar los ficheros Pipfile
- >ERROR: (gcloud.app.deploy) Error Response: [7] Access Not Configured. Cloud Build has not been used in project flask-platzi-prod before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/cloudbuild.googleapis.com/overview?project=flask-platzi-prod then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry.
- Hay que habilitar el servicio de la api (que es de pago)
  - https://console.developers.google.com/apis/library/cloudbuild.googleapis.com?project=flask-platzi-prod&pli=1
- Creamos la bd para este nuevo proyecto:
  - https://console.cloud.google.com/datastore/stats?project=flask-platzi-prod
- url: [https://flask-platzi-prod.appspot.com][https://flask-platzi-prod.appspot.com)
- Ejecutamos: `gcloud app browse`
- **comandos**
  - `gcloud app logs tail -s default`
  - si queremos cambiar de version
    - https://console.cloud.google.com/appengine/versions?project=flask-platzi-prod&serviceId=default&versionssize=50
    - `gcloud app deploy app.yaml --version`
### [36 - Conclusiones](https://platzi.com/clases/1540-flask/18473-conclusiones/)

## Errores a tener en cuenta
- A veces caduca la sesion en google cloud y hay que ejecutar el comando 
- La ruta: `/Users/ioedu/.local/share/virtualenvs` puede perder los permisos y lanzar operacion no permitida
- `flask run` puede dar error de module main not found y eso se debe a que en el virtualenv hay que setear FLASK_APP dentro de la ruta donde está main.py