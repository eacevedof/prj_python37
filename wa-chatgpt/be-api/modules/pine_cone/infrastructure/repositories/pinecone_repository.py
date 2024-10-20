from dataclasses import dataclass
from typing import List, final

from config.config import PINECONE_INDEX_NAME
from langchain_core.documents import Document

from modules.pine_cone.infrastructure.repositories.abstract_pinecone_repository import AbstractPineconeRepository

@final
@dataclass(frozen=True)
class PineconeRepository(AbstractPineconeRepository):

    @staticmethod
    def get_instance() -> "PineconeRepository":
        return PineconeRepository()


    def upsert_pdf_index(self, documents: List[Document]) -> None:
        pinecone = self._get_pinecone_by_index(PINECONE_INDEX_NAME)
        pinecone.upsert(documents)




