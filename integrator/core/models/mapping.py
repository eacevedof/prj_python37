import sys
from core.core import Core as core
from core.models.base import Base
from core.models.source import Source
from core.models.destiny import Destiny

class Mapping(Base):

    def __init__(self, pathfile, id):
        pathmapping = core.get_path_mapping(pathfile)
        super().__init__(pathmapping, id)

    def get_source(self):
        dicconfig = self.get("source")
        objsource = Source(dicconfig)
        return objsource

    def get_destiny(self):
        dicconfig = self.get("destiny")
        # print(dicconfig); sys.exit()
        objdestiny = Destiny(dicconfig)
        return objdestiny
