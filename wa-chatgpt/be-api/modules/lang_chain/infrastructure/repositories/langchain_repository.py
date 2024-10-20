from dataclasses import dataclass
from typing import List, final

from langchain_core.documents import Document
from langchain.chains.question_answering import load_qa_chain

from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from modules.lang_chain.infrastructure.repositories.abstract_langchain_repository import AbstractLangchainRepository

from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.prompts import ChatPromptTemplate


@final
@dataclass(frozen=True)
class LangchainRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LangchainRepository":
        return LangchainRepository()

    def get_response_using_chain(self, langchain_documents: List[Document], question: str) -> str:
        prompt_tpl = ChatPromptTemplate.from_template(question+" {context}")
        oai_llm = self._get_chat_openai()
        chain = create_stuff_documents_chain(llm=oai_llm, prompt=prompt_tpl)
        respuesta = chain.invoke({"context": langchain_documents})
        return respuesta

    def get_response_using_chain_old(self, langchain_documents: List[Document], question: str) -> str:
        llm_obj = self._get_chat_openai()

        chain_obj = load_qa_chain(
            llm = llm_obj,
            chain_type=LangchainTypeEnum.STUFF.value
        )
        respuesta = chain_obj.run(input_documents=langchain_documents, question=question)

        return respuesta

