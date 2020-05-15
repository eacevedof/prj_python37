import sys
from core.core import Core as core
from googleserv.sheets import Sheets
from mysqlserv.mysql import Mysql
from mysqlserv.querybuilder import QueryBuilder as qb
from fileserv.json import Json

jsonhelper = Json()

# configuración general de la ETL
pathmapping = core.get_path_mapping("fromto.json")
jsonhelper.set_pathfile(pathmapping)
jsonhelper.load_data()
mapping = jsonhelper.get_dictbykey("id","transfer-1")
#print(mapping); sys.exit()

#obtengo el origen
dictsource = mapping["source"]["context"]
destdatabase = mapping["destiny"]["context"]["database"]
# print(dictsource); print(destdatabase); sys.exit()
pathcontext = core.get_path_context(dictsource["file"])
jsonhelper.set_pathfile(pathcontext)
jsonhelper.load_data()
# print(jsonhelper.get_data()); sys.exit()

dicsource = jsonhelper.get_dictbykey("id","json1")
pathsource = core.get_path_in(dicsource["path"])
jsonhelper.set_pathfile(pathsource)
sourcedata = jsonhelper.get_loaded()
#print(jsonhelper.get_data()); sys.exit()

dictdestiny = mapping["destiny"]["context"]
pathdestiny = core.get_path_context(dictdestiny["file"])
jsonhelper.set_pathfile(pathdestiny)
jsonhelper.load_data()
# print(jsonhelper.get_data()); sys.exit()
dicconxcfg = jsonhelper.get_dictbykey("id","mysql1")
# print(dicconxcfg); sys.exit()
dbconfig = core.get_dbconfig(dicconxcfg,destdatabase)
# print(dbconfig); sys.exit()



def insert_by_rows(mysql,sourcedata,tabledest,mapfields,fromfields):
    for row in sourcedata:
        insert = {"keys":[],"values":[]}
        for field in row:
            if field in fromfields:
                insert["keys"].append(mapfields[field])
                insert["values"].append(row[field])
        # print(insert)
        qbsql = qb.get_insert_dict(tabledest, insert["keys"], insert["values"])
        # print(qbsql);print("\n")
        mysql.insert(qbsql)


# print(tofields[0])
def insert_by_table(mysql):
    # segun el mapeo y los datos de origen tengo que crear las consultas insert
    # para ir volcandolas en destino
    # @todo esto podria permitir que unos campos del origen vayan a una tabla y otros campos a otra
    for tablecfg in mapping["tables"]:
        tabledest = tablecfg["table_dest"]
        mapfields = tablecfg["fields"]
        fromfields = list(mapfields.keys())
        mysql.execute(f"TRUNCATE TABLE {tabledest}")
        insert_by_rows(mysql, sourcedata,tabledest,mapfields,fromfields)


def run_etl():
    mysql = Mysql(dbconfig)
    insert_by_table(mysql)
        
