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
        
#class TestComponentLog

if __name__ == "__main__":
    unittest.main()
    
