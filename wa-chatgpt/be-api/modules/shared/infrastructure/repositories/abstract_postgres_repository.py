from abc import ABC
import psycopg2
from modules.shared.infrastructure.components.log import Log

class AbstractPostgresRepository(ABC):

    def __get_connection(self) -> object:
        return psycopg2.connect(
            dbname="db_vector",
            user="postgres",
            password="root",
            host="localhost",
            port="5432"
        )

    def _query(self, sql: str) -> list:
        conn = self.__get_connection()
        cursor = conn.cursor()
        cursor.execute(sql)
        results = cursor.fetchall()
        return results

    def _execute(self, sql: str) -> None:
        conn = None
        cursor = None
        try:
            conn = self.__get_connection()
            cursor = conn.cursor()
            cursor.execute(sql)
            conn.commit()
        except Exception as e:
            Log.log_error(e, "abstract_postgres_repository._execute")
        finally:
            cursor.close()
            conn.close()