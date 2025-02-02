from abc import ABC
from typing import Dict

from mysql.connector import connect

from config.database import MysqlDefaultDb
from modules.shared.infrastructure.components.db.mysql_context_dto import MysqlContextDto
from modules.shared.infrastructure.components.log import Log


class AbstractMysqlRepository(ABC):

    __connection = None
    __cursor = None
    __context: Dict = None

    def set_context(self, context: MysqlContextDto|None = None) -> None:
        self.__context = {
            "user": MysqlDefaultDb.user,
            "password": MysqlDefaultDb.password,
            "host": MysqlDefaultDb.host,
            "port": MysqlDefaultDb.port,
            "database": MysqlDefaultDb.dbname
        }
        if context:
            self.__context = {
                "user": context.user,
                "password": context.password,
                "host": context.host,
                "port": context.port,
                "database": context.dbname
            }

    def __get_connection(self) -> object:
        return connect(**self.__context)

    def _get_connection_string(self) -> str:
        return f"mysql+mysqlconnector://{MysqlDefaultDb.user}:{MysqlDefaultDb.password}@{MysqlDefaultDb.host}:{MysqlDefaultDb.port}/{MysqlDefaultDb.dbname}"

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
