import sys
from pprint import pprint
from core.helpers.mysqlserv.querybuilder import QueryBuilder as qb
from core.helpers.mysqlserv.mysql import Mysql

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


    def _get_fields_pattern(self):
        allfields = self.objdestiny.get_data()#["tables"]["fields"]
        pprint(allfields["tables"])
        sys.exit()


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
        #print(arfiles)
        self._get_fields_pattern()







        sys.exit()

        destmysql = Mysql(destiny.get_context().get_dbconfig())

        
        print("...inserting into tables")
        self._insert_by_table(destmysql)
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")


    def add_query(self, sql):
        self.queries.append(sql)

    