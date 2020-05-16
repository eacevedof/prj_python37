import sys
from pprint import pprint

from core.models.context import Context
from core.models.mapping import Mapping


class Etl:

    objmapping = None
    ctxsource = None 

    def __init__(self, mappingfile, mappingid):
        self.objmapping = Mapping(mappingfile, mappingid)
        #pprint(self.objmapping.get_data()); sys.exit()
        # pprint(self.objmapping.get("source"))
        self.ctxsource = self.objmapping.get_destiny().get_context().get("schemas")
        pprint(self.ctxsource)
        pass

    def transfer(self):
        pass
