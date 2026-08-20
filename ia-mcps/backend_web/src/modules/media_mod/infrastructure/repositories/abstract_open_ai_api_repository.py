"""Abstract base repository for OpenAI API communication."""

from abc import ABC

from openai import OpenAI

from src.modules.shared.infrastructure.components.logger.logger import Logger
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)

from src.modules.media_mod.domain.exceptions.open_ai_exception import OpenAIException


class AbstractOpenAIApiRepository(ABC):
    """
    Abstract base repository for all OpenAI API communications.

    Responsibilities:
    - Manage authentication with API key
    - Provide configured OpenAI client
    - OpenAI-specific logging

    ⚠️ La clave se exige en el PRIMER USO, no al construir el repositorio. Antes
    se validaba en `__init__`, y como el lifespan de la app materializa todos los
    controllers MCP para arrancar sus session managers, un `.env` sin
    `OPENAI_API_KEY` tumbaba el arranque ENTERO (emt, pdf y memory incluidos) con
    un "No open-ai api key provided". Ahora la falta de clave solo rompe las
    tools de media, que es lo único que la necesita.
    """

    _open_ai_client_instance: OpenAI | None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
        self._open_ai_client_instance = None

    @property
    def _open_ai_client(self) -> OpenAI:
        """Cliente de OpenAI, construido en la primera llamada y cacheado.

        Raises:
            OpenAIException: si no hay `OPENAI_API_KEY` configurada.
        """
        if self._open_ai_client_instance is None:
            open_ai_api_key = self._environment_reader_raw_repository.get_openai_api_key()
            if not open_ai_api_key:
                OpenAIException.bad_request_custom("No open-ai api key provided")
            self._open_ai_client_instance = OpenAI(api_key=open_ai_api_key)
        return self._open_ai_client_instance
