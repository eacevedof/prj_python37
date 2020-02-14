## [Platzi - Curso de Flask ](https://platzi.com/clases/flask/)

- Actualizar pip:
  - `python3 -m pip install --upgrade pip` 
  - `pip install pipenv`

### [5 - Hello World Flask](https://platzi.com/clases/1540-flask/18443-hello-world-flask/)
- Crear el entorno `pipenv shell`
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/739x216/24bdf118ecfccddb4a5e75764ea3a69f/image.png)
  - Salir del entorno `exit`
- Instalar flask (dentro del entorno): `pip install flask`
- Ver dependecias: `pip freeze`
  - ![](https://trello-attachments.s3.amazonaws.com/5e47170d1f80943559dbb587/425x143/96d45f6e6c0b2ec7d179b9dbe983882b/image.png)
  ```py
  Click==7.0
  Flask==1.1.1
  itsdangerous==1.1.0
  Jinja2==2.11.1
  MarkupSafe==1.1.1
  Werkzeug==1.0.0
  ```
- Crear requirements.txt
  - En lugar de tener que escribir pip install xxx
  - Ponemos todas las dependencias en este fichero y así solo tenemos que ejecutar un solo comando
  - `pip install -r requirements.txt` r: recursive
