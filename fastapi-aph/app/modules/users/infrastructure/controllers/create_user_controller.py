from fastapi import Request
from app.shared.infrastructure.components.http.lz_response import LzResponse
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.enums.http_response_message_enum import HttpResponseMessageEnum
from app.modules.authenticator.application.services.fail_if_wrong_app_auth_token_service import FailIfWrongAppAuthTokenService
from app.modules.authenticator.application.services.fail_if_wrong_app_auth_token_dto import FailIfWrongAppAuthTokenDto
from app.modules.authenticator.domain.exceptions.authenticator_exception import AuthenticatorException
from app.modules.users.application.services.create_user_service import CreateUserService
from app.modules.users.application.services.create_user_dto import CreateUserDto
from app.modules.users.application.services.created_user_dto import CreatedUserDto
from app.modules.users.domain.exceptions.users_exception import UsersException

class CreateUserController:
    def __init__(self):
        self.logger = Logger.get_instance()
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, request: Request, body_data: dict) -> LzResponse:
        try:
            # Validate authentication
            await FailIfWrongAppAuthTokenService.get_instance().invoke(
                FailIfWrongAppAuthTokenDto.from_http_request(request)
            )
            
            # Create user
            created_user_dto: CreatedUserDto = await CreateUserService.get_instance().invoke(
                CreateUserDto.from_http_request(request, body_data)
            )
            
            return LzResponse.from_response_dto_primitives({
                "code": HttpResponseCodeEnum.CREATED,
                "message": "user created successfully",
                "data": created_user_dto.to_primitives()
            })
            
        except (AuthenticatorException, UsersException) as e:
            return LzResponse.from_response_dto_primitives({
                "code": e.get_status_code(),
                "message": e.get_message()
            })
        except Exception as error:
            self.logger.log_exception(error)
            return LzResponse.from_response_dto_primitives({
                "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
                "message": HttpResponseMessageEnum.INTERNAL_SERVER_ERROR.value
            })