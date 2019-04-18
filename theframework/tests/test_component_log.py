"""
@file: test_component_mysql 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from components.component_log import ComponentLog as Log	

class TestComponentLog(unittest.TestCase):	
    __o = Log()

    def tes_is_connected(self):
        o = Log()
        assert isinstance(o,ComponentLog)
        # self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")


#class TestComponentLog

if __name__ == "__main__":
    unittest.main()
    
