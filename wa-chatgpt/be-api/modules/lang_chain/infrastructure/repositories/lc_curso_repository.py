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

    def ejemplo_multi_rol_con_generate(self) -> dict:
        dic_prompt = {
            "history": {
                "system_role": "Eres un historiador que conoce los detalles de todas las ciudades del mundo",
                "question": "¿Puedes decirme dónde se encuentra Cáceres?",
            },
            "rude_young_person": {
                "system_role": "Eres un joven rudo que no le gusta que le pregunten, solo quiere estar de fiesta",
                "question": "¿Puedes decirme dónde se encuentra Cáceres?",
            }
        }
        llm_result = self._get_chat_openai().generate([
          [
              SystemMessage(content=dic_prompt.get("history").get("system_role")),
              HumanMessage(content=dic_prompt.get("history").get("question"))
          ],
          [
              SystemMessage(content=dic_prompt.get("rude_young_person").get("system_role")),
              HumanMessage(content=dic_prompt.get("rude_young_person").get("question"))
          ],
        ])
        generated_texts = llm_result.generations
        return {
            "history": {
                "question": dic_prompt.get("history").get("question"),
                "response": generated_texts[0][0].text,
            },
            "rude_young_person": {
                "question": dic_prompt.get("rude_young_person").get("question"),
                "response": generated_texts[0][0].text,
            },
        }


    def donde_se_encuentra_lima_system_human_message(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Lima?"
        human_message = HumanMessage(content=str_content)

        system_rol = "Eres un historiador que conoce los detalles de todas las ciudades del mundo"
        system_message = SystemMessage(content=system_rol)

        ai_message = self._get_chat_openai().invoke([
            system_message,
            human_message
        ])
        return ai_message.content


    def donde_se_encuentra_caceres_only_human_message(self) -> str:
        str_content = "¿Puedes decirme dónde se encuentra Cáceres?"
        human_message = HumanMessage(content=str_content)
        ai_message = self._get_chat_openai().invoke([human_message])
        return ai_message.content
