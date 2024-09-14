"""

"""
#import sys; sys.path.append("..")
import openai
from config.config import CHATGPT_API_KEY

openai.api_key = CHATGPT_API_KEY
model_engine = "text-davinci-003"
prompt = "la suma de 5 mas 5"
completion = openai.Completion.create(
    engine=model_engine,
    prompt=prompt,
    max_tokens=1024,
    n=1,
    stop=None,
    temperature=0.7
)

respuesta = ""
for choice in completion.choices:
    respuesta = respuesta + choice.text.strip()
    print(f"response: {respuesta}")
