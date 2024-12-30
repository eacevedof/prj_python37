from typing import final, List

from langchain_core.embeddings import Embeddings
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import SKLearnVectorStore

from config.config import PINECONE_INDEX_NAME
from modules.lang_chain.domain.enums.langchain_embedding_enum import LangchainEmbeddingEnum
from modules.shared.infrastructure.repositories.abstract_sklearn_repository import AbstractSklearnRepository


@final
class EjemplosSklearnRepository(AbstractSklearnRepository):

    @staticmethod
    def get_instance() -> "EjemplosSklearnRepository":
        return EjemplosSklearnRepository()

    def create_db(self, ls_documents: List, fn_embedding:Embeddings) -> SKLearnVectorStore:
        return self._create_db(ls_documents, fn_embedding)











