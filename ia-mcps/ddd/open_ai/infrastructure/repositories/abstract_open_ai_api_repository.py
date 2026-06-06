"""Abstract base repository for OpenAI API communication."""

from abc import ABC

from openai import OpenAI

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException


class AbstractOpenAIApiRepository(ABC):
    """
    Abstract base repository for all OpenAI API communications.

    Responsibilities:
    - Manage authentication with API key
    - Provide configured OpenAI client
    - OpenAI-specific logging
    """

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

        open_ai_api_key = EnvironmentReaderRawRepository.get_instance().get_openai_api_key()
        if not open_ai_api_key:
            OpenAIException.bad_request_custom("No open-ai api key provided")

        self._open_ai_client = OpenAI(api_key=open_ai_api_key)
