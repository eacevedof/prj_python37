from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class WorkItemsException(Exception):
    _code: int
    _message: str

    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> None:
        self._message = message
        self._code = code
        super().__init__(self._message)

    @property
    def code(self) -> int:
        return self._code

    @property
    def message(self) -> str:
        return self._message

    @classmethod
    def epic_not_found(cls, epic_id: int) -> "WorkItemsException":
        return cls(f"Epic #{epic_id} not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def task_creation_failed(cls, error: str) -> "WorkItemsException":
        return cls(f"Task creation failed: {error}", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def epic_creation_failed(cls, error: str) -> "WorkItemsException":
        return cls(f"Epic creation failed: {error}", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def query_failed(cls, error: str) -> "WorkItemsException":
        return cls(f"Query failed: {error}", ResponseCodeEnum.INTERNAL_SERVER_ERROR)
