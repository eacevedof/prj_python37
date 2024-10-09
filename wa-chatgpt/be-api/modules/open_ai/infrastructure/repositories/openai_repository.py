from openai import OpenAI
from config.config import OPENAI_API_KEY
from modules.open_ai.infrastructure.enums.open_ai_model_enum import OpenAiModelEnum

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


def __get_client_openai() -> OpenAI:
    return OpenAI(
        api_key = OPENAI_API_KEY
    )