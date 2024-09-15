import os

from application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from infrastructure.repositories.openai_repository import get_gpt35_turbo

def invoke(talk_to_gpt35_dto: TalkToGpt35DTO) -> str:
    prompt = talk_to_gpt35_dto.question
    return get_gpt35_turbo(prompt)

def __get_ok() -> str:
    return "OK"