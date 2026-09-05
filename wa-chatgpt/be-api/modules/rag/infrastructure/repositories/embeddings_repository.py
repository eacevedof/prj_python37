from functools import lru_cache
from typing import Dict, List, final
from uuid import uuid4

from sentence_transformers import SentenceTransformer

from modules.pine_cone.infrastructure.repositories.abstract_pinecone_repository import METADATA_TEXT_KEY
from modules.rag.domain.enums.embedding_model_enum import EmbeddingModelEnum
from modules.rag.infrastructure.components.text_splitter import split_text

CHUNK_SIZE = 800
CHUNK_OVERLAP = 100


# El modelo pesa 1.2 GB: se carga una vez por proceso, no en cada peticion.
@lru_cache(maxsize=2)
def _get_transformer(model_name: str) -> SentenceTransformer:
    return SentenceTransformer(model_name_or_path=model_name)


@final
class EmbeddingsRepository:

    _MODEL_NAME = EmbeddingModelEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2.value

    @staticmethod
    def get_instance() -> "EmbeddingsRepository":
        return EmbeddingsRepository()


    def get_chunks_from_text(self, large_text: str) -> List[str]:
        return split_text(
            text=large_text,
            chunk_size=CHUNK_SIZE,
            chunk_overlap=CHUNK_OVERLAP
        )


    def embed_texts(self, texts: List[str]) -> List[List[float]]:
        transformer = _get_transformer(self._MODEL_NAME)
        return transformer.encode(texts).tolist()


    def embed_query(self, text: str) -> List[float]:
        return self.embed_texts([text])[0]


    def get_chunks_as_pinecone_vectors(self, chunks: List[str]) -> List[Dict]:
        vectors = self.embed_texts(chunks)
        return [
            {
                "id": str(uuid4()),
                "values": vector,
                "metadata": {METADATA_TEXT_KEY: chunk}
            }
            for chunk, vector in zip(chunks, vectors)
        ]
