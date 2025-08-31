from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.bootstrap.app_global_map import AppGlobalMap
from app.shared.infrastructure.bootstrap.app_key_enum import AppKeyEnum
from app.modules.projects.infrastructure.repositories.projects_reader_postgres_repository import ProjectsReaderPostgresRepository
from app.modules.authenticator.domain.enums.sys_auth_token_enum import SysAuthTokenEnum
from app.modules.authenticator.application.services.fail_if_wrong_app_auth_token_dto import FailIfWrongAppAuthTokenDto
from app.modules.authenticator.domain.exceptions.authenticator_exception import AuthenticatorException


class FailIfWrongAppAuthTokenService:
    """Authentication service following the original Deno implementation"""
    
    def __init__(self):
        self.logger = Logger.get_instance()
        self.app_global_map = AppGlobalMap.get_instance()
        self.projects_reader_postgres_repository = ProjectsReaderPostgresRepository.get_instance()
        self.check_app_auth_token_dto: FailIfWrongAppAuthTokenDto = None
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, check_app_auth_token_dto: FailIfWrongAppAuthTokenDto):
        """Execute authentication validation following Deno implementation"""
        self.check_app_auth_token_dto = check_app_auth_token_dto
        
        self._fail_if_wrong_input()
        await self._fail_if_wrong_app_auth_token()
        self._check_allowed_sys_auth_tokens_or_fail()
    
    def _fail_if_wrong_input(self):
        """Validate input data"""
        if not self.check_app_auth_token_dto.get_app_auth_token():
            self._log_security_on_wrong_token()
            AuthenticatorException.unauthorized_custom("missing app auth token")
    
    async def _fail_if_wrong_app_auth_token(self):
        """Validate auth token against database projects"""
        project_id = await self.projects_reader_postgres_repository.get_project_id_by_project_auth_token(
            self.check_app_auth_token_dto.get_app_auth_token()
        )
        
        if not project_id:
            self._log_security_on_wrong_token()
            AuthenticatorException.unauthorized_custom("wrong app auth token")
        
        # Store project ID in global map for later use
        self.app_global_map.set(AppKeyEnum.PROJECT_ID, project_id)
    
    def _check_allowed_sys_auth_tokens_or_fail(self):
        """Check system token permissions"""
        if self.check_app_auth_token_dto.get_app_auth_token() == SysAuthTokenEnum.ROOT.value:
            return
        
        if self.check_app_auth_token_dto.get_only_allowed_tokens():
            if self.check_app_auth_token_dto.get_app_auth_token() not in [token.value for token in self.check_app_auth_token_dto.get_only_allowed_tokens()]:
                self._log_security_on_wrong_token("[app auth token not allowed (1)]")
                AuthenticatorException.unauthorized_custom("app auth token not allowed (1)")
        
        if self.check_app_auth_token_dto.get_only_forbidden_tokens():
            if self.check_app_auth_token_dto.get_app_auth_token() in [token.value for token in self.check_app_auth_token_dto.get_only_forbidden_tokens()]:
                self._log_security_on_wrong_token("[app auth token not allowed (2)]")
                AuthenticatorException.unauthorized_custom("app auth token not allowed (2)")
    
    def _log_security_on_wrong_token(self, title: str = "[invalid app auth token]"):
        """Log security event for invalid token"""
        self.logger.log_security({
            "request": {
                "api_token": self.check_app_auth_token_dto.get_app_auth_token(),
                "method": self.check_app_auth_token_dto.get_request_method(),
                "url": self.check_app_auth_token_dto.get_request_url(), 
                "user_agent": self.check_app_auth_token_dto.get_user_agent(),
            },
            "response_code": HttpResponseCodeEnum.UNAUTHORIZED,
        }, title)