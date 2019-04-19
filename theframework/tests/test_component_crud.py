"""
@file: test_component_crud 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from components.db.component_crud import ComponentCrud as Crud	

class TestComponentCrud(unittest.TestCase):	

    def tes_is_instance(self):
        o = Crud()
        assert isinstance(o,Crud)
        # self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")
        
    def test_orderby(self):
        o = Crud()
        o.add_orderby("v","asc")
        mxvar = o.test()
        pprint(mxvar)
        assert("ORDER BY" in mxvar)

#class TestComponentCrud

if __name__ == "__main__":
    unittest.main()
    
