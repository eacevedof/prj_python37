import os
from abc import ABC
from typing import List
import pyarrow.parquet as pq

from langchain_openai import (
    OpenAIEmbeddings, ChatOpenAI
)
from langchain_community.vectorstores import SKLearnVectorStore

from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import LLMChainExtractor

from config.config import OPENAI_API_KEY
from modules.shared.infrastructure.components.log import Log


class AbstractSklearnRepository(ABC):

    __path_db_spain = "./database/sk_learn/ejemplos_embedding_db.parquet" ## db historia de espana
    __path_db_python_history = "./database/sk_learn/optimization_db.parquet" ## contenido sobre python

    def get_q_and_a_connection(self) -> SKLearnVectorStore:
        return SKLearnVectorStore(
            serializer = "parquet",
            embedding = self.__get_embeddings_openai(),
            persist_path = self.__path_db_spain,
        )

    def create_optimization_db_by_documents(self, ls_documents: List) -> SKLearnVectorStore:
        vector_store = SKLearnVectorStore.from_documents(
            serializer = "parquet",
            documents = ls_documents,
            embedding = self.__get_embeddings_openai(),
            persist_path = self.__path_db_python_history,
        )
        vector_store.persist()
        if not self.__is_valid_parquet_file(self.__path_db_python_history):
            raise Exception(f"db {self.__path_db_python_history} is not a parquet file")

        return vector_store

    def create_openai_db_by_documents(self, ls_documents: List) -> SKLearnVectorStore:
        vector_store = SKLearnVectorStore.from_documents(
            serializer = "parquet",
            documents = ls_documents,
            embedding = self.__get_embeddings_openai(),
            persist_path = self.__path_db_spain,
        )
        vector_store.persist()
        if not self.__is_valid_parquet_file(self.__path_db_spain):
            raise Exception(f"db {self.__path_db_spain} is not a parquet file")

        return vector_store

    def __is_valid_parquet_file(self, db_path:str) -> bool:
        try:
            pq.read_table(db_path)
            return True
        except Exception as e:
            Log.log_exception(e, "AbstractSklearnRepository.__is_valid_parquet_file")
            return False

    def get_optimization_db(self) -> SKLearnVectorStore:
        if not self.db_exists():
            raise Exception(f"db does not exist: {self.__path_db_python_history}")

        if not self.__is_valid_parquet_file(self.__path_db_python_history):
            raise Exception(f"db {self.__path_db_python_history} is not a parquet file")

        return SKLearnVectorStore(
            serializer = "parquet",
            persist_path = self.__path_db_python_history,
            embedding = self.__get_embeddings_openai(),
        )

    def get_openai_db(self) -> SKLearnVectorStore:
        if not self.db_exists():
            raise Exception(f"db does not exist: {self.__path_db_spain}")

        if not self.__is_valid_parquet_file():
            raise Exception(f"db {self.__path_db_spain} is not a parquet file")

        return SKLearnVectorStore(
            serializer = "parquet",
            persist_path = self.__path_db_spain,
            embedding = self.__get_embeddings_openai(),
        )

    def get_spain_db_connection(self) -> SKLearnVectorStore:
        return SKLearnVectorStore(
            serializer = "parquet",
            persist_path = self.__path_db_spain,
            embedding = self.__get_embeddings_openai(),
        )

    def __get_embeddings_openai(self) -> OpenAIEmbeddings:
        return OpenAIEmbeddings(
            openai_api_key=OPENAI_API_KEY
        )

    def get_compression_retriever(self) -> ContextualCompressionRetriever:
        return ContextualCompressionRetriever(
            base_retriever= self.get_optimization_db().as_retriever(),
            base_compressor = self.__get_llm_chain_extractor(),
        )

    def __get_llm_chain_extractor(self) -> LLMChainExtractor:
        chat_open_ai = ChatOpenAI(
            temperature=0, ## nivel de aleatoriedad 0: no hay aleatoriedad
            openai_api_key=OPENAI_API_KEY
        )
        return LLMChainExtractor.from_llm(chat_open_ai)

    def db_optimization_exists(self) -> bool:
        return os.path.exists(self.__path_db_python_history)

    def db_exists(self) -> bool:
        return os.path.exists(self.__path_db_spain)

    def qa_db_exists(self) -> bool:
        return os.path.exists(self.__path_db_spain)

