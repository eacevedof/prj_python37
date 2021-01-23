from src.services.home_service import HomeService

class HomeController:

    def index(self):
        r = (HomeService()).get_index()
        return r
