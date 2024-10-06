
from flask import Response, request

from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.sent_message_dto import SentMessageDto


def send_message(send_message_dto: SendMessageDto) -> SentMessageDto:

    __fail_if_wrong_input(send_message_dto)

    number = send_message_dto.to_phone_number
    message = send_message_dto.message

    return SentMessageDto()



def __fail_if_wrong_input(send_message_dto: SendMessageDto):
    if not send_message_dto.to_phone_number:
        raise SendMessageException(
            code=HttpResponseCodeEnum.BAD_REQUEST.value,
            message="whatsapp-tr.to_phone_number-is-required"
        )

    if not send_message_dto.message:
        raise SendMessageException(
            code=HttpResponseCodeEnum.BAD_REQUEST.value,
            message="whatsapp-tr.message-is-required"
        )