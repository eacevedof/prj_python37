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

func_b1()
func_b3()

print("CONST_A:",CONST_A,", CONST_B:",CONST_B,", CONST_C:",CONST_C)
print(CONST_DICTO,CONST_TUPLA)
