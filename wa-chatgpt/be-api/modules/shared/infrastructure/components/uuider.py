from dataclasses import dataclass, field
from typing import final
import uuid
import hashlib

@final
@dataclass(frozen=True)
class Uuider:

    @staticmethod
    def get_instance() -> "Uuider":
        return Uuider()

    def get_uuid(self) -> str:
        return str(uuid.uuid4())

    def get_id_with_prefix(self, prefix: str) -> str:
        uid = self.get_uuid()
        uid = f"{prefix}-{self.__get_md5(uid)}"
        return uid

    def __get_md5(self, value: str) -> str:
        return hashlib.md5(value.encode()).hexdigest()
