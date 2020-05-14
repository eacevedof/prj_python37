from googleserv.sheets import Sheets
from mysqlserv.mysql import Mysql

osheet = Sheets("temp_xls",2)
#data = osheet.get_data()
#print(data)

omysql = Mysql()
sql = "truncate table imp_products"
rt = omysql.execute(sql=sql,tplval=None,w=1)
print(rt)

sql = """
INSERT INTO imp_products (code, description, description_full, price, price2, display) 
VALUES (%s, %s,%s, %s,%s, %s)
"""
values = ("a","b","c","d","e","f")
omysql.execute(sql=sql, tplval=values, w=1)

sql = "select * from imp_products where id!=%s"
r = omysql.execute(sql,("0",))
print(r)

