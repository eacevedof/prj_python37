# pycmd

> La intención es crear una app de terminal instalable de modo que automatice tareas

## Historial
- 2019-08-26: `pycmd regex matchfile`  
- 

## Notas
- Creo árbol de carpetas similar a **Flutter :)**
```js
pycmd/
  lib/
    src/
      services/         -> vacio de mom
      helpers/          -> vacio de mom
      commands/         -> módulo con todos los comandos
      main.py           -> frontcontroller
    setup.py            -> pip install --editable .
```
```js
1 - Si la app no está instalada:

- Tiene que existir la sentencia 
if __name__ == "__main__":
   shell()

se ejecutaría así:
py <archivo.py> <comando> <opcion>

ejemplo
py pv.py clients

Muestra todas las opciones

$ py pv.py clients create

Permite la interaccion

2 - Si la app está instalada:
    - Para esto se necesita el fichero setup.py configurado
    - Que se haya ejecutado: pip install --editable .

pv clients create
```
- Me estaba dando este error: **ModuleNotFoundError**
    - el problema es que como src es un módulo el import tenía que ser `src.commands` y no solo `commads`
```js
// Instalo
ioedu@HPZBOOK15U MINGW64 /e/<project>/pycmd/lib (master)
$ pip install --editable .
Obtaining file:///E:<project>/pycmd/lib
Requirement already satisfied: Click in e:\programas\python\python37-32\lib\site-packages (from pycmd==0.1.0) (7.0)
Installing collected packages: pycmd
  Found existing installation: pycmd 0.1.0
    Uninstalling pycmd-0.1.0:
      Successfully uninstalled pycmd-0.1.0
  Running setup.py develop for pycmd
Successfully installed pycmd

//comprobar si está instalado y donde:
ioedu@HPZBOOK15U MINGW64 /e/<project>/pycmd/lib (master)
$ where pycmd
\<ruta-python>\Scripts\pycmd.exe
``` 
