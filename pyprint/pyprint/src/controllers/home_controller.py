from src.services.home_service import HomeService
from fastapi import Request
from src.factories.log_factory import get_log
from src.components.print_component import PrintComponent

class HomeController:

    def __init__(self):
        self.__log = get_log()

    def index(self):
        routes = ["/","/"]

        self.__log.save(HomeService(), "HomeService")
        #r = (HomeService()).get_index()
        r = {
            "routes": routes
        }
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}