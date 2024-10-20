from abc import ABC
from ast import Index

from config.config import PINECONE_API_KEY, PINECONE_SERVER
from pinecone import Pinecone

class AbstractPineconeRepository(ABC):

    def _get_pinecone(self) -> Pinecone:
        return Pinecone(
            api_key=PINECONE_API_KEY,
            host=PINECONE_SERVER
        )

    def _get_index_obj_by_name(self, db_index_name: str) -> Index:
        return self._get_pinecone().Index(db_index_name)