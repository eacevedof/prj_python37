"""
@file: test_component_mysql 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from components.component_log import ComponentLog as Log	

class TestComponentLog(unittest.TestCase):	

    def test_is_instance(self):
        o = Log()
        assert isinstance(o,Log)
        # self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")

    def test_save(self):
        o = Log()
        o.save("texto de prueba")
        o.save("texto de prueba2 con titulo","Linea 2")

#class TestComponentLog

if __name__ == "__main__":
    unittest.main()
    
