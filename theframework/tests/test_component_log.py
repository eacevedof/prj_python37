"""
@file: test_component_mysql 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from components.component_log import ComponentLog as Log	

class TestComponentLog(unittest.TestCase):	

    def tes_is_instance(self):
        o = Log()
        assert isinstance(o,Log)
        # self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")

    def tes_save(self):
        o = Log()
        o.save("texto de 11111")
        o.save("texto de prueba2 con titulo","Linea 2")

    def test_type(self):
        o = Log()
        o1 = Log()
        o.save(o1,"object 1")
        o.save(12354,"entero")
        o.save(2.34,"flotante")
        o.save((2,4,5,8),"tupla")
        o.save(["a","b","c"],"list")
        o.save({"1":1,"2":"dos"},"dict")
        
#class TestComponentLog

if __name__ == "__main__":
    unittest.main()
    
