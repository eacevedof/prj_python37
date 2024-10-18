from abc import ABC
from openai import OpenAI
from config.config import OPENAI_API_KEY


class AbstractOpenAiRepository(ABC):

    def _get_client_openai(self) -> OpenAI:
        return OpenAI(
            api_key=OPENAI_API_KEY
        )

