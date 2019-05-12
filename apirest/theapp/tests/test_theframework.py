from django.test import TestCase
from theframework.components import *

o = ComponentLog()
o.save("texto de 11111")
o.save("texto de prueba2 con titulo","Linea 2")