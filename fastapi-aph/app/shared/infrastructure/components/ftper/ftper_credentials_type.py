from typing import Optional, final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class FtperCredentialsType:
    host: str
    port: int
    user: str
    password: str
    is_ftps: Optional[bool] = None