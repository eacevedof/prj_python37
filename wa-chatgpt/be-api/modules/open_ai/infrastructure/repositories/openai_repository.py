from dataclasses import dataclass
from typing import final

from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum
from modules.open_ai.infrastructure.repositories.abstract_openai_repository import AbstractOpenAiRepository


@final
@dataclass(frozen=True)
class OpenAiRepository(AbstractOpenAiRepository):

    @staticmethod
    def get_instance() -> "OpenAiRepository":
        return OpenAiRepository()

    def get_gpt35_turbo(self, question: str) -> str:
        client_open_ai = self._get_client_openai()

        chat_completion = client_open_ai.chat.completions.create(
            model=OpenAiModelEnum.GPT_3_5_TURBO.value,
            max_tokens=250,
            n=1,  # numero de respuestas
            stop=None,
            temperature=0.7,  # nivel de creatividad moderado [0,1]
            messages=[
                {
                    "role": "user",
                    "content": question
                }
            ]
        )
        # return chat_completion.choices[0].message["content"] error
        return chat_completion.choices[0].message.content
