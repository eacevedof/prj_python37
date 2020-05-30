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

    # devuelve el listado de archivos en la carpeta
    def _get_source_data(self):
        return self.objsource.get_context().get_content()

    def _get_tables(self):
        return self.objdestiny.get_data()["tables"]

    def _get_fields_from_pattern(self,paatern):
        arfields = paatern.split("|")

        arfound = []
        for pat in arfields:
            f = re.search('%(.+?)%',pat)            
            if f:
                strf = f.group(1)
                if strf not in arfound:
                    arfound.append(strf)

        return arfound

    # arfiles son los posibles archivos y las condiciones and para el update
    def _update(self, arfiles, table, upfield):
        omysql = Mysql(self.objdestiny.get_context().get_dbconfig())
        
        folderfiles = self._get_source_data()

        arsql = []
        for folfile in folderfiles:
            for maybefile in arfiles:
                maybef = maybefile["maybe"]
                strcond = maybefile["conds"]
                if folfile == maybef:
                    sql = qb.get_update(table, {upfield:folfile}, [strcond])
                    arsql.append(sql)

        omysql.execute_bulk(arsql)

    def _get_sqlselect(self,tablename, arfields):
        sql = qb.get_select(tablename, arfields)
        return sql
        
    def _get_data(self,sql):
        omysql = Mysql(self.objdestiny.get_context().get_dbconfig())
        data = omysql.query(sql)
        return data

    def _get_pat_replaced(self, fpattern, arfields, ardata):
        archanged=[]

        for row in ardata:
            repl = fpattern
            conds = []
            for field in arfields:
                strfv = row[field]
                repl = repl.replace(f"%{field}%",strfv)
                conds.append(f"{field}='{strfv}'")

            archanged.append({"maybe":repl,"conds":" AND ".join(conds)})

        return archanged

    def _process(self):
        artables = self._get_tables()
        for dictable in artables:
            strtable = dictable["name"]
            dicfields = dictable["fields"]

            for fpattern in dicfields:
                strupfield = dictable[fpattern]
                arfields = self._get_fields_from_pattern(fpattern)
                sql = self._get_sqlselect(strtable, arfields)
                ardata = self._get_data(sql)
                arfiles = self._get_pat_replaced(fpattern, arfields, ardata)
                self._update(arfiles, strtable, strupfield)

    def transfer(self):
        print("starting transfer....")
        self._process()

        sys.exit()
        print("...running extra queries")
        self._run_queries(destmysql)
        print("proces finished!")


    def add_query(self, sql):
        self.queries.append(sql)

    def _run_queries(self, mysql):
        mysql.execute_bulk(self.queries)          

    