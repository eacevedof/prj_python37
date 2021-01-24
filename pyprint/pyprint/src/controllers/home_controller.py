from src.services.home_service import HomeService
from fastapi import Request

class HomeController:

    def index(self):
        r = (HomeService()).get_index()
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}