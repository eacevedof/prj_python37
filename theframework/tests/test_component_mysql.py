"""
@file: test_component_mysql 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from dsources.dsrc import dsrc
from components.db.component_mysql import ComponentMysql	

class TestComponentMysql(unittest.TestCase):	

    def tes_is_connected(self):
        o = ComponentMysql("mysql-1")
        # assert isinstance(mx_var,dict)
        self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")

    def tes_is_connected_error(self):
        o = ComponentMysql("mysql-x")
        # assert isinstance(mx_var,dict)
        self.assertEqual(o.is_connected(),False)
        # self.fail("connection error")
        
    def test_get_rows(self):
        o = ComponentMysql("mysql-1")
        mx_var = o.get_rows()
        #o.show_errors()
        pprint(mx_var)
        assert isinstance(mx_var,list)

#class TestComponentMysql

if __name__ == "__main__":
    unittest.main()
    
