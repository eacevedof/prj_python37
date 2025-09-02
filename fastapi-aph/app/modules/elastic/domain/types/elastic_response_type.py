from typing import final
from dataclasses import dataclass

@final
@dataclass(frozen=True)
class ElasticResponseType:
    stdout: str
    stderr: str
    status: int