from dataclasses import dataclass
from typing import List, final

from langchain_core.documents import Document
from langchain.chains.question_answering import load_qa_chain

from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from modules.pine_cone.infrastructure.repositories.abstract_pinecone_repository import AbstractPineconeRepository

from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.prompts import ChatPromptTemplate


@final
@dataclass(frozen=True)
class PineconeRepository(AbstractPineconeRepository):

    @staticmethod
    def get_instance() -> "PineconeRepository":
        return PineconeRepository()

    def get_response_using_chain(self, langchain_documents: List[Document], question: str) -> str:
        str_tpl = question+" {context}"
        prompt_tpl = ChatPromptTemplate.from_template(str_tpl)
        oai_llm = self._get_chat_openai()
        chain = create_stuff_documents_chain(llm=oai_llm, prompt=prompt_tpl)
        str_result = chain.invoke({"context": langchain_documents})
        return str_result


