from typing import final
from dataclasses import dataclass

@final
@dataclass(frozen=True)
class ElasticHttpMetaType:
    request_ip: str
    request_uri: str