# prj_python37  
## Pruebas de concepto de python siguiendo diversos tutoriales.

### [Parte 9 - POO y UML]()
- [Youtube - Introducción a POO con ejemplos en Python - Programación Orientada a Objetos by Programación desde cero](https://youtu.be/iliKayKaGtc)
- ![](https://trello-attachments.s3.amazonaws.com/5c8401cf1c6b4163c9b2419b/1072x476/30b2ee7c97ab29ec9e9a38d7816901c5/image.png)
- **Dependencia**: (A necesita un... B)
  - Indica una relación en la que las dos clases son independientes, tienen existencia por si mismas pero en algún momento la claseA necesita un obj de la claseB.
  - La clase Venta necesita un objeto un objeto de la clase FormaPago.
- **Agregación**: (A tiene un... B)
  - Las clases son independientes entre si. Una de las clases está formada por objetos de la otra.
  - La clase Triangulo está formada por objetos de la clase Linea  *no me queda claro, como puede existir un triángunlo sin lineas*
  - La relación siempre es unidireccional. Un objeto triangulo tiene n objetos linea
- **Asociación**: (A usa un... B)
  - Es bidireccional
  - Un autor escribe un libro, un libro tiene un autor
  - Un alumno tiene varios profesores, un profesor tiene varios alumnos
- **Composición**: (se compone de...)
  - Un objeto no puede existir sin el objeto contenedor.
  - Una habitación no puede exisitr sin una casa

### [Parte 8 - Corey Schafer - 9 - Import modules](https://github.com/eacevedof/prj_python37/tree/master/corey_schafer/py_tutorials#youtube-playlist---python-tutorials)
### [Parte 7 - pycmd](https://github.com/eacevedof/prj_python37/tree/master/pycmd)
### [Parte 6 - Selenium - Python](https://github.com/eacevedof/prj_python37/tree/master/selenium)
- [Playlist](https://www.youtube.com/watch?v=N-rdcdWmYck&list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP&index=2)
### [Parte 5 - Django Rest Framework PIPENV (Fazt y otros)](https://github.com/eacevedof/prj_python37/tree/master/apirest)
- [pipenv - FAZT](https://www.youtube.com/watch?v=-XIsKyNWILo)
- [Despliegue en Pythonanywhere](https://github.com/eacevedof/prj_python37/blob/master/apirest/PYTHONANYWHERE.md)
- [Despliegue en Heroku](https://github.com/eacevedof/prj_python37/blob/master/apirest/HEROKU.md)

### [Parte 4 - App Platzi Django (platzigram)](https://github.com/eacevedof/prj_python37/tree/master/platzigram)
- [Curso Platzi](https://platzi.com/clases/django/)
- Instalación de django por consola

### [Parte 3 - Instalación Django con Pycharm (keepcoding)](https://github.com/eacevedof/prj_python37/tree/master/keepcoding)
- [Youtube playlist](https://www.youtube.com/playlist?list=PLQpe1zyko1phY_8XwZOQSdoyKf9nv7kMl)
- Intento montar un proyecto Frikr. Los (videos) tutoriales no son secuenciales con lo cual es material incompleto. De aqui se puede recuperar como utilizar PyCharm y una explicación
sobre el fichero de configuración (**settings.py**) 

### [Parte 2 - Test de combinatoria (mis_tests)](https://github.com/eacevedof/prj_python37/blob/master/mis_tests/combine/combine.py)
- He creado una clase que resuelve la fórmula matmática:
```js
(n k) = C(n,k) = n! /((n-k)!k!)
```

### [Parte 1 - App Platzi Ventas (platziventas)](https://github.com/eacevedof/prj_python37/tree/master/platziventas)
- [Curso Platzi](https://platzi.com/clases/python/)
- Prueba de concepto con Python 3.7.2
- Instalación sin Django
- Applicación CRUD tipo consola con instalador
