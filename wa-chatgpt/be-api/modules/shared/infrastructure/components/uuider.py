from dataclasses import dataclass, field
from typing import final
import uuid


@final
@dataclass(frozen=True)
class Uuider:

    @staticmethod
    def get_instance() -> "Uuider":
        return Uuider()

    def get_uuid(self) -> str:
        return str(uuid.uuid4())

    def get_id_with_prefix(self, prefix: str) -> str:
        return f"{prefix}-{self.get_uuid()}"
