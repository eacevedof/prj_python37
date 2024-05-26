import requests


def http_get(url: str) -> str:
    response = requests.get(url)
    return response.text
