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
