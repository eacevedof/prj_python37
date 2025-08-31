from typing import List, Optional
from fastapi import Request
from app.shared.infrastructure.components.http.abstract_http_dto import AbstractHttpDto
from app.modules.authenticator.domain.enums.auth_key_enum import AuthKeyEnum

class FailIfWrongAppAuthTokenDto(AbstractHttpDto):
    app_auth_token: str
    only_allowed_tokens: Optional[List[str]] = None
    only_forbidden_tokens: Optional[List[str]] = None
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.app_auth_token = kwargs.get("app_auth_token", "").strip()
        self.only_allowed_tokens = kwargs.get("only_allowed_tokens", [])
        self.only_forbidden_tokens = kwargs.get("only_forbidden_tokens", [])
    
    @classmethod
    def from_primitives(
        cls,
        app_auth_token: str,
        only_allowed_tokens: Optional[List[str]] = None,
        only_forbidden_tokens: Optional[List[str]] = None,
    ) -> "FailIfWrongAppAuthTokenDto":
        return cls(
            app_auth_token=app_auth_token,
            only_allowed_tokens=only_allowed_tokens or [],
            only_forbidden_tokens=only_forbidden_tokens or []
        )
    
    @classmethod
    def from_http_request(cls, request: Request) -> "FailIfWrongAppAuthTokenDto":
        return cls(
            app_auth_token=request.headers.get(AuthKeyEnum.PROJECT_AUTH_TOKEN.value, ""),
            request_method=request.method,
            user_agent=request.headers.get("user-agent", ""),
            remote_ip=request.client.host if request.client else "",
            request_uri=str(request.url)
        )
    
    @classmethod
    def from_http_request_and_allowed(
        cls,
        request: Request,
        only_allowed_tokens: Optional[List[str]] = None,
        only_forbidden_tokens: Optional[List[str]] = None,
    ) -> "FailIfWrongAppAuthTokenDto":
        return cls(
            app_auth_token=request.headers.get(AuthKeyEnum.PROJECT_AUTH_TOKEN.value, ""),
            only_allowed_tokens=only_allowed_tokens or [],
            only_forbidden_tokens=only_forbidden_tokens or [],
            request_method=request.method,
            user_agent=request.headers.get("user-agent", ""),
            remote_ip=request.client.host if request.client else "",
            request_uri=str(request.url)
        )
    
    def get_app_auth_token(self) -> str:
        return self.app_auth_token
    
    def get_only_allowed_tokens(self) -> List[str]:
        return self.only_allowed_tokens or []
    
    def get_only_forbidden_tokens(self) -> List[str]:
        return self.only_forbidden_tokens or []
    
    def get_request_url(self) -> Optional[str]:
        """Get request URL (alias for request_uri for compatibility)"""
        return self.get_request_uri()