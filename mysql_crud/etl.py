from typing import Dict, List

from datetime import datetime
import uuid
from pprint import pprint
from components.querybuilder import QueryBuilder
from components.connector import Connector


def delete_db2():
    pprint("...delete db2 \n")
    sql = (QueryBuilder())\
        .set_comment("some delete")\
        .set_table("app_array")\
        .add_and("type = 'borrame'")\
        .get_delete()
    pprint(sql)
    db2 = get_db2()
    db2.exec(sql)


def get_db1():
    db = Connector(arconn={
        "server": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest",
        #"port": 3307
    })
    return db

def get_db2():
    db = Connector(arconn={
        "server": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest2",
        #"port": 3307
    })
    return db

def extract_from_db1() -> List[Dict]:
    print("...extract from db1 \n")
    query = QueryBuilder()
    sql = query.\
        set_comment("some comment")\
        .set_table("app_array as m")\
        .add_getfield("id")\
        .add_getfield("code_erp")\
        .add_getfield("description")\
        .add_getfield("type")\
        .add_and("m.id > 10")\
        .get_select_from()

    pprint(sql)
    r = get_db1().query(sql)
    return r


def transform(r:List[Dict]) -> None:
    print("...transform db1 \n")
    now = datetime.now()
    now = now.strftime("%Y-%m-%d:%H:%M:%S")

    rows = []
    for row in r:
        d = {
            "code_erp"      : row.get("id", ""),
            "description"   : row.get("description", " desc") + " " + now,
            "type"          : row.get("type",None),
            "code_cache"    : uuid.uuid1()
        }
        rows.append(d)
    r = rows


def load_into_db2(r: List[Dict]) -> None:
    print("...load into db2 \n")
    sqls = []
    for i, row in enumerate(r):
        comment = f"row "+str(i)
        query = QueryBuilder()
        query.set_table("app_array").set_comment(comment)
        for field in row:
            value = row.get(field)
            query.add_insert_fv(field, value)

        sqls.append(query.get_insert())

    sqls = ";".join(sqls) + ";"
    db2 = get_db2()
    db2.exec(sqls)


def index():
    delete_db2()
    r = extract_from_db1()
    transform(r)
    load_into_db2(r)

index()

