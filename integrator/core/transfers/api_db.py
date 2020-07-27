import sys
import json
from pprint import pprint
from core.helpers.mysqlserv.querybuilder import QueryBuilder as qb
from core.helpers.mysqlserv.mysql import Mysql
from core.tools.tools import file_put_contents

class Apidb:
    objsource = None
    objdestiny = None

    queries = []

    def __init__(self, objsource, objdestiny):
        self.objsource = objsource
        self.objdestiny = objdestiny

        self._printattribs()

    def _printattribs(self):
        #print("\nobjsource"); pprint(self.objsource.get_data())
        #print("\nobjsource.context"); pprint(self.objsource.get_context().get_content())
        #print("\nobjdestiny"); pprint(self.objdestiny.get_data()); sys.exit()
        pass

    def _get_source_data(self):
        return self.objsource.get_context().get_content()

    # guarda en fichero el json devuelto por la api de gdcos
    def _file_debug(self,idie=1):
        rows = self._get_source_data()
        strjson = json.dumps(rows)
        print(strjson)
        file_put_contents("./temp000.json",strjson)
        if idie==1:
            sys.exit()


    def _insert_by_rows(self,mysql,tabledest,mapfields,fromfields):
        # self._file_debug()
        for row in self._get_source_data():
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
        for tablecfg in self.objdestiny.get_tables():
            #pprint(tablecfg);sys.exit()
            tabledest = tablecfg["name"]
            mapfields = tablecfg["fields"]
            fromfields = list(mapfields.keys())
            self._truncate_table(mysql, tabledest)
            self._insert_by_rows(mysql, tabledest, mapfields, fromfields)

    def _run_queries(self, mysql):
        for sql in self.queries:
            mysql.execute(sql)        

    def transfer(self):
        print("starting transfer....")

        source = self.objsource
        destiny = self.objdestiny

        destmysql = Mysql(destiny.get_context().get_dbconfig())
        print("...inserting into tables")
        self._insert_by_table(destmysql)
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")


    def add_query(self, sql):
        self.queries.append(sql)

    