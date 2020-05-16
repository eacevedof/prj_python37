import sys
from pprint import pprint

from core.models.mapping import Mapping
from core.transfers.json_db import JsonDb
from core.transfers.db_db import Dbdb
from core.transfers.api_db import Apidb

class Etl:

    objsource = None
    objdestiny = None 

    queries = []

    def __init__(self, mappingfile, mappingid):
        objmapping = Mapping(mappingfile, mappingid)
        self.objsource = objmapping.get_source()
        self.objdestiny = objmapping.get_destiny()

    def _transf_json_db(self):
        jsondb = JsonDb(self.objsource, self.objdestiny)
        jsondb.queries = self.queries
        jsondb.transfer()
        
    def _transf_db_db(self):
        dbdb = Dbdb(self.objsource, self.objdestiny)
        dbdb.queries = self.queries
        dbdb.transfer()
        
    def _transf_api_db(self):
        dbdb = Apidb(self.objsource, self.objdestiny)
        dbdb.queries = self.queries
        dbdb.transfer()
                

    def transfer(self):
        if self.objsource.is_file() and self.objdestiny.is_db():
            self._transf_json_db()
        elif self.objsource.is_db() and self.objdestiny.is_db():
            self._transf_db_db()
        elif self.objsource.is_api() and self.objdestiny.is_db():
            self._transf_api_db()
        else:
            print("transfer type not found!")

    def add_query(self, sql):
        self.queries.append(sql)