import mysql.connector
import json

class Mysql:
    dicconfig = {}
    conx = None

    def __init__(self, dicconfig):
        self.dicconfig = dicconfig

    def _get_cursor(self):
        # ** transforma un diccionario en kwargs
        self.conx = mysql.connector.connect(**self.dbconfig)
        objcursor = self.conx.cursor(dictionary=True)
        return objcursor

    def query(self, sql)
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            objcursor.execute(sql,tplval)
            r = objcursor.fetchall()
            return r

        except mysql.connector.Error as error:
            print("1 Failed query to get record from mysql table: {}".format(error))
            return -1
        finally:
            if(self.conx.is_connected()):
                objcursor.close()
                #print("mysql connection is closed")

    def insert(self, dicqb):
        sql = dicqb["query"]
        tpl = dicqb["tpl"]
        self.insert_tpl(sql, tplval)


    def insert_tpl(self, sql, tplval):
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            r = objcursor.execute(sql, tplval)

            return r
        except mysql.connector.Error as error:
            print("2 Failed insert_tpl to get record from mysql table: {}".format(error))
            return -1
        finally:
            if(self.conx.is_connected()):
                objcursor.close()
                #print("mysql connection is closed")

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
        finally:
            if(self.conx.is_connected()):
                objcursor.close()
                #print("mysql connection is closed")
