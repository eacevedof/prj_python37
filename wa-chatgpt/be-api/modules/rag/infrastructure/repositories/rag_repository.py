from dataclasses import dataclass
from typing import List, final

from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum
from modules.open_ai.infrastructure.repositories.abstract_openai_repository import AbstractOpenAiRepository

# Separador con el que se concatenan los fragmentos recuperados dentro del
# prompt. Es el mismo que usaba la "stuff chain" de langchain.
CONTEXT_SEPARATOR = "\n\n"


@final
@dataclass(frozen=True)
class RagRepository(AbstractOpenAiRepository):

    @staticmethod
    def get_instance() -> "RagRepository":
        return RagRepository()


    def get_response_from_context(self, context_chunks: List[str], question: str) -> str:
        context = CONTEXT_SEPARATOR.join(context_chunks)
        chat_completion = self._get_client_openai().chat.completions.create(
            model=OpenAiModelEnum.GPT_3_5_TURBO.value,
            messages=[
                {
                    "role": "system",
                    "content": f"{question}:\n\n{context}"
                }
            ]
        )
        return chat_completion.choices[0].message.content or ""
