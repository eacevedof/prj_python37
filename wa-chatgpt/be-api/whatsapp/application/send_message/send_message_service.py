from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.sent_message_dto import SentMessageDto
from whatsapp.infrastructure.repositories.whatsapp_business_writer_repository import WhatsappBusinessWriterRepository

def send_message_service(send_message_dto: SendMessageDto) -> SentMessageDto:

    __fail_if_wrong_input(send_message_dto)

    number = send_message_dto.phone_number
    message = send_message_dto.message

    wa_response = WhatsappBusinessWriterRepository().send_text_message(number, message)
    Log.log_debug(wa_response, "send_message_service.send_message")
    return SentMessageDto("ok")


def __fail_if_wrong_input(send_message_dto: SendMessageDto):
    if not send_message_dto.phone_number:
        raise SendMessageException(
            code=HttpResponseCodeEnum.BAD_REQUEST.value,
            message="whatsapp-tr.phone-number-is-required"
        )

    if not send_message_dto.message:
        raise SendMessageException(
            code=HttpResponseCodeEnum.BAD_REQUEST.value,
            message="whatsapp-tr.message-is-required"
        )