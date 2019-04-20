# Probando el pip install pipenv
## [Fazt](https://youtu.be/-XIsKyNWILo)

- `pip install pipenv` instala el mÃ³dulo del entorno virutal
- `pipenv shell` carga el entorno
    - crea un nuevo entorno virtual
- `pipenv install django`
- `pipenv install djangorestframework`
    - se ha creado un archivo Pipfile.lock
- `$ pipenv --venv` nos dice la ruta donde se instala el entorno virtual `.virtualenvs\apirest-wO8eG7Mj`
- Si queremos instalar un módolo con el típico **pip install** lo hariamos con **pipenv install**
- `pipenv lock -r` muestra todo lo que está instalado en mi entorno virtual
- `pipenv install -r requirements.txt` instala lo que está definido en el fichero

```ssh 
$ pip freeze
Django==2.2
djangorestframework==3.9.2
pytz==2019.1
sqlparse==0.3.0
```

- `django-admin startproject learnlang .` Crea el proyecto 
- `django-admin startapp base_user` Crea la app base_user
- [creating-a-rest-apiwebservice by Fernando Rodrigues](http://fernandorodrigues.pro/creating-a-rest-apiwebservice-with-django-rest-framework-and-mysql-using-python-3/)
- `pip3 install mysqlclient` instala el driver
    - Da error (que sorpresa! ¬¬)
    - Intento [pip install mysqlclient-1.3.7-cp35-cp35m-win32.whl](https://www.pythoniza.me/instalando-mysqlclient-en-windows/)
        - error
    - [Drivers](https://www.lfd.uci.edu/~gohlke/pythonlibs/#mysqlclient)
    - Intento `pip3 install https://download.lfd.uci.edu/pythonlibs/u2hcgva4/mysqlclient-1.4.2-cp37-cp37m-win32.whl`
        - ok
- `pipenv install mysqlclient` 
    - Da error (lloro en silencio ~~!)

`