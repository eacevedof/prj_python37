from modules.shared.infrastructure.components.log import Log
from modules.open_ai.application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from modules.open_ai.application.talk_to_gpt35.talked_to_gpt35_dto import TalkedToGpt35DTO
from modules.open_ai.infrastructure.repositories.openai_repository import OpenAiRepository
from modules.open_ai.domain.exceptions.talk_to_gpt35_exception import TalkToGpt35Exception


def talk_to_gpt35_service(talk_to_gpt35_dto: TalkToGpt35DTO) -> TalkedToGpt35DTO:
    prompt = talk_to_gpt35_dto.question
    Log.log_debug(TalkToGpt35DTO.__dict__, "TalkToGpt35DTO")
    chat_response = OpenAiRepository.get_instance().get_gpt35_turbo(prompt)
    return TalkedToGpt35DTO(chat_response=chat_response)


def __get_ok() -> None:
    TalkToGpt35Exception.empty_question()
