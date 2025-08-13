from typing import final
from modules.shared.infrastructure.components.log import Log
from modules.open_ai.application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from modules.open_ai.application.talk_to_gpt35.talked_to_gpt35_dto import TalkedToGpt35DTO
from modules.open_ai.infrastructure.repositories.openai_repository import OpenAiRepository


@final
class TalkToGpt35Service:

    @staticmethod
    def get_instance() -> "TalkToGpt35Service":
        return TalkToGpt35Service()


    def invoke(self, talk_to_gpt35_dto: TalkToGpt35DTO) -> TalkedToGpt35DTO:
        prompt = talk_to_gpt35_dto.question
        Log.log_debug(TalkToGpt35DTO.__dict__, "TalkToGpt35DTO")
        chat_response = OpenAiRepository.get_instance().get_gpt35_turbo(prompt)
        return TalkedToGpt35DTO(chat_response=chat_response)


