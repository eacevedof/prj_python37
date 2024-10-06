from typing import final

from infrastructure.repositories.abstract_whatsapp_business_repository import AbstractWhatsappBusinessRepository

@final
class WhatsappBusinessWriterRepository(AbstractWhatsappBusinessRepository):

    def send_message(self, message: dict) -> dict:
        response_data = self._post("messages", dict)
        return response_data

