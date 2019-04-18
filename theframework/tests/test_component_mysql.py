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
        # assert isinstance(mxvar,dict)
        self.assertEqual(o.is_connected(),True)       
        #self.fail("TODO: Write test")

    def tes_is_connected_error(self):
        o = ComponentMysql("mysql-x")
        # assert isinstance(mxvar,dict)
        self.assertEqual(o.is_connected(),False)
        # self.fail("connection error")
        
    def tes_get_rows(self):
        o = ComponentMysql("mysql-1")
        mxvar = o.get_rows()
        #o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,list)
        
    def test_update(self):
        o = ComponentMysql("mysql-1")
        mxvar = o.update()
        o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,int)  
        
    def test_insert(self):
        o = ComponentMysql("mysql-1")
        mxvar = o.insert()
        o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,int)
        
    def test_lastquery(self):
        o = ComponentMysql("mysql-1")
        o.update()
        o.insert()
        o.delete()
        mxvar = o.get_last_query()
        pprint(mxvar)
        assert "read" in mxvar
        assert mxvar["write"]
        assert isinstance(mxvar,dict)
#class TestComponentMysql

if __name__ == "__main__":
    unittest.main()
    
