"""
@file: test_component_mysql 1.0.0
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from dsources.dsrc import dsrc
from components.db.component_mysql import ComponentMysql	

class TestComponentMysql(unittest.TestCase):	
    __o = ComponentMysql("mysql-1")

    def get_rows(self):
        strsql = "SELECT * FROM operation LIMIT 3"
        lstrows = self.__o.query(strsql)
        return lstrows
    
    def insert(self):
        strsql = "INSERT INTO v(i,s,f) VALUES (1,'some string',1.2)"
        ir = self.__o.execute(strsql)
        return ir
    
    def update(self):
        strsql = "UPDATE v SET i=88,s='updated str', f=9.89 WHERE id>3"
        ir = self.__o.execute(strsql)
        return ir
    
    def delete(self):
        strsql = "DELETE FROM v WHERE id>15"
        ir = self.__o.execute(strsql)
        return ir
    
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
        mxvar = self.get_rows()
        #o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,list)
        
    def test_update(self):
        mxvar = self.update()
        self.__o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,int)  
        
    def test_insert(self):
        mxvar = self.insert()
        self.__o.show_errors()
        pprint(mxvar)
        assert isinstance(mxvar,int)
        
    def tes_lastquery(self):
        self.update()
        self.insert()
        self.delete()
        mxvar = self.__o.get_last_query()
        pprint(mxvar)
        assert "read" in mxvar
        assert "write" in mxvar
        assert isinstance(mxvar,dict)
#class TestComponentMysql

if __name__ == "__main__":
    unittest.main()
    
