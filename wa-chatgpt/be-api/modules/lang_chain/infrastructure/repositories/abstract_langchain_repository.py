from abc import ABC
from langchain_community.chat_models import ChatOpenAI

from config.config import OPENAI_API_KEY
from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum

class AbstractLangchainRepository(ABC):

    def _get_chat_openai(self) -> ChatOpenAI:
        return ChatOpenAI(
            openai_api_key=OPENAI_API_KEY,
            model_name=OpenAiModelEnum.GPT_3_5_TURBO.value
        )