"""Repositorio abstracto base para comunicación con OpenAI API."""

from abc import ABC

from openai import OpenAI

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum
from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException


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

        open_ai_api_key = EnvironmentReaderRawRepository.get_instance().get(
            EnvvarsKeysEnum.OPENAI_API_KEY.value,  ""
        )
        if not open_ai_api_key:
            raise OpenAIException.unexpected_custom(
                f"AbstractOpenAIApiRepository: missing env {EnvvarsKeysEnum.OPENAI_API_KEY.value}"
            )

        self._open_ai_client = OpenAI(api_key=open_ai_api_key)
