from abc import ABC

from config.config import PINECONE_API_KEY, PINECONE_SERVER, PINECONE_INDEX_NAME
from pinecone import Pinecone

class AbstractPineconeRepository(ABC):

    def _get_pinecone(self) -> Pinecone:
        return Pinecone(
            api_key=PINECONE_API_KEY,
            host=PINECONE_SERVER
        )

    def _get_pinecone_by_index(self, db_index: str) -> Pinecone:
        return Pinecone(
            api_key=PINECONE_API_KEY,
            host=PINECONE_SERVER,
            index_api=db_index
       )