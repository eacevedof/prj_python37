from core.models.pointcfg import Pointcfg

class Source(Pointcfg):

    def __init__(self, dicconfig):
        super().__init__(dicconfig)
    
    def get_conditions(self):
        return self.get("conditions")