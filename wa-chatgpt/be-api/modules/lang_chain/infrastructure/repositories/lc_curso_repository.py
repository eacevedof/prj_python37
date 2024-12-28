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
class LcCursoRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LcCursoRepository":
        return LcCursoRepository()

    def donde_se_encuentra_caceres(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Cáceres?"
        chatOpenAi = self._get_chat_openai()
        resultado = chatOpenAi.invoke(content=str_content)
        return str_content
