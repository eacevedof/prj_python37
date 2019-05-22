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

