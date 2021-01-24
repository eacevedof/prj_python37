from src.services.home_service import HomeService
from fastapi import Request
from src.components.log_component import LogComponent
from src.boot.paths import PATH_LOGS

class HomeController:

    def index(self):
        log = LogComponent(pathfolder=PATH_LOGS)
        r = (HomeService()).get_index()
        r["PATH"] = PATH_LOGS
        log.save(HomeService(), "HomeService")
        return r

    def test(self, slug: str, request:Request):
        return {"controller": "HomeController", "method": "test", "param":slug, "ip":request.client.host}