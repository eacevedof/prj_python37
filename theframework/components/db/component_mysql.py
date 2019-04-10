import mysql.connector
from pprint import pprint

"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name theframework.components.db.ComponentMysql
 * @file component_mysql.php v2.0.0
 * @date 02-12-2018 13:20 SPAIN
 * @observations
 pip install mysql-connector-python
 """

class ComponentMysql:

    arConn = []
    isError = False
    arErrors = []  
    iAffected = 0
    
    def __init__(self,arConn=[]): 
        self.arConn = arConn
    
    def test(self):
        self.p([],"ComponentMysql")
    
    def p(self,mxVal,sTitle=""):
        print("\n")
        if sTitle:
            print(sTitle+"\n:")
        pprint(mxVal)
  
# ComponentMysql
if __name__ == "__main__":
    o = ComponentMysql()
    o.test()