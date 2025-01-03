from typing import final
from modules.shared.infrastructure.components.log import Log

from modules.lang_chain.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.lang_chain.application.lc_ask_question.lc_asked_question_dto import LcAskedQuestionDTO

from modules.lang_chain.infrastructure.repositories.lc_curso_repository import LcCursoRepository

@final
class LcAskQuestionService:

    @staticmethod
    def get_instance() -> "LcAskQuestionService":
        return LcAskQuestionService()


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
        str_response = LcCursoRepository.get_instance().ejemplo_compresion_y_optimizacion_de_resultados()

        return LcAskedQuestionDTO(chat_response=f"{str_response}")




