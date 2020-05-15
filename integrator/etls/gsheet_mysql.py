import sys
from core.core import Core as core
from googleserv.sheets import Sheets
from mysqlserv.mysql import Mysql
from fileserv.json import Json

jsonhelper = Json()
strpathctx = core.get_path_context("%contexts%/files.json")
jsonhelper.set_pathfile(strpathctx)
jsonhelper.load_data()
dictctx = jsonhelper.get_dictbykey("id","json1")
infile = core.get_path_in(dictctx["path"]) 
jsonhelper.set_pathfile(infile)
products = jsonhelper.get_data()





print(products)
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