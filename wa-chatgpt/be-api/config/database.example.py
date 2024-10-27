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