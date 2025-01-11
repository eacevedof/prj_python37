from abc import ABC
from typing import Dict

from mysql.connector import connect

from config.database import MysqlDb
from modules.shared.infrastructure.components.log import Log


class AbstractMysqlRepository(ABC):

    __connection = None
    __cursor = None

    def __get_connection(self) -> object:
        config = {
            "user": MysqlDb.user,
            "password": MysqlDb.password,
            "host": MysqlDb.host,
            "port": MysqlDb.port,
            "database": MysqlDb.dbname
        }
        return connect(**config)

    def _get_connection_string(self) -> str:
        return f"mysql+mysqlconnector://{MysqlDb.user}:{MysqlDb.password}@{MysqlDb.host}:{MysqlDb.port}/{MysqlDb.dbname}"

    def _query(self, sql: str) -> list[Dict[str, any]]:
        self.__connection = self.__get_connection()
        self.__cursor = self.__connection.cursor()
        self.__cursor.execute(sql)
        columns = [desc[0] for desc in self.__cursor.description]
        results = [
            {columns[i]: value for i, value in enumerate(row)}
            for row in self.__cursor.fetchall()
        ]
        self.__close_all()
        return results

    def _command(self, sql: str) -> None:
        try:
            self.__connection = self.__get_connection()
            self.__cursor = self.__connection.cursor()
            self.__cursor.execute(sql)
            self.__connection.commit()
            self.__close_all()
        except Exception as e:
            Log.log_exception(e, "abstract_postgres_repository._execute")
            self.__close_all()
            raise e

    def __close_all(self) -> None:
        if self.__cursor:
            self.__cursor.close()

        if self.__connection:
            self.__connection.close()

    def _get_escaped_sql_string(self, string: str) -> str:
        string = string.replace("\\", "\\\\")
        return string.replace("'", "\\'")
