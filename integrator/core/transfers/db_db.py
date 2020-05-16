import sys
from pprint import pprint
from core.helpers.mysqlserv.querybuilder import QueryBuilder as qb
from core.helpers.mysqlserv.mysql import Mysql

class Dbdb:
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

    def _get_source_data(self, srcmysql, fromfields):
        srctable = self.objsource.get_table()
        # print(srctable); sys.exit()
        sql = qb.get_select(srctable, fromfields)
        
        rows = srcmysql.query(sql)
        return rows

    def _insert_by_rows(self,srcmysql,destmysql,tabledest,mapfields,fromfields):
        for row in self._get_source_data(srcmysql,fromfields):
            insert = {"keys":[],"values":[]}
            for field in row:
                if field in fromfields:
                    insert["keys"].append(mapfields[field])
                    insert["values"].append(row[field])
            # print(insert)
            qbsql = qb.get_insert_dict(tabledest, insert["keys"], insert["values"])
            print(qbsql);print("\n")
            destmysql.insert(qbsql)        

    def _truncate_table(self,mysql, table):
        sql = f"TRUNCATE TABLE {table}"
        mysql.execute(sql)

    def _insert_by_table(self, srcmysql, destmysql):
        for tablecfg in self.objdestiny.get_tables():
            # print(tablecfg);sys.exit()
            tabledest = tablecfg["name"]
            mapfields = tablecfg["fields"]
            fromfields = list(mapfields.keys())
            self._truncate_table(destmysql, tabledest)
            self._insert_by_rows(srcmysql, destmysql, tabledest, mapfields, fromfields)

    def _run_queries(self, destmysql):
        for sql in self.queries:
            destmysql.execute(sql)        

    def transfer(self):
        print("starting transfer....")

        source = self.objsource
        destiny = self.objdestiny

        srcmysql = Mysql(source.get_context().get_dbconfig())
        destmysql = Mysql(destiny.get_context().get_dbconfig())
        print("...inserting into tables"); # sys.exit()
        
        self._insert_by_table(srcmysql, destmysql)
        sys.exit()
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")


    def add_query(self, sql):
        self.queries.append(sql)

    