"""
@file: test_dsrc 1.0.0
sobre los test: https://realpython.com/python-testing/#unit-tests-vs-integration-tests
sobre el import: https://stackoverflow.com/questions/30669474/beyond-top-level-package-error-in-relative-import
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from dsources.dsrc import dsrc

class TestDsrc(unittest.TestCase):	

    def test_get_config(self):
        mx_var = dsrc.get_config()
        pprint(mx_var)
        assert isinstance(mx_var,dict)
        #self.assertEqual(x, y, "Msg");	       
        #self.fail("TODO: Write test")

    def test_get_context(self):
        mx_var = dsrc.get_context("mysql-1")
        pprint(mx_var)
        assert isinstance(mx_var,dict)
        
    def test_get_value(self):
        mx_var = dsrc.get_value("mysql-1","description")
        pprint(mx_var)
        assert isinstance(mx_var,str)

if __name__ == "__main__":
    unittest.main()
    
