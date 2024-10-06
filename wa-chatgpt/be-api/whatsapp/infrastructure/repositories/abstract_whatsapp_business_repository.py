from abc import ABC
import requests

from config.config import META_BUSINESS_ID, META_BUSINESS_BEARER_TOKEN
from shared.infrastructure.log import Log


class AbstractWhatsappBusinessRepository(ABC):
    __ROOT_ENDPOINT: str = f"https://graph.facebook.com/v20.0/{META_BUSINESS_ID}"
    __BEARER_TOKEN: str = f"Bearer {META_BUSINESS_BEARER_TOKEN}"

    __headers = {
        "Content-Type": "application/json",
        "Authorization": __BEARER_TOKEN,
    }

    def _post(self, endpoint: str, payload: dict) -> dict:
        endpoint_url = f"{self.__ROOT_ENDPOINT}/{endpoint}"
        response = requests.post(endpoint_url, headers=self.__headers, json=payload)
        response_data = response.json()
        return response_data


    def _get(self, endpoint: str) -> list[dict]:
        endpoint_url = f"{self.__ROOT_ENDPOINT}/{endpoint}"
        response = requests.get(endpoint_url, headers=self.__headers)
        response_data = response.json()
        return response_data



