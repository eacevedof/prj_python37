## skeleton
- Base para desarrollo de cualquier proyecto

### Configurar setup.py
- si deseo que este "proyecto" skeleton sea instalable debo configurar setup.py
- [Más info](https://github.com/eacevedof/prj_python37/blob/master/theframework/setup.py)
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
### Resultado de `py main.py`
```py
# main.py
print("main.py")

from packa.moda1 import Moda1
from packa.moda2 import Moda2

from packb.modb1 import func_b1,func_b3
from packc.modc1 import *

m1 = Moda1("x-1","y-2",k1="value-1")
m2 = Moda2("-","-",k1="value de moda 2")

m1.printself()

m2.printself()
m2.showmodb1()

func_b1()
func_b3()

print("CONST_A:",CONST_A,", CONST_B:",CONST_B,", CONST_C:",CONST_C)
print(CONST_DICTO,CONST_TUPLA)
```
```s
main.py
packc.init
moda1 imported
moda0 imported
moda2 imported
packb.init
modb1 imported
packc.init
modc1 imported
class Moda1.__init__ ('x-1', 'y-2') {'k1': 'value-1'}
class Moda0.__init__ ('x-1', 'y-2') {'k1': 'value-1'}
l? ('x-1', 'y-2') d? {'k1': 'value-1'}
class Moda2 ('-', '-') {'k1': 'value de moda 2'}
PRINT SELF:
 self.x: x-1 self.y: y-2 self.k1 value-1
PRINT SELF:
 self.x:  self.y:  self.k1 value de moda 2
executing foo(<packb.modb1.ModB1 object at 0x0000026D3437D400>, tradicional)
executing class_foo(<class 'packb.modb1.ModB1'>, metodo de clase)
executing static_foo(metodo estatico)
func_b1
func_b3
CONST_A: constante a , CONST_B: constante b , CONST_C: 1234
{'k1': 'v1', 'k2': 'v2'} (3, 4, 5, 8)
```


### Bibliografía
- [Stackoverflow](https://stackoverflow.com/questions/6323860/sibling-package-imports/50193944#50193944)

### Error
- ModuleNotFoundError: No module named 'moda0'
  - Era pq no ponía el nombre del paquete ^^, deberia hacerlo así: `moda1.py: from packa.moda0 import Moda0`