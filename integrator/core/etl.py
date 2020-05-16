import sys
from pprint import pprint

from core.models.mapping import Mapping
from core.transfers.json_db import JsonDb

class Etl:

    objsource = None
    objdestiny = None 

    def __init__(self, mappingfile, mappingid):
        self.objmapping = Mapping(mappingfile, mappingid)
        self.objsource = self.objmapping.get_source()
        self.objdestiny = self.objmapping.get_destiny()
        
        
        pass

    def transfer(self):
        # print(self.objsource.get_context().get_content())
        # print(self.objsource.get_context().get_dbconfig())
        jsondb = JsonDb(self.objsource, self.objdestiny)
        jsondb.transfer()
        pass
