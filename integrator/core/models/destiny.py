from core.models.pointcfg import Pointcfg

class Destiny(Pointcfg):

    def __init__(self, dicconfig):
        super().__init__(dicconfig)

    def get_tables(self):
        return self.get("tables")