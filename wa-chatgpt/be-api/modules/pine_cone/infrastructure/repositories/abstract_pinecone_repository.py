from abc import ABC

from config.config import PINE_CONE_API_KEY
from pinecone import Pinecone

class AbstractPineconeRepository(ABC):

    def _get_pinecone(self) -> Pinecone:
        return Pinecone(api_key=PINE_CONE_API_KEY)
