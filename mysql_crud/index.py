from pprint import pprint
from components.component_crud import ComponentCrud
from components.component_mysql import ComponentMysql

def get_db():
    db = ComponentMysql(arconn={
        "server": "localhost",
        "user": "root",
        "password": "1234",
        "database": "db_anytest",
        #"port": 3307
    })
    return db

def index():
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
    pass

index()

