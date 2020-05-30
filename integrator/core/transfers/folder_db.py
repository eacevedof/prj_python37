import sys
import os
from pprint import pprint
from core.helpers.mysqlserv.querybuilder import QueryBuilder as qb
from core.helpers.mysqlserv.mysql import Mysql
import re

class FolderDb:
    objsource = None
    objdestiny = None

    queries = []

    def __init__(self, objsource, objdestiny):
        self.objsource = objsource
        self.objdestiny = objdestiny

        self._printattribs()

    def _printattribs(self):
        #print("\nobjsource"); pprint(self.objsource.get_data())
        #print("\nobjdestiny"); pprint(self.objdestiny.get_data()); sys.exit()
        pass

    def _get_source_data(self):
        return self.objsource.get_context().get_content()


    def _get_splitted(self,paatern):
        arfields = paatern.split("|")

        arfound = []
        for pat in arfields:
            f = re.search('%(.+?)%',pat)            
            if f:
                strf = f.group(1)
                if strf not in arfound:
                    arfound.append(strf)

        return arfound

    def _update(self,config):
        omysql = Mysql(self.objdestiny.get_context().get_dbconfig())
        

    def _get_fields_pattern(self):
        allfields = self.objdestiny.get_data()["tables"][0]["fields"]
        table = self.objdestiny.get_data()["tables"][0]["name"]
        #pprint(allfields)
        arkeys = list(allfields.keys())

        filenames = []
        for pattern in arkeys:
            files = pattern.split("|")
            for file in files:
                if file not in filenames:
                    filenames.append(file)
        
        for pattern in arkeys:
            fields = self._get_splitted(pattern)


        strfields = ", ".join(fields)
        sql = f"SELECT {strfields} FROM {table}"
        # print(sql)

        omysql = Mysql(self.objdestiny.get_context().get_dbconfig())
        arcodes = omysql.query(sql)       
        # print(arcodes)
        
        arfiles = self._get_source_data()
        for diccode in arcodes:
            strcode = diccode["code"]
            if strcode is None:
                continue
            for filepattern in filenames:
                finalname = filepattern.replace("%code%",strcode)
                if os.path.isfile(arfiles["pathfolder"]+"/"+finalname):
                    sql = qb.get_update_dict(table,{"url_image":finalname},[f"code='{strcode}'"])
                    print(sql)
                    omysql.execute(sql)



    def _run_queries(self, mysql):
        for sql in self.queries:
            mysql.execute(sql)        

    def transfer(self):
        print("starting transfer....")

        source = self.objsource
        destiny = self.objdestiny

        #print(source)
        #print(destiny); sys.exit()
        arfiles = self._get_source_data()
        print(arfiles)
        self._get_fields_pattern()





        sys.exit()
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")


    def add_query(self, sql):
        self.queries.append(sql)

    