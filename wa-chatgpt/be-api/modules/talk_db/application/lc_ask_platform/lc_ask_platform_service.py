from typing import final
from modules.shared.infrastructure.components.log import Log

from modules.talk_db.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.talk_db.application.lc_ask_question.lc_asked_question_dto import LcAskedQuestionDTO

from modules.talk_db.infrastructure.repositories.lc_curso_repository import LcCursoRepository

@final
class LcAskPlatformService:

    @staticmethod
    def get_instance() -> "LcAskPlatformService":
        return LcAskPlatformService()


    def invoke(self, lc_ask_question: LcAskQuestionDTO) -> LcAskedQuestionDTO:
        str_response = ":)"
        # str_response = LcCursoRepository.get_instance().donde_se_encuentra_caceres_only_human_message()
        # str_response = LcCursoRepository.get_instance().donde_se_encuentra_lima_system_human_message()
        # dic_response = LcCursoRepository.get_instance().ejemplo_multi_rol_con_generate()
        # str_response = \
        #    f"History: {dic_response.get("history").get("question")} {dic_response.get("history").get("response")}\n"\
        #    f"Rude young person: {dic_response.get("rude_young_person").get("question")} {dic_response.get("rude_young_person").get('response')}";
        # str_response = LcCursoRepository.get_instance().ejemplo_prompt_template_especialista_en_coches()
        # str_response = LcCursoRepository.get_instance().ejemplo_parsear_salida_de_caracteristicas_coches()
        # str_response = LcCursoRepository.get_instance().ejemplo_parser_fecha()
        # str_response = LcCursoRepository.get_instance().ejemplo_parser_auto_fix()
        # str_response = LcCursoRepository.get_instance().ejemplo_template_system_prompt()
        # str_response = LcCursoRepository.get_instance().ejemplo_prompt_tamplate_save()

        # csv = LcCursoRepository.get_instance().ejemplo_get_datos_ventas_small_con_csv_loader()
        # str_response = LcCursoRepository.get_instance().ejemplo_get_html_con_bshtml_loader()
        # str_response = LcCursoRepository.get_instance().ejemplo_resumir_pdf()
        # str_response = LcCursoRepository.get_instance().ejemplo_resumir_wikipedia()
        # str_response = LcCursoRepository.get_instance().ejemplo_transformer()
        # str_response = LcCursoRepository.get_instance().ejemplo_embeddings()
        # str_response = LcCursoRepository.get_instance().ejemplo_save_embeddings()
        # str_response = LcCursoRepository.get_instance().ejemplo_compresion_y_optimizacion_de_resultados()
        # str_response = LcCursoRepository.get_instance().ejemplo_creacion_objeto_llm_chain()
        # str_response = LcCursoRepository.get_instance().ejemplo_cadena_secuencia_simple()
        # str_response = LcCursoRepository.get_instance().ejemplo_cadena_secuencia_completo()
        # str_response = LcCursoRepository.get_instance().ejemplo_enrutamiento_de_cadenas()
        # str_response = LcCursoRepository.get_instance().ejemplo_cadenas_transformacion()
        # str_response = LcCursoRepository.get_instance().ejemplo_cadenas_transformacion()
        # str_response = LcCursoRepository.get_instance().ejemplo_preguntas_y_respuestas_run()
        # str_response = LcCursoRepository.get_instance().ejemplo_preguntas_y_respuestas_invoke()
        # str_response = LcCursoRepository.get_instance().ejemplo_chat_messge_history()
        # str_response = LcCursoRepository.get_instance().ejemplo_buffer_en_memoria_completa()
        # str_response = LcCursoRepository.get_instance().ejemplo_buffer_en_memoria_con_ventana()
        # str_response = LcCursoRepository.get_instance().ejemplo_buffer_en_memoria_resumido()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_primer_caso_de_uso()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_con_create_react_agent()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_con_google_search()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_programador_de_codigo_ordena_lista()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_programador_de_codigo_con_dataframe()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_herramientas_personalizadas()
        # str_response = LcCursoRepository.get_instance().ejemplo_agente_conversacional_con_memoria()
        # str_response = LcCursoRepository.get_instance().ejemplo_proyecto_agente_rag_con_memoria()
        str_response = LcCursoRepository.get_instance().ejemplo_agente_sql()

        return LcAskedQuestionDTO(chat_response=f"{str_response}")




