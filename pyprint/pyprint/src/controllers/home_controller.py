from src.services.home_service import HomeService
from fastapi import Request
from src.factories.log_factory import get_log
from src.components.print_component import PrintComponent
from src.functions.system import get_os

class HomeController:

    def __init__(self):
        self.__log = get_log()

    def index(self):
        routes = ["/a","/x"]
        r = {
            "os": get_os(),
            "routes": routes
        }
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}