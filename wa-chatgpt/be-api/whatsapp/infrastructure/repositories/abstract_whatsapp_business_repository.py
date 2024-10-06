from abc import ABC

from config.config import META_BUSINESS_ID, META_BUSINESS_BEARER_TOKEN

from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.sent_message_dto import SentMessageDto

class AbstractWhatsappBusinessRepository(ABC):
    _ROOT_ENDPOINT: str = f"https://graph.facebook.com/v20.0/{META_BUSINESS_ID}"
    _BEARER_TOKEN: str = f"Bearer {META_BUSINESS_BEARER_TOKEN}"



