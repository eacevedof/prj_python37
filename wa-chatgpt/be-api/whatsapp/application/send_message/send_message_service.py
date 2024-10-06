from flask import Response, request

from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.sent_message_dto import SentMessageDto

def send_message(talk_to_gpt35_dto: SendMessageDto) -> SentMessageDto:
    prompt = talk_to_gpt35_dto.question

    chat_response = get_gpt35_turbo(prompt)
    return TalkedToGpt35DTO(chat_response=chat_response)


def __get_ok() -> None:
    TalkToGpt35Exception.empty_question()
