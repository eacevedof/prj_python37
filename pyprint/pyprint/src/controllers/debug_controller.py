from src.services.debug_service import DebugService

class DebugController:

    def index(self):
        r = (DebugService()).get_index()
        return r

    def get_test(self, slug, perro):
        return {"slug_1": slug, "perro_1": perro}