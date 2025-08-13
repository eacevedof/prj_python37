from typing import final
from dataclasses import dataclass

from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from modules.shared.domain.exceptions.abstract_domain_exception import AbstractDomainException


@final
# @dataclass(frozen=True)
class CreateUserException(AbstractDomainException):

    def __init__(self, message: str, code: int) -> None:
        self._message = message
        self._code = code
        super().__init__(self._message)


    @staticmethod
    def empty_email() -> None:
        raise CreateUserException(
            "users-tr.empty-email",
            HttpResponseCodeEnum.BAD_REQUEST.value
        )

    @staticmethod
    def empty_user_name() -> None:
        raise CreateUserException(
            "users-tr.empty-user-name",
            HttpResponseCodeEnum.BAD_REQUEST.value
        )

    @staticmethod
    def user_login_already_exists() -> None:
        raise CreateUserException(
            "users-tr.user-login-already-exists",
            HttpResponseCodeEnum.BAD_REQUEST.value
        )

    @staticmethod
    def user_email_already_exists() -> None:
        raise CreateUserException(
            "users-tr.user-email-already-exists",
            HttpResponseCodeEnum.BAD_REQUEST.value
        )
