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

    def get_faiss_obj_from_text(self, large_text: str) -> FAISS:
        text_chunks = self.__get_chunks_from_text(large_text)
        # embeddings = __get_embedding_by_minilm()
        embeddings_obj = self.__get_embeddings_obj_by_mpnet_base_v2()
        fais_obj = FAISS.from_texts(text_chunks, embeddings_obj)
        return fais_obj


    def __get_chunks_from_text(self, text: str) -> list[str]:
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=800,
            chunk_overlap=100,
            length_function=len
        )
        return splitter.split_text(text)

    def __get_embeddings_obj_by_mpnet_base_v2(self) -> HuggingFaceEmbeddings:
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MPNET_BASE_V2
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings


    # https://youtu.be/iDrpdkIHMq8?t=549
    def __get_embedding_by_minilm(self) -> HuggingFaceEmbeddings:
        transformer_name = LangchainEmbeddingEnum.PARAPHRASE_MULTILINGUAL_MINILM_L12_V2
        embeddings = HuggingFaceEmbeddings(model_name=transformer_name)
        return embeddings







