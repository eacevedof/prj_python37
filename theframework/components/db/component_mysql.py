"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name theframework.components.db.ComponentMysql
 * @file component_mysql.php v2.0.0
 * @date 02-12-2018 13:20 SPAIN
 * @observations
 pip install mysql-connector-python
 """
import sys; sys.path.append("..")
# https://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html
import datetime
import mysql.connector
from pprint import pprint
from dsources.dsrc import dsrc

class ComponentMysql:
    
    # data source, son los datos de: theframework\dsources\dsources.json
    __dicdsrc = {}
    __objcnx = None
    __is_connected = False

    __errors = {}
    __is_error = False

    def __init__(self,idsrc=None):
        if idsrc:
            self.__dicdsrc = dsrc.get_context(idsrc)
        self.__connect()

    def __connect(self):
        if self.__dicdsrc:
            self.__objcnx = mysql.connector.connect(
                    user = self.__dicdsrc["user"],
                    password = self.__dicdsrc["password"],
                    host = self.__dicdsrc["host"],
                    database = self.__dicdsrc["database"],
                )
            self.__is_connected =  self.__objcnx.is_connected()        


    def query(self,strsql):
        """
        sql reader
        """
        if not isinstance(strsql,str):
            self.__add_error("query.strsql.instance","strsql not a string")
            return []
        
        if not strsql:
            self.__add_error("query.strsql.empty","strsql is empty")
            return []
        
        if not self.__is_connected:
            self.__connect()
            if not self.__is_connected:
                self.__add_error("query.try-connect","unable to connect")
                return []
        
        tplquery = strsql
        # lista de diccionarios
        lstrows = []        
        try:
            objcursor = self.__objcnx.cursor(dictionary=True)        
            objcursor.execute(tplquery)
            lstrows = objcursor.fetchall()
            #pprint(lstrows)
            
        except e:
            lstrows = []
            self.__add_error("query.exception",str(e))
            
        finally:
            return lstrows
    # def query
    
    def execute(self,strsql):
        pass

    def get_rows(self):
        strsql = "SELECT * FROM operation LIMIT 3"
        lstrows = self.query(strsql)
        return lstrows
    
    def is_connected(self):
        return self.__is_connected
  
    def __add_error(self,key,strmsg):
        self.__is_error = True
        self.__errors[key] = strmsg
        
    def is_error(self):
        return self.__is_error
    
    def get_errors(self):
        return self.__errors
        
    def show_errors(self):
        print(__name__," errors:")
        pprint(self.__errors)
  
#class ComponentMysq

if __name__ == "__main__":
    o = ComponentMysql()
    dicr = o.get_rows()
    pprint(dicr)