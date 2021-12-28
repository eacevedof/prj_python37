from components.mysqlqb import MysqlQB
from pprint import pprint


def pr(sql):
    pprint(sql)
    print("\n")


def index():
    sql = (MysqlQB("app_table_xxx AS tm")).set_getfields([
        "field_1 as one", "COUNT(field_2) as two", "field_3 as three"
    ])\
        .add_and("field_1 >1").add_and("field_2 <100").set_comment("this is a comment").is_distinct(ison=True)\
        .add_join("LEFT JOIN app_table_two AS ttwo ON tm.field_1 = ttwo.field_1")\
        .add_groupby("field_1").add_having("COUNT(field_2) > 5").add_orderby("field_1 DESC").set_limit("15")\
        .get_select_from()
    pr(sql)

    sql = (MysqlQB("app_array")).set_comment("some insert")\
        .add_insert_fv("code_erp","un-code-erp")\
        .add_insert_fv("`type`","borrame")\
        .add_insert_fv("code_cache","uuu-1234")\
        .get_insert()
    pr(sql)

    sql = (MysqlQB("app_array")).set_comment("some update")\
        .add_update_fv("code_erp","xxxx")\
        .add_update_fv("`type`","yyyy")\
        .add_update_fv("code_cache","uuu-5248")\
        .add_and("field = 22")\
        .get_update()
    pr(sql)

    somevalue = "'xxx''x'z'x'''x'x'\"'yyy"
    somevalue = MysqlQB.get_sanitized(somevalue)
    sql = (MysqlQB("app_array"))\
        .set_comment("some delete")\
        .set_table("app_array")\
        .add_and("type = 'borrame'")\
        .add_and("fieldy = 22")\
        .add_and(f"fieldx = '{somevalue}'")\
        .get_delete()
    print(sql)


index()
