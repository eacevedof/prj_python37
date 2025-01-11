from dataclasses import dataclass
from typing import final

@final
@dataclass(frozen=True)
class PostgresDb:
    dbname="db_vector"
    user="postgres"
    password="root"
    host="localhost"
    port="5432"

@final
@dataclass(frozen=True)
class MysqlDb:
    dbname="lc_sql_agent"
    user="root"
    password="root"
    host="localhost"
    port="3306"