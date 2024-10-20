from dataclasses import dataclass
from typing import List, final, Dict

from config.config import PINECONE_INDEX_NAME

from modules.pine_cone.infrastructure.repositories.abstract_pinecone_repository import AbstractPineconeRepository

@final
@dataclass(frozen=True)
class PineconeRepository(AbstractPineconeRepository):

    @staticmethod
    def get_instance() -> "PineconeRepository":
        return PineconeRepository()


    def upsert_pdf_index(self, vectors: List[Dict]) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.upsert(vectors)


    def delete_by_filter(self, filter: Dict) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.delete(filter)

    def delete_all(self) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.delete(delete_all=True)


