import sys
from pprint import pprint

from core.models.mapping import Mapping
from core.transfers.json_db import JsonDb
from core.transfers.db_db import Dbdb
from core.transfers.api_db import Apidb
from core.transfers.folder_db import FolderDb

def pr(text="",exit=0):
    print(f"etl.py: {text}")
    if exit==1:
        sys.exit()

class Etl:

    objsource = None
    objdestiny = None 

    queries = []

    def __init__(self, mappingfile, mappingid):
        objmapping = Mapping(mappingfile, mappingid)
        self.objsource = objmapping.get_source()
        self.objdestiny = objmapping.get_destiny()
        #pr(f"mappingfile:{mappingfile}, mappingid:{mappingid}")
        #pr(self.objsource)

    def _transf_json_db(self):
        jsondb = JsonDb(self.objsource, self.objdestiny)
        jsondb.queries = self.queries
        jsondb.transfer()
        
    def _transf_db_db(self):
        dbdb = Dbdb(self.objsource, self.objdestiny)
        dbdb.queries = self.queries
        dbdb.transfer()
        
    def _transf_api_db(self):
        apidb = Apidb(self.objsource, self.objdestiny)
        apidb.queries = self.queries
        apidb.transfer()

    def _transf_folder_db(self):
        dbdb = FolderDb(self.objsource, self.objdestiny)
        dbdb.queries = self.queries
        dbdb.transfer()        
                

    def transfer(self):
        if self.objsource.is_file() and self.objdestiny.is_db():
            self._transf_json_db()
        elif self.objsource.is_db() and self.objdestiny.is_db():
            self._transf_db_db()
        elif self.objsource.is_api() and self.objdestiny.is_db():
            self._transf_api_db()
        elif self.objsource.is_folder() and self.objdestiny.is_db():
            self._transf_folder_db()
        else:
            print("transfer type not found!")

    def add_query(self, sql):
        self.queries.append(sql)