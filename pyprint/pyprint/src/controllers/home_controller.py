from src.services.home_service import HomeService

class HomeController:

    def index(self):
        r = (HomeService()).get_index()
        return r

    def get_test(self, slug, perro):
        return {"slug_1": slug, "perro_1": perro}