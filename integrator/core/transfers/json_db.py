import sys
from pprint import pprint
from core.helpers.mysqlserv.querybuilder import QueryBuilder as qb
from core.helpers.mysqlserv.mysql import Mysql

class JsonDb:
    objsource = None
    objdestiny = None

    helpjson = None
    queries = []

    def __init__(self, objsource, objdestiny):
        self.objsource = objsource
        self.objdestiny = objdestiny


    def _printattribs(self):
        #print("\ndicmapping"); pprint(self.dicmapping); sys.exit()
        #print("\ndicsource"); pprint(self.dicsource); sys.exit()
        #print("\ndicdestiny"); pprint(self.dicdestiny); sys.exit()
        #print("\ndicdbconfig"); pprint(self.dicdbconfig); sys.exit()
        pass


    def _insert_by_rows(self,mysql,tabledest,mapfields,fromfields):
        for row in self.objsource.get_context().get_content():
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
        print("transfer....")
        
        print("\n source");pprint(self.objsource.dicconfig)
        print("\n dest");pprint(self.objdestiny.dicconfig)
        
        source = self.objsource
        destiny = self.objdestiny

        srcmysql = None
        destmysql = None

        if source.is_db():
            print("source is db")
            srcmysql = Mysql(source.get_context().get_dbconfig())
        
        if destiny.is_db():
            print("dest is db")
            destmysql = Mysql(destiny.get_context().get_dbconfig())

        print("...inserting into tables")
        self._insert_by_table(destmysql)
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")

    def add_query(self, sql):
        self.queries.append(sql)

    