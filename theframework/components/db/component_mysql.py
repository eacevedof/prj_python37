"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name theframework.components.db.ComponentMysql
 * @file component_mysql.py 1.0.0
 * @date 18-04-2018 17:50 SPAIN
 * @observations
 pip install mysql-connector-python
 """
import sys; sys.path.append("..")
from pprint import pprint
# https://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html
# import datetime
import mysql.connector
from dsources.dsrc import dsrc

class ComponentMysql:
    """
    theframework.components.db.ComponentMysql 1.0.0
    Conecta a una bd usando dsrc (datasources)
    """
    # data source, son los datos de: theframework\dsources\dsources.json
    __dicdsrc = {}
    __objcnx = None
    __is_connected = False
    __iaffected = 0

    __errors = {}
    __is_error = False
    __sqlread = ""
    __sqlwrite = ""

    def __init__(self,idsrc=None):
        if idsrc:
            self.__dicdsrc = dsrc.get_context(idsrc)
        self.__connect()

    def __connect(self):
        if self.__dicdsrc:
            try:
                self.__objcnx = mysql.connector.connect(
                                user = self.__dicdsrc["user"],
                                password = self.__dicdsrc["password"],
                                host = self.__dicdsrc["host"],
                                database = self.__dicdsrc["database"],
                            )
                self.__is_connected =  self.__objcnx.is_connected()
            except e:
                self.__is_connected = False
                self.__add_error("__connect.exception",str(e))

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
        
        strquery = strsql
        self.__sqlread = strquery
        # lista de diccionarios
        lstrows = []        
        try:
            objcursor = self.__objcnx.cursor(dictionary=True)        
            objcursor.execute(strquery)
            lstrows = objcursor.fetchall()
            #pprint(lstrows)
            
        except e:
            lstrows = []
            self.__add_error("query.exception.sql",strquery)
            self.__add_error("query.exception",str(e))
            
        finally:
            self.__iaffected = len(lstrows)
            return lstrows
    # def query
    
    def execute(self,strsql):
        """
        sql writer
        """
        if not isinstance(strsql,str):
            self.__add_error("execute.strsql.instance","strsql not a string")
            return []
        
        if not strsql:
            self.__add_error("execute.strsql.empty","strsql is empty")
            return []
        
        if not self.__is_connected:
            self.__connect()
            if not self.__is_connected:
                self.__add_error("execute.try-connect","unable to connect")
                return []
        
        strquery = strsql
        self.__sqlwrite = strquery
        
        iresult = 0
        try:
            objcursor = self.__objcnx.cursor()        
            objcursor.execute(strquery)
            self.__objcnx.commit()
            iresult = objcursor.rowcount
            
        except e:
            iresult = -1
            self.__add_error("exceute.exception.sql",strquery)
            self.__add_error("execute.exception",str(e))
            
        finally:
            self.__iaffected = iresult            
            return iresult    
    
    def __add_error(self,key,strmsg):
        self.__is_error = True
        self.__errors[key] = strmsg
        
    def get_last_query(self):
        return {"read":self.__sqlread,"write":self.__sqlwrite}
    
    def get_affected(self):
        return self.__iaffected
    
    def is_connected(self):
        return self.__is_connected
        
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
    pprint(o.is_connected())