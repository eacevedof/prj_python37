from dataclasses import dataclass
from typing import final

@final
@dataclass(frozen=True)
class MysqlContextDto:
    dbname: str
    user: str
    password: str
    host: str
    port: str