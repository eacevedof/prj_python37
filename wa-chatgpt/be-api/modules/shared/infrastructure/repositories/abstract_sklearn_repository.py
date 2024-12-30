from abc import ABC
from typing import Dict, List

import psycopg2

from langchain_community.vectorstores import SKLearnVectorStore
from langchain_core.embeddings import Embeddings

from config.database import PostgresDb
from modules.shared.infrastructure.components.log import Log


class AbstractSklearnRepository(ABC):

    __persist_path = "./database/sk_learn/ejemplos_embedding_db"
    __connection = None
    __cursor = None

    def _create_db(self, ls_documents: List, fn_embedding:Embeddings) -> SKLearnVectorStore:
        vector_store = SKLearnVectorStore.from_documents(
            documents = ls_documents,
            embedding = fn_embedding,
            persist_path = self.__persist_path,
            serializer = "parquet"
        )
        vector_store.persist()
        return vector_store

    def __get_connection(self) -> object:
        return psycopg2.connect(
            dbname=PostgresDb.dbname,
            user=PostgresDb.user,
            password=PostgresDb.password,
            host=PostgresDb.host,
            port=PostgresDb.port
        )

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
