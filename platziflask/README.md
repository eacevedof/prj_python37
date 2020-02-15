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
### [18 - ]()
- 
```py
```
```html
```
### [19 - ]()
- 
```py
```
```html
```
### [20 - ]()
- 
```py
```
```html
```
### [21 - ]()
- 
### [22 - ]()
- 
### [23 - ]()
- 
### [24 - ]()
- 
### [25 - ]()
- 
### [26 - ]()
- 
### [27 - ]()
- 
### [28 - ]()
- 
### [29 - ]()
- 
### [30 - ]()
- 
### [31 - ]()
- 
### [32 - ]()
- 
### [33 - ]()
- 
### [34 - ]()
- 
### [35 - ]()
- 
### [36 - ]()
- 
