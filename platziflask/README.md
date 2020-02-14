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
- 

### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 
### []()
- 



