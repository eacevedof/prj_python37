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