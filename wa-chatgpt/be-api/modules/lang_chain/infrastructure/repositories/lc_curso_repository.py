from dataclasses import dataclass
from typing import List, final

from langchain_core.documents import Document
from langchain.chains.question_answering import load_qa_chain

from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from modules.lang_chain.infrastructure.repositories.abstract_langchain_repository import AbstractLangchainRepository

from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.prompts import ChatPromptTemplate

from langchain.schema import SystemMessage, HumanMessage

@final
@dataclass(frozen=True)
class LcCursoRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LcCursoRepository":
        return LcCursoRepository()

    def donde_se_encuentra_caceres_only_human_message(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Cáceres?"
        human_message = HumanMessage(content=str_content)
        ai_message = self._get_chat_openai().invoke([human_message])
        return ai_message.content
