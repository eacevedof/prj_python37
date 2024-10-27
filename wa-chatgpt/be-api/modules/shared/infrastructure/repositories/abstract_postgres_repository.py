from abc import ABC
import psycopg2

from config.database import PostgresDb
from modules.shared.infrastructure.components.log import Log

class AbstractPostgresRepository(ABC):

    def __get_connection(self) -> object:
        return psycopg2.connect(
            dbname = PostgresDb.dbname,
            user = PostgresDb.user,
            password = PostgresDb.password,
            host = PostgresDb.host,
            port = PostgresDb.port
        )

    def _query(self, sql: str) -> list:
        conn = self.__get_connection()
        cursor = conn.cursor()
        cursor.execute(sql)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return results

    def _execute(self, sql: str) -> None:
        conn = None
        cursor = None
        try:
            conn = self.__get_connection()
            cursor = conn.cursor()
            cursor.execute(sql)
            conn.commit()
            cursor.close()
            conn.close()
        except Exception as e:
            Log.log_error(e, "abstract_postgres_repository._execute")
            if cursor:
                cursor.close()
            if conn:
                conn.close()
            raise e