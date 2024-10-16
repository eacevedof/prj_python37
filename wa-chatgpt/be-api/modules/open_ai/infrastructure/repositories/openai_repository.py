from dataclasses import dataclass
from typing import List, final

from langchain_core.documents import Document
from langchain.chains.question_answering import load_qa_chain

from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
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

    def get_response_using_chain(self, langchain_documents: List[Document], question: str) -> str:
        llm_obj = self._get_chat_openai()
        chain_obj = load_qa_chain(llm_obj, chain_type=LangchainTypeEnum.STUFF.value)
        respuesta = chain_obj.run(input_documents=langchain_documents, question=question)
        return respuesta
