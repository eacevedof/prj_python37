from googleserv.sheets import Sheets
from mysqlserv.mysql import Mysql

mapeo = {
    "tables":{
        "sheet":"imp_products"
    },
    "fields":{
        "PRCODPRO":"code",
        "PRDESCRI":"description",
        "PROBSERV":"description_full",
        "PRMONMON":"price",
        "PRMONUSD":"price2",
        "DISPLAY":"display",
    }
}


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