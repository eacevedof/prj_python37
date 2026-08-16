import requests
import json


def http_get(url: str) -> dict:
    response = requests.get(url)
    return __get_text_as_dict(response.text)


def __get_text_as_dict(text: str) -> dict:
    try:
        return json.loads(text)
    except Exception as e:
        return {"error": str(e)}
