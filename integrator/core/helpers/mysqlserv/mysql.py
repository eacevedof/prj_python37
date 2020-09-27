import sys
import mysql.connector
from mysql.connector import errorcode

class Mysql:

    dicconfig = {}
    conx = None

    def __init__(self, dicconfig):
        self.dicconfig = dicconfig
        # print(self.dicconfig); sys.exit()

    def _get_cursor(self):
        # https://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html
        # ** transforma un diccionario en kwargs
        # print(self.dicconfig); sys.exit()
        try:
            if self.conx is None or not self.conx.is_connected(): 
                # print("\n\n refreshing conx in get_cursor \n\n");print(self.dicconfig);
                self.conx = mysql.connector.connect(**self.dicconfig)
        
            objcursor = self.conx.cursor(dictionary=True)
            #print(objcursor); sys.exit()
            return objcursor
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print(f"Database does not exist {self.dicconfig.database}")
            else:
                print(err)

    # get from db
    def execute(self, sql):
        # https://dev.mysql.com/doc/connector-python/en/connector-python-example-cursor-select.html
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            r = objcursor.execute(sql)
            return r
        except mysql.connector.Error as error:
            print("3 Failed execute to get record from mysql table: {}".format(error))
            return -1
        # finally:
            # self.close()

    def query(self, sql):
        if len(self.dicconfig) == 0:
            return -1
        try:
            # print(self.dicconfig); sys.exit()
            objcursor = self._get_cursor()
            objcursor.execute(sql)
            r = objcursor.fetchall()
            return r

        except mysql.connector.Error as error:
            print("\n - 1 Failed query to get record from mysql table: {}".format(error))
            return -1
        #finally:
        #    if(self.conx.is_connected()):
        #        objcursor.close()
                #print("mysql connection is closed")


    def insert_tpl(self, sql, tplval):
        # https://dev.mysql.com/doc/connector-python/en/connector-python-example-cursor-transaction.html
        #print(self.dicconfig);print("\n\nmysql.insert_tpl:\n\n");print(tplval);sys.exit();
        if len(self.dicconfig) == 0:
            return -1
        try:
            objcursor = self._get_cursor()
            objcursor.execute(sql, tplval)
            print("\n- insert-sql:\n"); print(sql);
            print("- tplval:\n"); print(tplval);
            #sys.exit()
            print(f"insert_topl ok. Lastrowid: {objcursor.lastrowid}")
            # self.conx.commit()
            return objcursor.lastrowid

        except mysql.connector.Error as error:
            print("\n- 2 Failed insert_tpl: \n{}".format(error))
            return -1

    def insert(self, dicqb):
        # print("mysql.insert:");print(self.dicconfig);print(dicqb);print("\n\n");sys.exit();
        sql = dicqb["query"]
        tplvals = dicqb["tuple"]
        return self.insert_tpl(sql, tplvals)


    def execute_bulk(self, arsql):
        if len(self.dicconfig) == 0:
            return -1

        try:
            objcursor = self._get_cursor()
            for sql in arsql:
                objcursor.execute(sql)
                #arresult.append(r)
            return 1
        except mysql.connector.Error as error:
            print("4 Failed in execute_bulk. Error {}".format(error))
            return -1

    def commit(self):
        if(self.conx.is_connected()):
            self.conx.commit()
        return self

    def close(self):
        if(self.conx.is_connected()):
            objcursor = self._get_cursor()
            objcursor.close()
        return self