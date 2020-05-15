import sys
from pprint import pprint
from core.core import Core as core
# from googleserv.sheets import Sheets
from mysqlserv.mysql import Mysql
from mysqlserv.querybuilder import QueryBuilder as qb
from fileserv.json import Json

class Etl:
    mapping_file = ""
    mapping_id = ""
    
    dicmapping = {}
    dicsource = {}
    dicdestiny = {}
    dicdbconfig = {}
    sourcedata = []

    helpjson = Json()

    def __init__(self, mappingfile, mappingid):
        self.mapping_file = mappingfile
        self.mapping_id = mappingid
        self.helpjson = Json()

        self._load_mapping()
        self._load_source()
        self._load_destiny()
        self._load_dbconfig()


    def _load_mapping(self):
        pathmapping = core.get_path_mapping(self.mapping_file)
        self.helpjson.set_pathfile(pathmapping)
        self.helpjson.load_data()
        self.dicmapping = self.helpjson.get_dictbykey("id",self.mapping_id)

    def _load_source(self):
        # donde esta el archivo in
        pathsource = core.get_path_context(self.dicmapping["source"]["context"]["file"])
        self.helpjson.set_pathfile(pathsource)
        self.helpjson.load_data()
        # con que conjunto de esquemas voy a trabajar
        self.dicsource = self.helpjson.get_dictbykey("id",self.dicmapping["source"]["context"]["id"])

    def _load_destiny(self):
        # donde se volcarán los datos
        pathdestiny = core.get_path_context(self.dicmapping["destiny"]["context"]["file"])
        self.helpjson.set_pathfile(pathdestiny)
        self.helpjson.load_data()
        # con que conjunto de esquemas voy a trabajar
        self.dicdestiny = self.helpjson.get_dictbykey("id",self.dicmapping["destiny"]["context"]["id"])
        self.dicdestiny.update({"database":self.dicmapping["destiny"]["context"]["database"]})

    def _load_dbconfig(self):
        self.dicdbconfig = core.get_dbconfig(self.dicdestiny, self.dicdestiny["database"])

    def _insert_by_rows(self):
        pass

    def transfer(self):
        pprint(self.dicmapping)
        pprint(self.dicsource)
        pprint(self.dicdestiny)
        pprint(self.dicdbconfig)
