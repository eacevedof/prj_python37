from typing import Dict, List

from pprint import pprint
from components.querybuilder import QueryBuilder
from components.connector import Connector


def get_db():
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

def extract() -> List[Dict]:
    pprint("extract from db 1 ...")
    query = QueryBuilder()
    sql = query.\
        set_comment("some comment")\
        .set_table("app_array as m").add_getfield("id").add_getfield("code_erp").add_getfield("description")\
        .add_getfield("type")\
        .add_and("m.id > 10")\
        .get_select_from()

    pprint(sql)
    r = get_db().query(sql)
    return r


def transform(r:List[Dict]) -> None:



def load(r: List[Dict]) -> None:
    query = QueryBuilder()
    sql = query\
        .set_comment("some insert")\
        .set_table("app_array")\
        .add_insert_fv("code_erp","un-code-erp")\
        .add_insert_fv("`type`","borrame")\
        .add_insert_fv("code_cache","uuu-1234")\
        .get_insert()

    pprint(sql)
    db = get_db()
    r = db.exec(sql)
    errors = db.get_errors()
    if errors:
        pprint(errors)

    pprint(r)

    id = db.get_lastid()
    pprint(id)


def delete():
    sql = (QueryBuilder())\
        .set_comment("some delete")\
        .set_table("app_array")\
        .add_and("type = 'borrame'")\
        .get_delete()
    pprint(sql)
    db = get_db()
    db.exec(sql)


def index():
    delete()
    extract()
    load()
    transform()

index()

