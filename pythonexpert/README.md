# [James Powell: So you want to be a Python expert? | PyData Seattle 2017](https://www.youtube.com/watch?v=cKPlPJyQrt4)

## [data-model])https://youtu.be/cKPlPJyQrt4?t=471)
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
