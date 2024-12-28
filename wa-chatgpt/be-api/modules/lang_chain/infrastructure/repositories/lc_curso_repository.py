from dataclasses import dataclass
from typing import List, final

from langchain.schema import SystemMessage, HumanMessage
from langchain.prompts import (
    ChatPromptTemplate,
    PromptTemplate,
    SystemMessagePromptTemplate,
    AIMessagePromptTemplate,
    HumanMessagePromptTemplate,
)
from langchain.output_parsers import CommaSeparatedListOutputParser

from shared.infrastructure.components.log import Log
from modules.lang_chain.infrastructure.repositories.abstract_langchain_repository import AbstractLangchainRepository


@final
@dataclass(frozen=True)
class LcCursoRepository(AbstractLangchainRepository):

    @staticmethod
    def get_instance() -> "LcCursoRepository":
        return LcCursoRepository()


    def ejemplo_parsear_salida_de_caracteristicas_coches(self) -> str:
        str_sys_template = ""
        str_human_template = "{request}\n{format_instructions}"
        dic_prompt = {
            "car_specialist": {
                "system": {
                    "prompt_tpl": SystemMessagePromptTemplate.from_template(str_sys_template),
                },
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }
        chat_prompt = ChatPromptTemplate.from_messages([
            dic_prompt.get("car_specialist").get("human").get("prompt_tpl"),
        ])
        csv_output_parser = CommaSeparatedListOutputParser()
        chat_prompt_value = chat_prompt.format_prompt(
            request="dime 5 caracteresticas de los coches americanos",
            format_instructions = csv_output_parser.get_format_instructions()
        )
        final_request = chat_prompt_value.to_messages()
        ai_message = self._get_chat_openai().invoke(final_request)
        str_content = ai_message.content
        lst_content = csv_output_parser.parse(str_content)
        Log.log_debug(lst_content, "lst_content")
        return ai_message.content


    def ejemplo_parsear_salida(self) -> List[str]:
        csv_output_parser = CommaSeparatedListOutputParser()
        # las instrucciones nos indica que formato de entrada debe tener la respuesta
        format_instructions = csv_output_parser.get_format_instructions()
        respuesta = "coche, árbol, carretera"
        return csv_output_parser.parse(respuesta)


    def ejemplo_prompt_template_especialista_en_coches(self) -> str:
        str_sys_template = "Eres una IA especializada en coches de tipo {car_type} y generar artículos que leen en {read_time}"
        str_human_template = "Necesito un artículo para vehículos con motor {motor_type}"

        dic_prompt = {
            "car_specialist": {
                "system": {
                    "prompt_tpl": SystemMessagePromptTemplate.from_template(str_sys_template),
                },
                "human": {
                    "prompt_tpl": HumanMessagePromptTemplate.from_template(str_human_template),
                }
            },
        }
        chat_prompt = ChatPromptTemplate.from_messages([
            dic_prompt.get("car_specialist").get("system").get("prompt_tpl"),
            dic_prompt.get("car_specialist").get("human").get("prompt_tpl"),
        ])

        chat_prompt_value = chat_prompt.format_prompt(
            motor_type="hibrido enchufable",
            read_time="3 min",
            car_type="japoneses",
        )
        final_request = chat_prompt_value.to_messages()
        ai_message = self._get_chat_openai().invoke(final_request)
        return ai_message.content


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
                "response": generated_texts[1][0].text,
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
