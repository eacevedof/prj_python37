from abc import ABC
from openai import OpenAI
from config.config import OPENAI_API_KEY
from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum
from langchain.chat_models import ChatOpenAI
from langchain.chains.question_answering import load_qa_chain
from modules.shared.infrastructure.enums.langchain_type_enum import LangchainTypeEnum
from langchain_core.documents import Document
from typing import List

class AbstractOpenaAiRepository(ABC):
    __ROOT_ENDPOINT: str = f"https://graph.facebook.com/v20.0/{META_BUSINESS_ID}"
    __BEARER_TOKEN: str = f"Bearer {META_BUSINESS_BEARER_TOKEN}"

    def _get_client_openai() -> OpenAI:
        return OpenAI(
            api_key = OPENAI_API_KEY
        )


def get_gpt35_turbo(question: str) -> str:
    client_open_ai = __get_client_openai()

    chat_completion = client_open_ai.chat.completions.create(
        model = OpenAiModelEnum.GPT_3_5_TURBO.value,
        max_tokens = 250,
        n = 1, # numero de respuestas
        stop = None,
        temperature = 0.7, # nivel de creatividad moderado [0,1]
        messages=[
            {
                "role": "user",
                "content": question
            }
        ]
    )
    # return chat_completion.choices[0].message["content"] error
    return chat_completion.choices[0].message.content


def get_response_using_chain(langchain_documents: List[Document], question: str) -> str:
    llm_obj = ChatOpenAI(
        model_name = OpenAiModelEnum.GPT_3_5_TURBO.value,
        openai_api_key = OPENAI_API_KEY
    )
    chain_obj = load_qa_chain(llm_obj, chain_type = LangchainTypeEnum.STUFF.value)
    respuesta = chain_obj.run(input_documents = langchain_documents, question = question)
    return respuesta