from typing import Dict, List

from datetime import datetime
import uuid
from pprint import pprint
from components.mysqlqb import MysqlQB
from components.mysqlcli import MysqlCli


def get_db1():
    db = MysqlCli(arconn={
        "host": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest",
        #"port": 3307
    })
    return db


def get_db2():
    db = MysqlCli(arconn={
        "host": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest2",
        #"port": 3307
    })
    return db


def extract_from_db1() -> List[Dict]:
    print("...extract from db1 \n")
    query = MysqlQB()
    sql = query.\
        set_comment("some comment")\
        .set_table("app_array as m")\
        .add_getfield("id")\
        .add_getfield("code_erp")\
        .add_getfield("description")\
        .add_getfield("type")\
        .add_and("m.id > 10")\
        .get_select()

    print(sql)

    db1 = get_db1()
    r = db1.query(sql)
    #db1.close()

    db11 = get_db1()
    r = db11.query(sql)

    db12 = get_db1()
    r = db12.query(sql)
    db12.close()

    db13 = get_db1()
    r = db13.query(sql)
    #db13.close()

    return r


def transform(r:List[Dict]) -> List[Dict]:
    print("...transform db1 \n")
    now = datetime.now()
    now = now.strftime("%Y-%m-%d:%H:%M:%S")

    #pprint(r)
    rows = []
    for i,row in enumerate(r):
        #pprint(f"i={str(i)}")
        d = {
            "code_erp"      : row.get("id", ""),
            "description"   : (row.get("description", " desc") + " " + now) if row.get("description", "") is not None else None,
            "`type`"          : row.get("type",None),
            "code_cache"    : str(uuid.uuid1())
        }
        rows.append(d)
    return rows


def delete_db2():
    pprint("...delete db2 \n")
    sql = (MysqlQB())\
        .set_comment("some delete")\
        .set_table("app_array")\
        .add_and("1")\
        .get_delete()
    sql = (MysqlQB()).set_comment(" truncate all").set_table("app_array").get_truncate()
    print(sql)
    db2 = get_db2()
    db2.exec(sql)


def load_into_db2(r: List[Dict]) -> None:
    print("...load into db2 \n")
    #pprint(r)
    sqls = []
    for i, row in enumerate(r):
        comment = f"row "+str(i)
        query = MysqlQB()
        query.set_table("app_array").set_comment(comment)
        for field in row:
            value = row.get(field)
            query.add_insert_fv(field, value)

        sqls.append(query.get_insert())

    sqls = ";".join(sqls) + ";"
    print(sqls)
    db2 = get_db2()
    db2.exec(sqls, True)
    if db2.is_error():
        pprint("ERROR in db2\n")
        pprint(db2.get_errors())
    #db2.close()
    pprint("  === ETL end ===")


def index():
    """
    por más que abro conexiones en el listado de hilos conectados y procesos solo se muestra 1 más
    es decir, 2 (1 de yog y otro de python)
    """
    delete_db2()
    r = extract_from_db1()
    r = transform(r)
    load_into_db2(r)

index()

"""
docker exec -it --user root cont-mariadb-univ bash;
mysql -u root -p

show global status where `variable_name` like '%Threads_%' or `variable_name` LIKE '%connected%';
show processlist;
"""
