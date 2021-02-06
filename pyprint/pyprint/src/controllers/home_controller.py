from src.services.home_service import HomeService
from fastapi import Request
from src.factories.log_factory import get_log
from src.factories.print_factory import get_print_component
from src.functions.system import get_os

class HomeController:

    def __init__(self):
        self.__log = get_log()

    def index(self):
        routes = [
            {"url":"/","description":"routes"},
            {"url":"/printers","description":"all printers"},
            {"url":"/prueba/{slug}","description":"prueba de slug"},
            {"url":"/debug","description":"debug"},
        ]

        r = {
            "os": get_os(),
            "routes": routes
        }
        return r

    def printers(self):
        r = (get_print_component()).get_printers()
        #pd(r,"r")
        return {
            "printers": r
        }

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}