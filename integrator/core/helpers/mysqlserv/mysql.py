import sys
import mysql.connector
# import json

class Mysql:
    dicconfig = {}
    conx = None

    def __init__(self, dicconfig):
        self.dicconfig = dicconfig
        # print(self.dicconfig); sys.exit()


    def _get_cursor(self):
        # ** transforma un diccionario en kwargs
        # print(**self.dicconfig); sys.exit()
        if self.conx is None or not self.conx.is_connected(): 
            self.conx = mysql.connector.connect(**self.dicconfig)
        
        objcursor = self.conx.cursor(dictionary=True)
        # print(objcursor); sys.exit()
        return objcursor

    def query(self, sql):
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            objcursor.execute(sql)
            r = objcursor.fetchall()
            return r

        except mysql.connector.Error as error:
            print("1 Failed query to get record from mysql table: {}".format(error))
            return -1
        #finally:
        #    if(self.conx.is_connected()):
        #        objcursor.close()
                #print("mysql connection is closed")

    def insert(self, dicqb):
        #print(dicqb)#;sys.exit()
        sql = dicqb["query"]
        tplvals = dicqb["tuple"]
        self.insert_tpl(sql, tplvals)

    def insert_tpl(self, sql, tplval):
        # print(sql);print(tplval);sys.exit()
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            r = objcursor.execute(sql, tplval)
            return r
        except mysql.connector.Error as error:
            print("2 Failed insert_tpl to get record from mysql table: {}".format(error))
            return -1
       

    def execute(self, sql):
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            r = objcursor.execute(sql)
            return r
        except mysql.connector.Error as error:
            print("3 Failed execute to get record from mysql table: {}".format(error))
            return -1
        # finally:
            # if(self.conx.is_connected()):
                # objcursor.close()
                #print("mysql connection is closed")

    def execute_bulk(self, arsql):
        if len(self.dicconfig) == 0:
            return -1

        arresult = []
        try:
            objcursor = self._get_cursor()
            for sql in arsql:
                r = objcursor.execute(sql)
                arresult.append(r)
            return arresult
        except mysql.connector.Error as error:
            print("4 Failed in execute_bulk. Error {}".format(error))
            arresult.append(-1)
            return arresult
