"""Repositorio abstracto base para comunicación con OpenAI API."""

from abc import ABC
from openai import OpenAI

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository


class AbstractOpenAIApiRepository(ABC):
    """
    Repositorio abstracto base para todas las comunicaciones con OpenAI API.

    Responsabilidades:
    - Gestionar autenticación con API key
    - Proporcionar cliente OpenAI configurado
    - Logging específico de OpenAI
    """

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._api_key = EnvironmentReaderRawRepository.get_instance().get("OPENAI_API_KEY", "")

        if not self._api_key:
            raise Exception("OPENAI_API_KEY no configurada en .env")

        self._open_ai_client = OpenAI(api_key=self._api_key)

    def _log_openai_success(self, operation: str, context: dict) -> None:
        """Logging exitoso de llamadas a OpenAI."""
        self._logger.log_info(
            "open-ai",
            f"SUCCESS: {operation}"
        )

    def _log_openai_error(self, message: str, context: dict) -> None:
        """Logging de errores de OpenAI."""
        self._logger.log_error(
            "AbstractOpenAIApiRepository",
            message,
            context,
        )
