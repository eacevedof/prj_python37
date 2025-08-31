from app.shared.domain.exceptions.domain_exception import DomainException
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum

class ExternalApiForwardException(DomainException):
    def __init__(self, status_code: int, message: str):
        super().__init__("ExternalApiForwardException", status_code, message)
    
    @staticmethod
    def bad_request_custom(message: str):
        raise ExternalApiForwardException(
            HttpResponseCodeEnum.BAD_REQUEST,
            message
        )
    
    @staticmethod
    def not_found_custom(message: str):
        raise ExternalApiForwardException(
            HttpResponseCodeEnum.NOT_FOUND,
            message
        )
    
    @staticmethod
    def unauthorized_custom(message: str):
        raise ExternalApiForwardException(
            HttpResponseCodeEnum.UNAUTHORIZED,
            message
        )
    
    @staticmethod
    def unexpected_custom(message: str):
        raise ExternalApiForwardException(
            HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
            message
        )