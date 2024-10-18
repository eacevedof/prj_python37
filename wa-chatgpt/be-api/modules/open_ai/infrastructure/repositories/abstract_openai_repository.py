from abc import ABC
from openai import OpenAI
from config.config import OPENAI_API_KEY
from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum
from langchain.chat_models import ChatOpenAI
from langchain.chains.question_answering import load_qa_chain
from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from langchain_core.documents import Document
from typing import List


class AbstractOpenAiRepository(ABC):

    def _get_client_openai(self) -> OpenAI:
        return OpenAI(
            api_key=OPENAI_API_KEY
        )

