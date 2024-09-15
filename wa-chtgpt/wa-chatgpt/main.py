"""

"""
import os
from openai import OpenAI



#import sys; sys.path.append("..")

from config.config import OPENAI_API_KEY

model_engine = "gpt-3.5-turbo"
model_engine = "gpt-4o"

prompt = "la suma de 5 mas 5"
completion = openai.Completion.create(
    engine=model_engine,
    prompt=prompt,
    max_tokens=1024,
    n=1,
    stop=None,
    temperature=0.7
)

clientOpenAI = OpenAI(
    api_key=OPENAI_API_KEY
)
completion = clientOpenAI.chat.completions.create(
    model = model_engine,

    messages = [
        {
            "role": "user",
            "content": "write a haiku about ai"
        }
    ]
)


respuesta = ""
for choice in completion.choices:
    respuesta = respuesta + choice.text.strip()
    print(f"response: {respuesta}")