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

    def get_response_using_chain(self, docs_context: List[Document], question: str) -> str:
        str_tpl = question+" {context}"
        # prompt_tpl = ChatPromptTemplate.from_template(str_tpl)
        prompt_tpl = ChatPromptTemplate.from_messages(
            [("system", question+":\n\n{context}")]
        )
        openai_llm = self._get_chat_openai()
        chain = create_stuff_documents_chain(llm=openai_llm, prompt=prompt_tpl)
        str_result = chain.invoke({"context": docs_context})
        return str_result

    def __get_response_using_chain_old(self, langchain_documents: List[Document], question: str) -> str:
        openai_llm = self._get_chat_openai()

        chain_obj = load_qa_chain(
            llm = openai_llm,
            chain_type=LangchainTypeEnum.STUFF.value
        )
        respuesta = chain_obj.run(input_documents=langchain_documents, question=question)
        return respuesta
