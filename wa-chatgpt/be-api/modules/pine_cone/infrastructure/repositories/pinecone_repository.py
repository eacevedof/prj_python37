from dataclasses import dataclass
from typing import List, final, Dict

from config.config import PINECONE_INDEX_NAME

from modules.pine_cone.infrastructure.repositories.abstract_pinecone_repository import (
    AbstractPineconeRepository,
    METADATA_TEXT_KEY
)

@final
@dataclass(frozen=True)
class PineconeRepository(AbstractPineconeRepository):

    @staticmethod
    def get_instance() -> "PineconeRepository":
        return PineconeRepository()


    def search_by_vector(self, vector: List[float], top_k: int) -> List[str]:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        response = pdf_index.query(
            vector=vector,
            top_k=top_k,
            include_metadata=True
        )
        return [
            match["metadata"][METADATA_TEXT_KEY]
            for match in response["matches"]
            if match.get("metadata") and METADATA_TEXT_KEY in match["metadata"]
        ]


    def upsert_pdf_index(self, vectors: List[Dict]) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.upsert(vectors)


    def delete_by_filter(self, filter: Dict) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.delete(filter)


    def delete_all(self) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.delete(delete_all=True)


    def get_vectors_from_pdf_index(self) -> None:
        pdf_index = self._get_index_obj_by_name(PINECONE_INDEX_NAME)
        pdf_index.query(
            namespace="example-namespace",
            vector=[0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3],
            filter={
                "genre": {"$eq": "documentary"}
            },
            top_k=3,
            include_values=True
        )


