from src.services.home_service import HomeService
from fastapi import Request
from src.factories.log import get_log

class HomeController:

    def __init__(self):
        self.__log = get_log()

    def index(self):
        self.__log.save(HomeService(), "HomeService")
        r = (HomeService()).get_index()
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}