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
        Log.log_debug(LcAskQuestionDTO.__dict__, "donde_se_encuentra_caceres")
        return LcAskedQuestionDTO(chat_response=chat_response)

    def invoke1(self, lc_ask_question: LcAskQuestionDTO) -> LcAskedQuestionDTO:
        prompt = lc_ask_question.question
        Log.log_debug(LcAskQuestionDTO.__dict__, "LcAskQuestionDTO")
        chat_response = OpenAiRepository.get_instance().get_gpt35_turbo(prompt)
        return LcAskedQuestionDTO(chat_response=chat_response)


