from lib2to3.pgen2.tokenize import double3prog
from typing import final, List
import numpy as np
from torch import Tensor
from sentence_transformers import SentenceTransformer
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS, Pinecone
from langchain_core.documents import Document

from config.config import PINECONE_INDEX_NAME
from modules.lang_chain.domain.enums.langchain_embedding_enum import LangchainEmbeddingEnum


@final
class EmbeddingsRepository:

    @staticmethod
    def get_instance() -> "EmbeddingsRepository":
        return EmbeddingsRepository()


    def get_vector_storage_from_pdf_index(self, hf_embeddings: HuggingFaceEmbeddings) -> Pinecone:
        return Pinecone.from_existing_index(
            index_name=PINECONE_INDEX_NAME,
            embedding=hf_embeddings
        )


    def get_chunks_from_text(self, large_text: str) -> list[str]:
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=800,
            chunk_overlap=100,
            length_function=len
        )
        return splitter.split_text(large_text)

    def get_chunks_as_documents(self, large_text: str) -> list[Document]:
        paragraphs = 800
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=paragraphs,
            chunk_overlap=100,
            length_function=len
        )
        chunks = splitter.split_text(large_text)
        documents = splitter.create_documents(chunks)
        return splitter.split_documents(documents)


    def get_embeddings_faiss(self, large_text: str) -> FAISS:
        text_chunks = self.get_chunks_from_text(large_text)
        # embeddings = __get_embedding_by_minilm()
        embeddings_obj = self.get_embeddings_obj_by_mpnet_base_v2()
        fais_obj = FAISS.from_texts(text_chunks, embeddings_obj)
        return fais_obj

    def get_prompt_as_vectors(self, prompt: str) ->  list[Tensor] | np.ndarray | Tensor:
        transformer = SentenceTransformer(
            model_name_or_path=LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2.value
        )
        return transformer.encode(prompt)


    def get_embeddings_obj_by_mpnet_base_v2(self) -> HuggingFaceEmbeddings:
        embeddings = HuggingFaceEmbeddings(
            model_name=LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2.value
        )
        return embeddings


    # https://youtu.be/iDrpdkIHMq8?t=549
    def get_embedding_by_minilm(self) -> HuggingFaceEmbeddings:
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MINILM_L12_V2.value
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings


    def get_documents_by_user_question(self, user_question: str) -> list[Document]:
        embeddings = self.get_embeddings_obj_by_mpnet_base_v2()
        vector_store = Pinecone.from_existing_index(PINECONE_INDEX_NAME, embeddings)

        number_of_paragraphs = 10
        return vector_store.similarity_search(
            query=user_question,
            k=number_of_paragraphs
        )

    def insert_chunks_in_pinecone(self, chunks: list[Document], embeddings) -> None:
        result = Pinecone.from_documents(chunks, embeddings, index_name = PINECONE_INDEX_NAME)









