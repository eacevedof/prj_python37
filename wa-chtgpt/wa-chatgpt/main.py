"""

"""
import os
from openai import OpenAI
from config.config import OPENAI_API_KEY

model_engine = "gpt-3.5-turbo"
prompt = "la suma de 5 mas 5"

clientOpenAI = OpenAI(
    api_key = OPENAI_API_KEY
)
completion = clientOpenAI.chat.completions.create(
    model=model_engine,
    max_tokens=250,
    n=1, #numero de respuestas
    stop=None,
    temperature=0.7, #nivel de creatividad moderado [0,1]
    messages=[
        {
            "role": "user",
            "content": prompt
        }
    ]
)

respuesta = ""
for choice in completion.choices:
    respuesta = respuesta + choice.message.content.strip()
    print(f"response: {respuesta}")