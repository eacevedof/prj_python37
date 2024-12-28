from typing import final
from modules.shared.infrastructure.components.log import Log
from modules.open_ai.infrastructure.repositories.openai_repository import OpenAiRepository

from modules.lang_chain.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.lang_chain.application.lc_ask_question.lc_asked_question_dto import LcAskedQuestionDTO

from modules.lang_chain.infrastructure.repositories.lc_curso_repository import LcCursoRepository

@final
class LcAskQuestionService:

    @staticmethod
    def get_instance() -> "LcAskQuestionService":
        return LcAskQuestionService()



    def invoke(self, lc_ask_question: LcAskQuestionDTO) -> LcAskedQuestionDTO:
        chat_response = LcCursoRepository.get_instance().donde_se_encuentra_caceres_only_human_message()
        return LcAskedQuestionDTO(chat_response=chat_response)




