## skeleton
- Base para desarrollo de cualquier proyecto

### Configurar setup.py
- si deseo hacerlo instalable
```py
# setup.py
from setuptools import setup, find_packages
setup(name='skeleton', version='1.0', packages=find_packages())
```

## Ejecución:
- Posicionarse dentro de skeleton
- ~~Ejecutar: pipenv shell~~~
  - Esto se usa por si quiero instalar cosas con pip install sin que afecte a otros entornos
  - No era este caso
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

### Bibliografía
- [Stackoverflow](https://stackoverflow.com/questions/6323860/sibling-package-imports/50193944#50193944)

### Error
- ModuleNotFoundError: No module named 'moda0'
  - Era pq no ponía el nombre del paquete ^^, deberia hacerlo así: `moda1.py: from packa.moda0 import Moda0`