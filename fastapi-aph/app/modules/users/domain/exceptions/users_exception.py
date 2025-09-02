from app.shared.domain.exceptions.domain_exception import DomainException
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum

class UsersException(DomainException):
    def __init__(self, status_code: int, message: str) -> None:
        super().__init__("UsersException", status_code, message)
    
    @staticmethod
    def unexpected_custom(message: str) -> None:
        raise UsersException(
            HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
            message
        )
    
    @staticmethod
    def bad_request_custom(message: str) -> None:
        raise UsersException(
            HttpResponseCodeEnum.BAD_REQUEST,
            message
        )
    
    @staticmethod
    def not_found_custom(message: str) -> None:
        raise UsersException(
            HttpResponseCodeEnum.NOT_FOUND,
            message
        )
    
    @staticmethod
    def conflict_custom(message: str) -> None:
        raise UsersException(
            HttpResponseCodeEnum.CONFLICT,
            message
        )