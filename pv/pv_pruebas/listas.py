import sys
import copy
import random

def prid(obj,title=""):
    text = str(id(obj))
    if title:
        text = title+": "+text
    # text += "\n"
    print(text)

def listar():
    countries = ["Mexico", "Venezuela", "Colombia", "Argentina"]
    prid(countries,"countries")
    ages = [12, 18, 24, 34, 50]
    prid(ages,"ages")
    receta = ["Ensalada",2,"lechugas",5,"jitomates"]
    prid(receta,"receta")
    print("modificando countries[0]")
    countries[0] = "Ecuador"
    print(countries)
    global_countries = countries  # esto crea un alias, otro puntero a la misma direccion del original
    prid(global_countries,"global_countries")
    print(global_countries)
    countries[0] = "Guatemala"
    print(countries)
    print(global_countries)
    global_countries = copy.copy(countries)
    countries[0] = "Peru"
    print(countries)
    print(global_countries)

def operadores():
    a = list(range(0,100,2))
    # print(a)
    b = list(range(0,10))
    # print(b)
    # print(a + b)
    # print(a * 2)
    # print(a * b) # no se puede
    fruits = []
    fruits.append("apple")
    print(len(fruits))
    rnd = []
    for i in range(10):
        rnd.append(random.randint(0,15))
    print(rnd)
    print(sorted(rnd))
    print(dir(rnd))
    
if __name__ == '__main__':
    # listar()
    operadores()