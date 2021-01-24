from src.services.home_service import HomeService
from fastapi import Request
from src.components.log_component import LogComponent

class HomeController:

    def index(self):
        log = LogComponent()
        r = (HomeService()).get_index()
        log.save(HomeService(), "HomeService")
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}