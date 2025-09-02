from typing import final
from dataclasses import dataclass

@final
@dataclass(frozen=True)
class ElasticMetaType:
    request_ip: str
    request_uri: str