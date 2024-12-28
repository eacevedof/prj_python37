from typing import final
from modules.shared.infrastructure.components.log import Log
from modules.open_ai.infrastructure.repositories.openai_repository import OpenAiRepository

from modules.lang_chain.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.lang_chain.application.lc_ask_question.lc_asked_question_dto import LcAskedQuestionDTO

from modules.lang_chain.application.lc_ask_question.curso.integracion_01 import donde_se_encuentra_caceres

@final
class LcAskQuestionService:

    @staticmethod
    def get_instance() -> "LcAskQuestionService":
        return LcAskQuestionService()


    def invoke(self, lc_ask_question: LcAskQuestionDTO) -> LcAskedQuestionDTO:
        chat_response = donde_se_encuentra_caceres()
        return LcAskedQuestionDTO(chat_response=chat_response)




