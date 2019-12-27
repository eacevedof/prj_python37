## [Youtube Playlist - Python Tutorials](https://www.youtube.com/playlist?list=PL-osiE80TeTt2d9bfVyTiXJA-UTHn6WwU)

### [Python Tutorial for Beginners 9: Import Modules and Exploring The Standard Library](https://youtu.be/jGu9vvEUk5k)
- Importación de módulos en python
	- Estructura
	```py
	cap_09/
		my_module.py
		intro.py
	```
- Formas de importar un módulo
- `import my_module`
	- Se importaría todo y habria que instanciar su contenido con `my_module.<funcion o variable>`
- `from my_module import <nombre-funcion|clase|variable>`
```py
# intro.py
print("intro.py")
# import my_module
from my_module import find_index, test

courses = ["History","Math", "Physics", "CompSci"]

search = "Math"
# index = my_module.find_index(courses,search)
index = find_index(courses,search)
print(f"Indes of {search} is: {index}, test var: {test}")

$ py intro.py
intro.py
my_module.py
Indes of Math is: 1, test var: Test String
```
- **Como indicarle a Python donde está el módulo?** [6:27](https://youtu.be/CqvZ3vGoGs0?list=PL-osiE80TeTt2d9bfVyTiXJA-UTHn6WwU&t=380)
	- Cuando se importa python comprueba multiples lugares
	- Hay una lista que se llama **sys.path**
	```py
	# test_sys.py
	print("test_sys.py")

	import sys
	print(sys.path)

	# resultado:
	[
		'E:\\projects\\prj_python37\\corey_schafer\\py_tutorials\\cap_09',
		'E:\\programas\\python\\anaconda3\\python37.zip',
		'E:\\programas\\python\\anaconda3\\DLLs',
		'E:\\programas\\python\\anaconda3\\lib',
		'E:\\programas\\python\\anaconda3',
		'C:\\Users\\<my-user>\\AppData\\Roaming\\Python\\Python37\\site-packages',
		'E:\\programas\\python\\anaconda3\\lib\\site-packages',
		'E:\\programas\\python\\anaconda3\\lib\\site-packages\\win32',
		'E:\\programas\\python\\anaconda3\\lib\\site-packages\\win32\\lib',
		'E:\\programas\\python\\anaconda3\\lib\\site-packages\\Pythonwin'
	]
	```
	- Que pasaria si muevo mi módulo a una ruta que no está en **sys.path**
	- Tendriamos que agregar a la lista anterior la ruta donde se encuentra
	```py
	# agregando ruta a includepath :)
	import sys
	sys.append("<ruta-absoluta-a-la-carpeta-del-módulo>")
	```
	- Si bien funciona ahora la importación, no es la mejor solución
	- Que pasaría si deseamos hacer estas rutas compatibles entre windows y mac?
	- Tendriamos que definir una variable de entorno: **PYTHONPATH** [10:20](https://youtu.be/CqvZ3vGoGs0?list=PL-osiE80TeTt2d9bfVyTiXJA-UTHn6WwU)
	- *imprimir variables de entorno: win:SET, unix: env*
	```s
	# file: /Users/<my-user>/.bash_profile
	# mac
	export PYTHONPATH="/Users/<my-user>/desktop/my-modules"
	```
	- ![](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/910x446/9c1e79c745f968bef240c20278126df0/image.png)
	- Despues de guardar reiniciamos el terminal.
	- En windows:
		- ![](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/840x485/c2c8df61f64c113ba5744adae75764bf/image.png)	
		- `setx PYTHONPATH "<ruta-absoluta-a-la-carpeta-del-módulo>" /M` *No lo he probado, /M usa la ruta de usuario*
		- [Más info en stackoverflow](https://stackoverflow.com/questions/9546324/adding-directory-to-path-environment-variable-in-windows)
- Comprobando rutas 
```py
# intro.py
print("intro.py")
import os
courses = ["History","Math", "Physics", "CompSci"]

print(os.getcwd()) # E:\projects\prj_python37\corey_schafer\py_tutorials\cap_09
print(os.__file__) # E:\programas\python\anaconda3\lib\os.py
```
- **pruebas**
```s
cap_09
│   __init__.py
│
├───pkgmain
│       intro.py
│       my_module.py
│       __init__.py
│
└───pkgtest
		generic.py
		__init__.py
```
- He intentado hacer el import entre hermanos, es decir importar generic en intro.py pero no existe esa visibilidad por defecto. Con el hack funciona pero hay una mejor solución que es usar [**setup.py**](https://stackoverflow.com/questions/6323860/sibling-package-imports)
```py
# intro.py
print("pkgmain/intro.py")
# import os

# courses = ["History","Math", "Physics", "CompSci"]

# print(os.getcwd()) # E:\projects\prj_python37\corey_schafer\py_tutorials\cap_09
# print(os.__file__) # E:\programas\python\anaconda3\lib\os.py

# from modtest.generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 10, in <module>
    from modtest.generic import argskwargs,syspath
ModuleNotFoundError: No module named 'modtest'
'''
# from generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 19, in <module>
    from generic import argskwargs,syspath
ModuleNotFoundError: No module named 'generic'
'''
# from pkgtest.generic import argskwargs,syspath 
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 28, in <module>
    from pkgtest.generic import argskwargs,syspath
ModuleNotFoundError: No module named 'pkgtest'
'''
# from ..pkgtest.generic import syspath
'''
$ py intro.py
pkgmain/intro.py
Traceback (most recent call last):
  File "intro.py", line 37, in <module>
    from ..pkgtest.generic import syspath
ValueError: attempted relative import beyond top-level package
'''

# Esto es un hack, la solución ortodoxa es trabajar con setup.py
# eso se describe aqui: https://stackoverflow.com/questions/6323860/sibling-package-imports
import sys, os
sys.path.insert(0, os.path.abspath('..'))

from pkgtest.generic import syspath
```
- En pantalla
```s
..._09/pkgmain (master)
$ py intro.py
pkgmain/intro.py
pkgtest.__init__.py
pkgtest.generic.py

```