from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True, slots=True)
class GetMemoryByMetadataDto:
    project: str
    metadata_key: str
    metadata_value: str
