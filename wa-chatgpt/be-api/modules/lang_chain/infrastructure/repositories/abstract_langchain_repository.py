from abc import ABC
from langchain_openai import (
    ChatOpenAI,
    OpenAIEmbeddings
)

from config.config import OPENAI_API_KEY
from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum

class AbstractLangchainRepository(ABC):

    def _get_chat_openai(self) -> ChatOpenAI:
        return ChatOpenAI(
            openai_api_key=OPENAI_API_KEY,
            model_name=OpenAiModelEnum.GPT_3_5_TURBO.value
        )

    def _get_chat_openai_no_creativity(self) -> ChatOpenAI:
        return ChatOpenAI(
            openai_api_key=OPENAI_API_KEY,
            temperature=0
        )

    def _get_embeddings_openai(self) -> OpenAIEmbeddings:
        return OpenAIEmbeddings(
            openai_api_key=OPENAI_API_KEY
        )