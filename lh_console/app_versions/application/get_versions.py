from lh_console.config.config import config
from lh_console.shared.infrastructure.http.requests import http_get



def make_request():
    response = http_get("https://www.example.com")


make_request()