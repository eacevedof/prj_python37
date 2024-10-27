from abc import ABC
import psycopg2

from config.database import PostgresDb
from modules.shared.infrastructure.components.log import Log

class AbstractPostgresRepository(ABC):

    __connection = None
    __cursor = None

    def __get_connection(self) -> object:
        return psycopg2.connect(
            dbname = PostgresDb.dbname,
            user = PostgresDb.user,
            password = PostgresDb.password,
            host = PostgresDb.host,
            port = PostgresDb.port
        )

    def _query(self, sql: str) -> list:
        self.__connection = self.__get_connection()
        self.__cursor = self.__connection.cursor()
        self.__cursor.execute(sql)
        results = self.__cursor.fetchall()
        self.__close_all()
        return results

    def _execute(self, sql: str) -> None:
        try:
            self.__connection = self.__get_connection()
            self.__cursor = self.__connection.cursor()
            self.__cursor.execute(sql)
            self.__connection.commit()
            self.__close_all()
        except Exception as e:
            Log.log_error(e, "abstract_postgres_repository._execute")
            self.__close_all()
            raise e

    def __close_all(self) -> None:
        if self.__cursor:
            self.__cursor.close()

        if self.__connection:
            self.__connection.close()