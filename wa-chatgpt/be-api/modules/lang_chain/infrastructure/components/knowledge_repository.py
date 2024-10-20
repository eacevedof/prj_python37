from typing import final

from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS

from modules.lang_chain.domain.enums.langchain_embedding_enum import LangchainEmbeddingEnum


@final
class KnowledgeRepository:
    @staticmethod
    def get_instance() -> "KnowledgeRepository":
        return KnowledgeRepository()

    def __get_chunks_from_text(self, text: str) -> list[str]:
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=800,
            chunk_overlap=100,
            length_function=len
        )
        return splitter.split_text(text)

    # https://youtu.be/iDrpdkIHMq8?t=549
    def __get_embedding_by_minilm(self):
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MINILM_L12_V2
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings

    def __get_embedding_by_mpnet_base(self):
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings

    def get_knowledge_base_from_text(self, text: str) -> FAISS:
        chunks = self.__get_chunks_from_text(text)
        # embeddings = __get_embedding_by_minilm()
        embeddings = self.__get_embedding_by_mpnet_base()
        knowledge_base = FAISS.from_texts(chunks, embeddings)
        return knowledge_base






