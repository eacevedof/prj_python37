from app.shared.domain.exceptions.domain_exception import DomainException
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum

class AuthenticatorException(DomainException):
    def __init__(self, status_code: int, message: str) -> None:
        super().__init__("AuthenticatorException", status_code, message)
    
    @staticmethod
    def unexpected_custom(message: str) -> None:
        raise AuthenticatorException(
            HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
            message
        )
    
    @staticmethod
    def bad_request_custom(message: str) -> None:
        raise AuthenticatorException(
            HttpResponseCodeEnum.BAD_REQUEST,
            message
        )
    
    @staticmethod
    def unauthorized_custom(message: str) -> None:
        raise AuthenticatorException(
            HttpResponseCodeEnum.UNAUTHORIZED,
            message
        )
    
    @staticmethod
    def forbidden_custom(message: str) -> None:
        raise AuthenticatorException(
            HttpResponseCodeEnum.FORBIDDEN,
            message
        )