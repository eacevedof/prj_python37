from typing import final
from dataclasses import dataclass

from modules.whatsapp.infrastructure.repositories.abstract_whatsapp_business_repository import \
    AbstractWhatsappBusinessRepository


@final
@dataclass(frozen=True)
class WhatsappBusinessWriterRepository(AbstractWhatsappBusinessRepository):

    def send_text_message(self, phone_number: str, message: str) -> dict:
        payload = {
            "messaging_product": "whatsapp",
            "type": "text",
            "to": phone_number,
            "text": {
                "body": message
            }
        }
        response_data = self._post("messages", payload)
        return response_data
