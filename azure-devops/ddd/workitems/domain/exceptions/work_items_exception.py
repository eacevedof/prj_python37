from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.domain.exceptions.domain_exception import DomainException


@final
class WorkItemsException(DomainException):
    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> None:
        super().__init__(message, code)

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
