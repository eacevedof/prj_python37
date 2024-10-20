from typing import final
import numpy as np
from torch import Tensor
from sentence_transformers import SentenceTransformer
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.vectorstores import Pinecone
from langchain_core.documents import Document

from config.config import PINECONE_INDEX_NAME
from modules.lang_chain.domain.enums.langchain_embedding_enum import LangchainEmbeddingEnum


@final
class KnowledgeRepository:

    @staticmethod
    def get_instance() -> "KnowledgeRepository":
        return KnowledgeRepository()

    def get_embeddings_faiss(self, large_text: str) -> FAISS:
        text_chunks = self.__get_chunks_from_text(large_text)
        # embeddings = __get_embedding_by_minilm()
        embeddings_obj = self.__get_embeddings_obj_by_mpnet_base_v2()

        fais_obj = FAISS.from_texts(text_chunks, embeddings_obj)

        return fais_obj

    def get_prompt_as_vectors(self, prompt: str) ->  list[Tensor] | np.ndarray | Tensor:
        transformer = SentenceTransformer(
            model_name_or_path=LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2.value
        )
        return transformer.encode(prompt)

    def __get_chunks_from_text(self, text: str) -> list[str]:
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=800,
            chunk_overlap=100,
            length_function=len
        )
        return splitter.split_text(text)

    def __get_embeddings_obj_by_mpnet_base_v2(self) -> HuggingFaceEmbeddings:
        embeddings = HuggingFaceEmbeddings(
            model_name=LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2.value
        )
        return embeddings


    # https://youtu.be/iDrpdkIHMq8?t=549
    def __get_embedding_by_minilm(self) -> HuggingFaceEmbeddings:
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MINILM_L12_V2.value
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings


    def get_documents_by_user_question(self, user_question: str) -> list[Document]:
        embeddings = self.__get_embeddings_obj_by_mpnet_base_v2()
        vector_store = Pinecone.from_existing_index(PINECONE_INDEX_NAME, embeddings)
        return vector_store.similarity_search(
            query=user_question,
            top_k=3
        )








