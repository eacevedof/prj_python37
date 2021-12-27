from pprint import pprint
from components.component_crud import ComponentCrud
from components.component_mysql import ComponentMysql

def get_db():
    db = ComponentMysql(arconn={
        "server": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest2",
        #"port": 3307
    })
    return db


def select():
    crud = ComponentCrud()
    sql = crud.\
        set_comment("some comment")\
        .set_table("app_array as m").add_getfield("id").add_getfield("code_erp").add_getfield("description")\
        .add_getfield("type")\
        .add_and("m.id > 10")\
        .get_select_from()

    pprint(sql)
    r = get_db().query(sql)
    pprint(r)

def insert():
    crud = ComponentCrud()
    sql = crud\
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

def update():
    sql = (ComponentCrud())\
        .set_comment("some update")\
        .set_table("app_array")\
        .add_update_fv("code_erp","xxxx")\
        .add_update_fv("`type`","yyyy")\
        .add_update_fv("code_cache","uuu-5248")\
        .add_and("1")\
        .get_update()
    pprint(sql)
    db = get_db()
    db.exec(sql)

def delete():
    sql = (ComponentCrud())\
        .set_comment("some delete")\
        .set_table("app_array")\
        .add_and("type = 'borrame'")\
        .get_delete()
    pprint(sql)
    db = get_db()
    db.exec(sql)

def index():
    delete()
    insert()
    update()
    select()

index()

