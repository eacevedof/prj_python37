import os
from abc import ABC
from typing import Dict, List
import pyarrow.parquet as pq

from langchain_openai import (
    OpenAIEmbeddings
)
from langchain_community.vectorstores import SKLearnVectorStore

from config.config import OPENAI_API_KEY
from modules.shared.infrastructure.components.log import Log


class AbstractSklearnRepository(ABC):

    __persist_path = "./database/sk_learn/ejemplos_embedding_db.parquet"
    __connection = None
    __cursor = None

    def create_openai_db_by_documents(self, ls_documents: List) -> SKLearnVectorStore:
        vector_store = SKLearnVectorStore.from_documents(
            serializer = "parquet",
            documents = ls_documents,
            embedding = self.__get_embeddings_openai(),
            persist_path = self.__persist_path,
        )
        vector_store.persist()
        if not self.__is_valid_parquet_file():
            raise Exception(f"db {self.__persist_path} is not a parquet file")

        return vector_store

    def __is_valid_parquet_file(self) -> bool:
        try:
            pq.read_table(self.__persist_path)
            return True
        except Exception as e:
            Log.log_exception(e, "AbstractSklearnRepository.__is_valid_parquet_file")
            return False

    def get_openai_db(self) -> SKLearnVectorStore:
        if not self.db_exists():
            raise Exception(f"db does not exist: {self.__persist_path}")

        if not self.__is_valid_parquet_file():
            raise Exception(f"db {self.__persist_path} is not a parquet file")

        return SKLearnVectorStore(
            serializer = "parquet",
            persist_path = self.__persist_path,
            embedding = self.__get_embeddings_openai(),
        )


    def __get_embeddings_openai(self) -> OpenAIEmbeddings:
        return OpenAIEmbeddings(
            openai_api_key=OPENAI_API_KEY
        )

    def db_exists(self) -> bool:
        return os.path.exists(self.__persist_path)


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
