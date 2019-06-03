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
    - Python como lenguaje en su totalidad es orientado a protocolo, quiere decier que, desde cualquier punto del progama se puede utilizar los, hooks, protocolos y valores seguros (safety values)
    - En python todo se ejecuta en **`runtime`**
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
    - 



    
