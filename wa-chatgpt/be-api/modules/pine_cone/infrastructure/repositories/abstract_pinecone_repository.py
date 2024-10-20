from abc import ABC

from config.config import PINECONE_API_KEY, PINECONE_SERVER
from pinecone import Pinecone

class AbstractPineconeRepository(ABC):

    def _get_pinecone(self) -> Pinecone:
        return Pinecone(
            api_key=PINECONE_API_KEY,
            host=PINECONE_SERVER
        )
