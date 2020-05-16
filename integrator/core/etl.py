import sys
from pprint import pprint

from core.models.mapping import Mapping
from core.transfers.json_db import JsonDb

class Etl:

    objsource = None
    objdestiny = None 

    def __init__(self, mappingfile, mappingid):
        objmapping = Mapping(mappingfile, mappingid)
        self.objsource = objmapping.get_source()
        self.objdestiny = objmapping.get_destiny()

    def _transf_json_db(self):
        jsondb = JsonDb(self.objsource, self.objdestiny)
        jsondb.transfer()

    def _transf_db_db(self):
        jsondb = JsonDb(self.objsource, self.objdestiny)
        jsondb.transfer()

    def transfer(self):
        if self.objsource.is_file() and self.objdestiny.is_db():
            self._transf_json_db()
        elif self.objsource.is_db() and self.objsource.is_db():
            self._transf_db_db()
        else:
            print("transfer type not found!")
