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

