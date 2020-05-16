import sys
from pprint import pprint

from core.models.context import Context
from core.models.mapping import Mapping


class Etl:

    objmapping = None

    def __init__(self, mappingfile, mappingid):
        self.objmapping = Mapping(mappingfile, mappingid)
        pass

    def transfer(self):
        pass
