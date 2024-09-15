import os

from application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from application.talk_to_gpt35.talked_to_gpt35_dto import TalkedToGpt35DTO
from infrastructure.repositories.openai_repository import get_gpt35_turbo


def invoke(talk_to_gpt35_dto: TalkToGpt35DTO) -> TalkedToGpt35DTO:
    prompt = talk_to_gpt35_dto.question
    chat_response = get_gpt35_turbo(prompt)
    return TalkedToGpt35DTO(chat_response=chat_response)

def __get_ok() -> str:
    return "OK"