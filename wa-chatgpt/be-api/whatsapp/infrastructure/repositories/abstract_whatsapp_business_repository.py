from typing import Any
from abc import ABC
import requests
from requests import Response

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

        if response.status_code != 200:
            self.__log_error(response, endpoint)

        dict_response = response.json()
        return dict_response


    def _get(self, endpoint: str) -> list[dict]:
        endpoint_url = f"{self.__ROOT_ENDPOINT}/{endpoint}"
        response = requests.get(endpoint_url, headers=self.__headers)
        dict_response = response.json()
        return dict_response


    def __log_error(self, response: Response, endpoint: str):
        Log.log_error({
            "url": endpoint,
            "client_error": response.json(),
            "server_error": response.text,
            "status": response.status_code,
            "reason": response.reason
        }, endpoint)

