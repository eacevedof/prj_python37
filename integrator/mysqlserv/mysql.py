import mysql.connector
import json

class Mysql:
    pathconfig = ""
    conx = None

    def __init__(self):
        self.pathconfig = "./config/mysql.json"
        print(self.pathconfig)

    def _get_json(self):
        data = {}
        with open(self.pathconfig) as f:
            data = json.load(f)
        return data

    def _get_cursor(self):
        dbconfig = self._get_json()
        # ** transforma un diccionario en kwargs
        self.conx = mysql.connector.connect(**dbconfig)
        objcursor = self.conx.cursor(dictionary=True)
        return objcursor

    def execute(self, sql, tplval,w=0):
        try:
            # print(sql)
            # print(tplval)
            objcursor = self._get_cursor()
            r = objcursor.execute(sql,tplval)
            if(w==0):
                r = objcursor.fetchall()
                print(r)
            return r
        except mysql.connector.Error as error:
            print("Failed to get recor from mysql table: {}".format(error))
            return -1
        finally:
            if(self.conx.is_connected()):
                objcursor.close()
                #print("mysql connection is closed")
