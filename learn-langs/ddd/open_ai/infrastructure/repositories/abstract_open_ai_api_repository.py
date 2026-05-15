"""Repositorio abstracto base para comunicación con OpenAI API."""

import json
import time
from abc import ABC
from typing import final, Any
import urllib.request
import urllib.error

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository


class AbstractOpenAIApiRepository(ABC):
    """
    Repositorio abstracto base para todas las comunicaciones con OpenAI API.

    Responsabilidades:
    - Gestionar autenticación con API key
    - Manejar requests HTTP (POST)
    - Retry logic para rate limiting (429)
    - Validación de respuestas JSON
    - Logging específico de OpenAI
    """

    # Configuración API
    _API_BASE_URL = "https://api.openai.com/v1"
    _MAX_RETRIES = 3
    _RETRY_DELAY_SECONDS = 15
    _REQUEST_TIMEOUT = 300

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._api_key = EnvironmentReaderRawRepository.get_instance().get("OPENAI_API_KEY", "")
        self._status_code: int | None = None
        self._retry_count = 0

    def _post_http_request(self, endpoint: str, payload: dict[str, Any]) -> dict:
        """
        Realiza POST request a OpenAI API con retry logic.

        Args:
            endpoint: Endpoint relativo (ej: "images/generations")
            payload: Datos a enviar en el body

        Returns:
            dict: Respuesta JSON parseada

        Raises:
            Exception: Si falla el request después de reintentos
        """
        if not self._api_key:
            raise Exception("OPENAI_API_KEY no configurada en .env")

        url = f"{self._API_BASE_URL}/{endpoint}"

        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self._api_key}",
        }

        request_data = json.dumps(payload).encode("utf-8")

        req = urllib.request.Request(
            url,
            data=request_data,
            headers=headers,
            method="POST",
        )

        try:
            with urllib.request.urlopen(req, timeout=self._REQUEST_TIMEOUT) as response:
                self._status_code = response.getcode()
                response_body = response.read().decode("utf-8")

                if not self._is_valid_json(response_body):
                    error_msg = f"[json] Invalid JSON response from {url}"
                    self._log_openai_error(error_msg, {"response": response_body})
                    raise Exception(error_msg)

                self._log_openai_success(endpoint, payload, response_body)
                return json.loads(response_body)

        except urllib.error.HTTPError as e:
            self._status_code = e.code
            error_body = e.read().decode("utf-8") if e.fp else str(e)

            # Retry logic para rate limiting (429)
            if self._status_code == 429 and self._retry_count < self._MAX_RETRIES:
                self._retry_count += 1
                self._logger.write_warning(
                    "AbstractOpenAIApiRepository",
                    f"Rate limit hit (429). Retrying {self._retry_count}/{self._MAX_RETRIES} after {self._RETRY_DELAY_SECONDS}s",
                    {"endpoint": endpoint},
                )
                time.sleep(self._RETRY_DELAY_SECONDS)
                return self._post_http_request(endpoint, payload)

            # Reset retry count
            self._retry_count = 0

            # Log error y lanzar excepción
            error_msg = f"[response-code] {self._status_code} from {url}"
            self._log_openai_error(error_msg, {
                "status_code": self._status_code,
                "response": error_body,
                "payload": payload,
            })
            raise Exception(f"OpenAI API Error {self._status_code}: {error_body}")

        except urllib.error.URLError as e:
            error_msg = f"[network] Connection error to {url}: {e.reason}"
            self._log_openai_error(error_msg, {"endpoint": endpoint, "payload": payload})
            raise Exception(error_msg)

        except Exception as e:
            error_msg = f"[unexpected] Error calling {url}: {str(e)}"
            self._log_openai_error(error_msg, {"endpoint": endpoint, "payload": payload})
            raise

    def _is_valid_json(self, text: str) -> bool:
        """Valida si un string es JSON válido."""
        try:
            json.loads(text)
            return True
        except json.JSONDecodeError:
            return False

    def _log_openai_success(self, endpoint: str, payload: dict, response: str) -> None:
        """Logging exitoso de llamadas a OpenAI."""
        self._logger.write_log(
            "open-ai",
            f"SUCCESS: {endpoint}",
            {
                "endpoint": endpoint,
                "payload": payload,
                "response": response[:500] if len(response) > 500 else response,
                "status_code": self._status_code,
            },
        )

    def _log_openai_error(self, message: str, context: dict) -> None:
        """Logging de errores de OpenAI."""
        self._logger.write_error(
            "AbstractOpenAIApiRepository",
            message,
            context,
        )

    @property
    def status_code(self) -> int | None:
        """Retorna el código de estado HTTP de la última request."""
        return self._status_code
