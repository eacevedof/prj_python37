"""

"""
import os
from openai import OpenAI

client = OpenAI(
    # This is the default and can be omitted
    api_key=os.environ.get("OPENAI_API_KEY"),
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "Say this is a test",
        }
    ],
    model="gpt-3.5-turbo",
)



#import sys; sys.path.append("..")
import openai
from config.config import CHATGPT_API_KEY

openai.api_key = CHATGPT_API_KEY
model_engine = "gpt-3.5-turbo"
prompt = "la suma de 5 mas 5"
completion = openai.Completion.create(
    engine=model_engine,
    prompt=prompt,
    max_tokens=1024,
    n=1,
    stop=None,
    temperature=0.7
)
from openai import OpenAI
client = OpenAI()
completion = client.chat.completions.create(
    model="gpt-4o",
    messages=[
        {"role": "user", "content": "write a haiku about ai"}
    ]
)


respuesta = ""
for choice in completion.choices:
    respuesta = respuesta + choice.text.strip()
    print(f"response: {respuesta}")