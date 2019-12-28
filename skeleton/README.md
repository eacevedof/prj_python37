## skeleton
- Base para desarrollo de cualquier proyecto

## Ejecución:
- Posicionarse dentro de skeleton
- Ejecutar: pipenv shell
  ```s
  ioedu@HPZBOOK15U MINGW64 /e/projects/prj_python37/skeleton (master)
  $ pipenv shell
  Creating a virtualenv for this project▒
  Pipfile: E:\projects\prj_python37\skeleton\Pipfile
  Using e:\programas\python\python37-32\python.exe (3.7.2) to create virtualenv▒
  [   =] Creating virtual environment...Already using interpreter e:\programas\python\python37-32\python.exe
  Using base prefix 'e:\\programas\\python\\python37-32'
  New python executable in C:\<ruta-mi-usuario>\.virtualenvs\skeleton-k4jCkxmh\Scripts\python.exe
  Installing setuptools, pip, wheel...
  done.

  Successfully created virtual environment!
  Virtualenv location: C:\<ruta-mi-usuario>\.virtualenvs\skeleton-k4jCkxmh
  Creating a Pipfile for this project▒
  Launching subshell in virtual environment▒
  ```
- Creará este fichero:
  ```py
  [[source]]
  name = "pypi"
  url = "https://pypi.org/simple"
  verify_ssl = true

  [dev-packages]

  [packages]

  [requires]
  python_version = "3.7"
  ```



### Configurar setup.py
```py
from setuptools import setup, find_packages
setup(name='skeleton', version='1.0', packages=find_packages())
```


### Bibliografía
- [Stackoverflow](https://stackoverflow.com/questions/6323860/sibling-package-imports/50193944#50193944)

### Error
- ModuleNotFoundError: No module named 'moda0'