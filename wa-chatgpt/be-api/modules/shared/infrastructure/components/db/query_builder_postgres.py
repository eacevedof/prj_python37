import sys

def get_vals_tags(values):
    lstvals = []
    for val in values:
        lstvals.append("%s")
    return ", ".join(lstvals)


def get_vals_tuple(values):
    tplvalues = tuple()
    for val in values:
        tplvalues = tplvalues + (val,)
    return tplvalues


class QueryBuilder:

    @staticmethod
    def get_insert_dict(table, fields, values):
        strfields = ", ".join(fields)
        strvalues = get_vals_tags(values)
        tplvalues = get_vals_tuple(values)

        sql = f"INSERT INTO {table} ({strfields}) VALUES ( {strvalues} )"
        return {
            "query": sql,
            "tuple": tplvalues
        }

    @staticmethod
    def get_select(table, fields, conds=[]):
        strfields = ", ".join(fields)
        sql = f"SELECT {strfields} FROM {table} WHERE 1"
        if conds:
            strconds = " AND ".join(conds)
            sql += " AND " + strconds
        return sql

    @staticmethod
    def get_update(table, dicfval, conds=[]):
        arfields = []
        for field in dicfval:
            val = dicfval[field]
            arfields.append(f"{field}='{val}'")
        strfields = ", ".join(arfields)

        sql = f"UPDATE {table} SET {strfields} WHERE 1 "
        if conds:
            strconds = " AND ".join(conds)
            sql += " AND " + strconds
        return sql