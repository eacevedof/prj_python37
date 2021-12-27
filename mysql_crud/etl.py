from typing import Dict, List

from datetime import datetime
import uuid
from pprint import pprint
from components.querybuilder import QueryBuilder
from components.connector import Connector


def delete_db2():
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
    pprint("extract from db 1 ...")
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
    query = QueryBuilder()
    sql = query\
        .set_comment("some insert")\
        .set_table("app_array")\
        .add_insert_fv("code_erp","un-code-erp")\
        .add_insert_fv("`type`","borrame")\
        .add_insert_fv("code_cache","uuu-1234")\
        .get_insert()

    pprint(sql)
    db2 = get_db2()
    r = db2.exec(sql)
    errors = db2.get_errors()
    if errors:
        print("errors:\n")
        pprint(errors)


def index():
    delete_db2()
    r = extract_from_db1()
    transform(r)
    load_into_db2(r)

index()

