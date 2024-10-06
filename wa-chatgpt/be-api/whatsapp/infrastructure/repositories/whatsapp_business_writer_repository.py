from typing import final
from flask import Response, request

from infrastructure.repositories.abstract_whatsapp_business_repository import AbstractWhatsappBusinessRepository
from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.sent_message_dto import SentMessageDto

@final
class WhatsappBusinessWriterRepository(AbstractWhatsappBusinessRepository):
    pass

