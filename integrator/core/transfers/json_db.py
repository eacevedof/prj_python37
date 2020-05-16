import sys

class JsonDb:
    mapping_file = ""
    mapping_id = ""
    
    dicmapping = {}
    dicsource = {}
    dicdestiny = {}
    dicdbconfig = {}
    sourcedata = []

    helpjson = Json()

    queries = []

    def __init__(self, mappingfile, mappingid):
        self.mapping_file = mappingfile
        self.mapping_id = mappingid
        self.helpjson = Json()

        print("...loading mapping")
        self._load_mapping()
        print("...loading source")
        self._load_source()
        print("...loading destiny")
        self._load_destiny()
        print("...loading dbconfig")
        self._load_dbconfig()
        self._printattribs()

    def _printattribs(self):
        #print("\ndicmapping"); pprint(self.dicmapping); sys.exit()
        #print("\ndicsource"); pprint(self.dicsource); sys.exit()
        #print("\ndicdestiny"); pprint(self.dicdestiny); sys.exit()
        #print("\ndicdbconfig"); pprint(self.dicdbconfig); sys.exit()
        pass


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
        pprint(self.dicmapping["destiny"]); sys.exit()
        self.dicdestiny = self.helpjson.get_dictbykey("id",self.dicmapping["destiny"]["context"]["id"])
        self.dicdestiny.update({"database":self.dicmapping["destiny"]["context"]["database"]})

    def _load_dbconfig(self):
        self.dicdbconfig = core.get_dbconfig(self.dicdestiny, self.dicdestiny["database"])

    def _insert_by_rows(self,mysql,tabledest,mapfields,fromfields):
        for row in self.sourcedata:
            insert = {"keys":[],"values":[]}
            for field in row:
                if field in fromfields:
                    insert["keys"].append(mapfields[field])
                    insert["values"].append(row[field])
            # print(insert)
            qbsql = qb.get_insert_dict(tabledest, insert["keys"], insert["values"])
            # print(qbsql);print("\n")
            mysql.insert(qbsql)        

    def _truncate_table(self,mysql, table):
        sql = f"TRUNCATE TABLE {table}"
        mysql.execute(sql)

    def _insert_by_table(self, mysql):
        for tablecfg in self.dicmapping["tables"]:
            # pprint(tablecfg); sys.exit()
            tabledest = tablecfg["table_dest"]
            mapfields = tablecfg["fields"]
            fromfields = list(mapfields.keys())
            self._truncate_table(mysql, tabledest)
            self._insert_by_rows(mysql, tabledest, mapfields, fromfields)

    def _extract_json(self):
        pathin = core.get_path_in(self.dicsource["path"])
        self.helpjson.set_pathfile(pathin)
        self.helpjson.load_data()
        self.sourcedata = self.helpjson.get_loaded()
        self.helpjson.reset()

    def _extract(self):
        if self.dicsource["type"] == "json":
            self._extract_json()

    def _run_queries(self, mysql):
        for sql in self.queries:
            mysql.execute(sql)        

    def transfer(self):
        objmysql = Mysql(self.dicdbconfig)
        print("...extracting")
        self._extract() # carga en self.sourcedata
        print("...inserting into tables")
        self._insert_by_table(objmysql)
        print("...running extra queries")
        self._run_queries(objmysql)
        print("proces finished!")

    def add_query(self, sql):
        self.queries.append(sql)

    