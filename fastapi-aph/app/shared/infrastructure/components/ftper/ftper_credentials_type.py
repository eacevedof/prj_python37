from typing import Optional
from dataclasses import dataclass


@dataclass
class FtperCredentialsType:
    host: str
    port: int
    user: str
    password: str
    is_ftps: Optional[bool] = None