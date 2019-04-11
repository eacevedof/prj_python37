

"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name theframework.components.db.ComponentMysql
 * @file component_mysql.php v2.0.0
 * @date 02-12-2018 13:20 SPAIN
 * @observations
 pip install mysql-connector-python
 """
# https://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html
import datetime
import mysql.connector
from pprint import pprint

class ComponentMysql:
    cnx = None

    def __init__(self):
        self.cnx = mysql.connector.connect(user="root",password="",host="127.0.0.1",database="db_bi")

    def test(self):
        oCursor = self.cnx.cursor(dictionary=True)
        tplQuery = ("SELECT * FROM operation LIMIT 3")
        oCursor.execute(tplQuery)
        names = oCursor.fetchall()
        # names = [i[0] for i in oCursor.fetchall()]
        pprint(names)
        # rowh = oCursor.fetchmany(size=2)
        # pprint(rowh)
        # rows = oCursor.fetchall()
        # pprint(rows)
        oCursor.close()
        self.cnx.close()
        
    
    def p(self,mxVal,sTitle=""):
        print("\n")
        if sTitle:
            print(sTitle+"\n:")
        pprint(mxVal)
  
# ComponentMysql
if __name__ == "__main__":
    o = ComponentMysql()
    o.test()