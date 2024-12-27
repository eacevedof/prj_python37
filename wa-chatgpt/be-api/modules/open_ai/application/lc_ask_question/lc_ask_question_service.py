from typing import final
from modules.shared.infrastructure.components.log import Log
from modules.open_ai.application.lc_ask_question.lc_ask_question_dto import LcAskQuestionDTO
from modules.open_ai.application.lc_ask_question.lc_asked_question_dto import LcAskedQuestionDTO
from modules.open_ai.infrastructure.repositories.openai_repository import OpenAiRepository


@final
class LcAskQuestionService:

    @staticmethod
    def get_instance() -> "LcAskQuestionService":
        return LcAskQuestionService()


    def invoke(self, lc_ask_question: LcAskQuestionDTO) -> LcAskedQuestionDTO:
        prompt = lc_ask_question.question
        Log.log_debug(LcAskQuestionDTO.__dict__, "LcAskQuestionDTO")
        chat_response = OpenAiRepository.get_instance().get_gpt35_turbo(prompt)
        return LcAskedQuestionDTO(chat_response=chat_response)


