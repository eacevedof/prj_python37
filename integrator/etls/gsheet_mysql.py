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

# segun el mapeo y los datos de origen tengo que crear las consultas insert
# para ir volcandolas en destino
# @todo
maptable = mapping["tables"][0]
mapfields = maptable["fields"]
fromfields = list(mapfields.keys())
tofields = list(mapfields.values())

print(tofields[0])


insert = {"keys":[],"values":[]}
for row in sourcedata:

    for field in row:
        if field in fromfields:
            insert["keys"].append(mapfields[field])
            insert["values"].append(row[field])
    print(insert)
    dicsql = qb.get_insert_dict("xxx",insert["keys"],insert["values"])
    print(dicsql)
    sys.exit()


sys.exit()
def _get_mysql_field(sheetfield):
    return mapeo["fields"][sheetfield]

def _get_sqlinsert(rowdict=None):
    inserts = []

    tplval = tuple()
    fields = []
    values = []
    for mysqlfield in rowdict:
        fields.append(mysqlfield)
        values.append("%s")
        value = rowdict[mysqlfield]
        tplval = tplval + (value,)
            
    strfields = ",".join(fields)
    strvalues = ",".join(values)

    table = mapeo["tables"]["sheet"]
    sql = f"INSERT INTO {table} ({strfields}) VALUES ({strvalues})"
    inserts.append({"sql":sql, "values":tplval})



def extract():
    osheet = Sheets("temp_xls",2)
    data = osheet.get_data()
    return data

def transform(ardata):
    transf = []
    for rowdict in ardata:
        changed = {}
        for sheetfield in rowdict:
            mysqlfield = _get_mysql_field(sheetfield)
            value = rowdict[sheetfield]
            changed.update({mysqlfield:value})
            
        transf.append(changed)

    return data

def load(ardata):
    omysql = Mysql()
    sql = "truncate table imp_products"
    rt = omysql.execute(sql=sql,tplval=None,w=1)
    print(rt)

if __name__ == '__main__':
    data = extract()
    print(data)