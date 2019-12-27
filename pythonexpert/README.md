# [James Powell: So you want to be a Python expert? | PyData Seattle 2017](https://www.youtube.com/watch?v=cKPlPJyQrt4)

## [data-model](https://youtu.be/cKPlPJyQrt4?t=471)
- [Doc python sobre data model](https://docs.python.org/3/reference/datamodel.html)
- [data-model.py](https://github.com/eacevedof/prj_python37/blob/master/pythonexpert/datamodel/data-model.py)
```py
# suma de polinomios
def __add__(self,other):
    return Polynomial(*(x+y for x,y in zip(self.coeffs, other.coeffs)))
    
p1 = Polynomial(1,2,3)  
p2 = Polynomial(3,4,3)

# py -i data-model.py
p3 = p1 + p2
```
- [metaclasses](https://youtu.be/cKPlPJyQrt4?t=1334)
    - Se intenta que el código falle antes de entrar en ejecución si no exite el método foo
    ```py
    from library import Base

    assert hasattr(Base,"foo"), "you broke it you fool!"

    class Derived(Base):

        def bar(self):
            return self.foo
    ```
    - mostraria este error
    ```py
    Traceback (most recent call last):
    File "user.py", line 3, in <module>
    assert hasattr(Base,"foo"), "you broke it you fool!"
    AssertionError: you broke it you fool!
    ```
    - Otro caso, como nos aseguramos que Derived tenga el método bar?
    ```py
    # library.py
    class Base:
        def foo(self):
            return self.bar

    from library import Base
    assert hasattr(Base,"foo"), "you broke it you fool!"

    # user.py
    class Derived(Base):
        def bar(self):
            return "bar"
    ```
    - 3 opciones.
        - Metaclases
        - Try Catch, esta no ayuda mucho ya que si no se usa el método foo y despues en producción si entonces dará error en tiempo de ejecución.
        - 

- [self.bar()](https://youtu.be/cKPlPJyQrt4?t=1779)
    - El creador de la librearia `library.py` asume que el desarrollador que vaya a usarla va a crear el método `bar()`
    - No sirve el [`try catch`](https://youtu.be/cKPlPJyQrt4?t=1902)
    - Python como lenguaje en su totalidad es orientado a protocolo, quiere decir que, desde cualquier punto del progama se puede utilizar los, hooks, protocolos y valores seguros (safety values)
    - En python todo se ejecuta en **`runtime`**
    - En el siguiente ejemplo se intenta obligar a que exista el método bar en todas las clases hijas
    ```py
    def _():
        class Base:
            pass
    
    # dis: disasembler
    from dis import dis
    
    dis(_)

    >>> dis(_)
    2           0 LOAD_BUILD_CLASS
                2 LOAD_CONST               1 (<code object Base at 0x000001DA0CD0E540, file "<stdin>", line 2>)
                4 LOAD_CONST               2 ('Base')
                6 MAKE_FUNCTION            0
                8 LOAD_CONST               2 ('Base')
                10 CALL_FUNCTION            2
                12 STORE_FAST               0 (Base)
                14 LOAD_CONST               0 (None)
                16 RETURN_VALUE

    Disassembly of <code object Base at 0x000001DA0CD0E540, file "<stdin>", line 2>:
    2           0 LOAD_NAME                0 (__name__)
                2 STORE_NAME               1 (__module__)
                4 LOAD_CONST               0 ('_.<locals>.Base')
                6 STORE_NAME               2 (__qualname__)

    3           8 LOAD_CONST               1 (None)
                10 RETURN_VALUE
    ```
    - Usando el hook `__build_class__`
    - [def my_bc](https://youtu.be/cKPlPJyQrt4?t=2225)
    ```py
    py -i user.py
    my buildclass-> (<function Derived at 0x0000018604EDC1E0>, 'Derived', <class 'library.Base'>) {}
    ``` 
    - Comprueba si el método **bar()** existe en el hijo
    ```py
    old_bc = __build_class__

    def my_bc(fun,name,base=None,**kw):
        if base is Base:
            print("Check if bar method is defined")
        if base is not None:
            # porque le pasa base
            return old_bc(fun,name,base,**kw)
        
        return old_bc(fun, name, **kw)

    import builtins
    builtins.__build_class__ = my_bc

    λ py -i user.py
    Check if bar method is defined
    ```
    - Hay que entender que este patrón existe
    - No es la mejor opción para resolver el problema
    - `__build_class__` no es la opción que se suele usar
    - Hay otras dos opciones. 
        - Metaclass
        - __init_subclass__(cls,*a,**kw)

- [class Base(metaclass=BaseMeta):](https://youtu.be/cKPlPJyQrt4?t=2459)
    ```py
    # library.py
    class BaseMeta(type):
        def __new__(cls, name, bases, body):
            if not 'bar' in body:
                raise TypeError("Bad user class")

            print("BaseMeta.__new__",cls,name,bases,body)
            return super().__new__(cls,name,bases,body)

    class Base(metaclass=BaseMeta):
        def foo(self):
            return self.bar()

    λ py -i user.py BaseMeta.__new__ <class 'library.BaseMeta'> Base () {'__module__': 'library', '__qualname__': 'Base', 'foo': <function Base.foo at 0x000001D7715367B8>} BaseMeta.__new__ <class 'library.BaseMeta'> Derived (<class 'library.Base'>,) {'__module__': '__main__', '__qualname__': 'Derived', 'bar': <function Derived.bar at 0x000001D7715368C8>}    

    # con esta condicion:
    if not 'bar' in body:
        raise TypeError("Bad user class") 

    λ py -i user.py
    Traceback (most recent call last):
    File "user.py", line 2, in <module>
        from library import Base
    File "E:\xampp\htdocs\prj_python37\pythonexpert\metaclasses\library.py", line 10, in <module>
        class Base(metaclass=BaseMeta):
    File "E:\xampp\htdocs\prj_python37\pythonexpert\metaclasses\library.py", line 5, in __new__
        raise TypeError("Bad user class")
    TypeError: Bad user class

    # library.py
    class BaseMeta(type):
        def __new__(cls, name, bases, body):
            if name!="Base" and not 'bar' in body:
                raise TypeError("Bad user class")

            print("BaseMeta.__new__",cls,name,bases,body)
            return super().__new__(cls,name,bases,body)

    class Base(metaclass=BaseMeta):
        def foo(self):
            return self.bar()

        def __init_subclass__(self,*a,**kw):
            print("init_subclass",a,kw)
            return super().__init_subclass__(*a,**kw)    

    λ py -i user.py
    BaseMeta.__new__ <class 'library.BaseMeta'> Base () {'__module__': 'library', '__qualname__': 'Base', 'foo': <function Base.foo at 0x000001AC753D67B8>, '__init_subclass__': <function Base.__init_subclass__ at 0x000001AC753D6730>, '__classcell__': <cell at 0x000001AC75354CA8: empty>}
    BaseMeta.__new__ <class 'library.BaseMeta'> Derived (<class 'library.Base'>,) {'__module__': '__main__', '__qualname__': 'Derived', 'bar': <function Derived.bar at 0x000001AC753D68C8>}
    init_subclass () {}            
    ```
[decorators](https://youtu.be/cKPlPJyQrt4?t=2846)
```py
>>> from inspect import getsource
>>>
>>> getsource(add)
'def add(x,y):\n    return x + y\n'
```
## [Diferencia entre función "add1" y class "Adder"](https://youtu.be/cKPlPJyQrt4?t=4064)
```py
def add1(x,y):
  return x+y

class Adder():
  def __call__(self,x,y):
    return x+y

# con __call__ realmente se está creando una función
add2 = Adder()

type(add1) == type(add2) # function
```
- Si del ejemplo anterior sacamos una conclusión es que una Clase sin estado es una función
- Una función es la forma bonita o limpia de representar una clase sin estado
- Una función generadora no es más que una clase que implementa **__iter__** y **__next__**
- La clase generadora no es tan facil de leer y de escribir por lo tanto tiene su [función equivalente](https://youtu.be/cKPlPJyQrt4?t=4665). *Uso de Yield*
```py
# función generadora de numeros uno a uno
def compute():
  for i in range(10):
    sleep(.5)
    yield 1

for val in compute():
  print(val)
```
- Supongamos que tenemos una clase con unos metodos que deben de respetar un orden de llamada
```py
obj = Api()
obj.go_first()
obj.go_second()
obj.go_end()
```
- Como podríamos asegurar que siempre se ejecute en ese orden?
- Una función generadora no solo devuelve un dato por unidad de tiempo sino que permite inyectar o interactuar antes, durante y despues de la devolución
- Entra en juego el concepto de [**corutines**](https://youtu.be/cKPlPJyQrt4?t=4894), es un trozo de código que se ejecuta de inicio a fin
- Si lo vemos desde una perspectiva de "user code" y "library code" las co-rutinas es la interacción de ambos códigos de manera alterna.
- Generators no son más que co-rutinas que permiten el solapamiento de codigo. *La verdad que esto no lo he entendido muy bien*
```py
# la alternativa sería
def api():
  first()
  yield
  second()
  yield
  last()
```
- Un **contextmanager** es una clase que implementa los siguientes métodos:
  - __init__, __call__, __enter__, __exit__
  - Dentro de __enter__ y __exit__ hace un next()
  - Existe un decorator **@contextmanager** que convierte un generator en un contextmanager `from contextLib import contextmanager`
- [Explica las 3 estructuras juntas](https://youtu.be/cKPlPJyQrt4?t=5851)
  - [contextmanagers](https://youtu.be/cKPlPJyQrt4?t=5900)
    - Es código que mapea acciones de configuración y ejecución interna, es decir, las acciones internas solo ocurren si las de configuración se han ejecutado.
  - [generators](https://youtu.be/cKPlPJyQrt4?t=5914)
    - Es básicamente una sintaxis formal que nos permite hacer cosas como forzar una ejecución ordenada y el solapamiento de código.
    - En el caso del contextmanager obliga el solapamiento ya que tiene unas acciones de configuración que se deben ejecutar en conjunto con las acciones finales. El setup debe ejecutarse antes de las acciones finales.
  - [decorators](https://youtu.be/cKPlPJyQrt4?t=5942)
    - Necesitamos un adaptador del generator al modelo de datos, hemos llevado el funcionamiento del generator para que se acople con los dunder methods
  - **Nota**
    - Debo probar y jugar con este último ejemplo porque de vista se ve complicado.


    
