from dataclasses import dataclass
from typing import List, final

from langchain_core.documents import Document
from langchain.chains.question_answering import load_qa_chain

from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from modules.lang_chain.infrastructure.repositories.abstract_langchain_repository import AbstractLangchainRepository


@final
@dataclass(frozen=True)
class LangchainRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LangchainRepository":
        return LangchainRepository()


    def get_response_using_chain(self, langchain_documents: List[Document], question: str) -> str:
        llm_obj = self._get_chat_openai()
        chain_obj = load_qa_chain(llm_obj, chain_type=LangchainTypeEnum.STUFF.value)
        respuesta = chain_obj.run(input_documents=langchain_documents, question=question)
        return respuesta

