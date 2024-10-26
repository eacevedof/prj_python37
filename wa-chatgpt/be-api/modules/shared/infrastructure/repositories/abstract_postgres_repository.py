from abc import ABC
import psycopg2


class AbstractPostgresRepository(ABC):

    def __get_connection(self) -> object:
        return psycopg2.connect(
            dbname="db_vector",
            user="postgress",
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
