#python -m pip install mysql-connector-python
import mysql.connector
#from typing import Union, Optional, Dict, List
from typing import Dict, List


class ComponentMysql:

    def __init__(self, arconn = Dict):
        self.__arerrors = []
        self.__ifoundrows = 0
        self.__iaffectedrows = 0
        self.__ilastid = -1
        self.__arconn = arconn
        self.__connection = None

    def __get_connection(self):
        if not self.__connection:
            self.__connection = mysql.connector.connect(
                host=self.__arconn.get("server",""),
                user=self.__arconn.get("user",""),
                password=self.__arconn.get("password",""),
                database=self.__arconn.get("database",""),
                port=self.__arconn.get("port",3306),
                charset = "utf8"
            )
        return self.__connection

    def close(self) -> None:
        if self.__connection and self.__connection.is_connected():
            self.__connection.close()
        self.__connection = None

    def query(self, sql: str) -> List:
        try:
            conn = self.__get_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute(sql)
            result = cursor.fetchall()
            self.__ifoundrows = self.__get_found_rows(cursor)
            self.__iaffectedrows = cursor.rowcount
            return result
        except mysql.connector.Error as error:
            self.__arerrors.append(error)
        finally:
            cursor.close()

    @staticmethod
    def __get_found_rows(cursor) -> int:
        cursor.execute("SELECT FOUND_ROWS() n")
        result = cursor.fetchall()
        if result:
            return int(result[0].get("n",-1))
        return 0

    @staticmethod
    def __get_last_insert_id(cursor) -> int:
        cursor.execute("LAST_INSERT_ID() id")
        result = cursor.fetchall()
        if result:
            return int(result[0].get("id",-1))
        return -1

    def exec(self, sql: str):
        try:
            conn = self.__get_connection()
            cursor = conn.cursor()
            cursor.execute(sql)
            conn.commit()
            self.__iaffectedrows = cursor.rowcount
            if sql.find("INSERT INTO ("):
                self.__ilastid = self.__get_last_insert_id(cursor)

        except mysql.connector.Error as error:
            self.__arerrors.append(error)
        finally:
            cursor.close()

    def is_error(self) -> bool:
        return True if self.__arerrors else False

    def get_errors(self) -> List:
        return self.__arerrors

    def get_lastid(self)->int:
        return self.__ilastid
