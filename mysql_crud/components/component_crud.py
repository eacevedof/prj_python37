from __future__ import annotations
from typing import Optional, Any, List


class ComponentCrud:

    def __init__(self):
        self.__comment = ""
        self.__table = ""

        self.__argetfields = []
        self.__arpks = []
        self.__arnumeric = [] #campos trtados como numeros para evitar '' en los insert/update

        self.__arjoins = []
        self.__arands = []
        self.__arorderby = []
        self.__arhaving = []
        self.__argroupby = []
        self.__arlimit = []

        self.__arinsertfv = []
        self.__arupdatefv = []

        self.__isfoundrows = False
        self.__isdistinct = False

        self.__sql = ""

    def __get_pk_ands(self)->List[str]:
        ands = []
        for d_pk in self.__arpks:
            field = d_pk.get("field", "")
            if not field:
                continue
            value = d_pk.get("value",None)
            if value is None:
                ands.append(f"{field} IS null")
            elif field in self.__arnumeric:
                ands.append(f"{field} = {value}")
            else:
                ands.append(f"{field} = '{value}'")
        return ands

    def get_select_from(self)->str:
        self.__sql = ""
        sql = "-- get_selectfrom"
        if not self.__table or not self.__argetfields:
            return sql

        comment = f"/*{self.__comment}*/" if self.__comment else ""
        sql = f"{comment} SELECT "
        if self.__isfoundrows:
            sql += f"SQL_CAL_FOUND_ROWS "

        if self.__isdistinct:
            sql += f"DISTINCT "

        sql += ", ".join(self.__argetfields)
        sql += f" FROM {self.__table}"
        sql += self.__get_joins()

        ands = self.__get_pk_ands()
        ands += self.__arands

        sql += " WHERE " + " AND ".join(ands) if ands else ""
        sql += self.__get_groupby()
        sql += self.__get_having()
        sql += self.__get_orderby()
        sql += self.__get_limit()

        self.__sql = sql.strip()
        return self.__sql

    def get_insert(self)->str:
        self.__sql = ""
        sql = "-- get_insert"
        if not self.__table:
            return sql

        comment = f"/*{self.__comment}*/" if self.__comment else ""
        sql = f"{comment} INSERT INTO {self.__table} "
        if not self.__arinsertfv:
            return sql

        fields = [item.get("field", "") for item in self.__arinsertfv]
        fields = ", ".join(fields)
        sql += f"({fields}) "
        values = [item.get("value") for item in self.__arinsertfv]
        aux = []
        for value in values:
            if value is None:
                aux.append("null")
            elif value in self.__arnumeric:
                aux.append(value)
            else:
                aux.append(f"'{value}'")
        sql += "VALUES ("+" ,".join(aux)+")"
        self.__sql = sql
        return self.__sql

    def get_delete(self)->str:
        self.__sql = ""
        sql = "-- get_delete"
        if not self.__table or not self.__arands:
            return sql

        comment = f"/*{self.__comment}*/" if self.__comment else ""
        sql = f"{comment} DELETE FROM {self.__table}"

        sql += " WHERE " + " AND ".join(self.__arands) if self.__arands else ""
        self.__sql = sql.strip()
        return self.__sql

    def get_update(self)->str:
        self.__sql = ""
        sql = "-- get_delete"
        if not self.__table:
            return sql

        comment = f"/*{self.__comment}*/" if self.__comment else ""
        sql = f"{comment} UPDATE {self.__table} SET "
        if not self.__arupdatefv:
            return sql

        aux = []
        for dc in self.__arupdatefv:
            field = dc.get("field", "")
            if not field:
                continue
            value = dc.get("value")
            if value is None:
                aux.append(f"{field}=null")
            elif value in self.__arnumeric:
                aux.append(f"{field}={value}")
            else:
                aux.append(f"{field}='{value}'")

        sql += " ,".join(aux)

        ands = self.__get_pk_ands()
        ands += self.__arands
        sql += " WHERE 1 " + ("AND "+" AND ".join(ands)) if ands else ""
        self.__sql = sql.strip()
        return self.__sql

    def __get_joins(self)-> str:
        tmp = ComponentCrud.__get_unique(self.__arjoins)
        strjoins = " " + "\n".join(tmp) if tmp else ""
        return strjoins

    def __get_groupby(self)-> str:
        tmp = ComponentCrud.__get_unique(self.__argroupby)
        strgroupby = " GROUP BY " + ", ".join(tmp) if tmp else ""
        return strgroupby

    def __get_having(self)-> str:
        tmp = ComponentCrud.__get_unique(self.__arhaving)
        strhaving = " HAVING " + ", ".join(tmp) if tmp else ""
        return strhaving

    def __get_orderby(self)-> str:
        tmp = ComponentCrud.__get_unique(self.__arorderby)
        strorderby = " ORDER BY " + ", ".join(tmp) if tmp else ""
        return strorderby

    def __get_limit(self)-> str:
        strlimit = " LIMIT " + ",".join(self.__arlimit) if self.__arlimit else ""
        """
        * si por ejemplo deseo paginar de 10 en 10
        * para la pag:
        *  1 sería LIMIT 0,10   -- 1 a 10
        *  2 LIMIT 10,10        -- 11 a 20
        *  3 LIMIT 20,10        -- 21 a 30
        """
        return strlimit

    def set_table(self, name:str) -> ComponentCrud:
        self.__table = name
        return self

    def set_comment(self, comment:str) -> ComponentCrud:
        self.__comment = comment
        return self

    def add_insert_fv(self, field:str, value:Any, dosanitize:bool = True) -> ComponentCrud:
        self.__arinsertfv.append({
            "field": field,
            "value": self.get_sanitized(value) if dosanitize else value
        })
        return self

    def add_update_fv(self, field:str, value:Any, dosanitize:bool = True) -> ComponentCrud:
        self.__arupdatefv.append({
            "field": field,
            "value": self.get_sanitized(value) if dosanitize else value
        })
        return self

    def set_getfields(self, fields: List[str]) -> ComponentCrud:
        self.__argetfields = fields
        return self

    def add_getfield(self, field:str) -> ComponentCrud:
        self.__argetfields.append(field)
        return self

    def set_joins(self, joins: List[str]) -> ComponentCrud:
        self.__arjoins = joins
        return self

    def set_orderby(self, orderbys: List[str]) -> ComponentCrud:
        self.__arorderby = orderbys
        return self

    def set_groupby(self, groupbys: List[str]) -> ComponentCrud:
        self.__argroupby = groupbys
        return self

    def set_having(self, havings: List[str]) -> ComponentCrud:
        self.__arhaving = havings
        return self

    def set_limit(self, ippage:int=1000, iregfrom:int=0) -> ComponentCrud:
        self.__arlimit = []
        self.__arlimit.append(str(iregfrom))
        self.__arlimit.append(str(ippage))
        if ippage is None:
            self.__arlimit = []
        return self

    @staticmethod
    def get_sanitized(value:str) -> Optional[str]:
        if value is None:
            return None
        if isinstance(value, str):
            return value.replace("'", "\'")
        return value

    @staticmethod
    def __get_unique(array:List)->List:
        return list(set(array))

    def is_distinct(self, ison:bool = True) -> ComponentCrud:
        self.__isdistinct = ison
        return self

    def is_foundrows(self, ison:bool = True) -> ComponentCrud:
        self.__isfoundrows = ison
        return self

    def add_numeric(self, fieldname:str) -> ComponentCrud:
        self.__arnumeric.append(fieldname)
        return self

    def add_and(self, strand:str) -> ComponentCrud:
        self.__arands.append(strand)
        return self

    def add_and_in(self, field:str, values:List, isnum:bool = True) -> ComponentCrud:
        values = list(set(values))
        strin = ",".join(values) if isnum else "','".join(values)
        strin = f"({strin})" if isnum else f"('{strin}')"
        self.__arands.append(f"{field} IN {strin}")
        return self

    def add_join(self, strjoin:str)-> ComponentCrud:
        #to-do key argument
        self.__arjoins.append(strjoin)
        return self

    def add_orderby(self, field:str, sorder:str="ASC")-> ComponentCrud:
        self.__arorderby.append(f"{field} {sorder}")
        return self

    def add_groupby(self, field:str)-> ComponentCrud:
        self.__argroupby.append(field)
        return self

    def add_having(self, field:str)-> ComponentCrud:
        self.__arhaving.append(field)
        return self
