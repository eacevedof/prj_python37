from fastapi import Request
from app.shared.infrastructure.components.http.abstract_http_dto import AbstractHttpDto

class CreateUserDto(AbstractHttpDto):
    project_uuid: str
    project_user_uuid: str
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.project_uuid = kwargs.get("project_uuid", "").strip()
        self.project_user_uuid = kwargs.get("project_user_uuid", "").strip()
    
    @classmethod
    def from_primitives(cls, project_uuid: str, project_user_uuid: str) -> "CreateUserDto":
        return cls(
            project_uuid=project_uuid,
            project_user_uuid=project_user_uuid
        )
    
    @classmethod
    def from_http_request(cls, request: Request, body_data: dict) -> "CreateUserDto":
        return cls(
            project_uuid=body_data.get("project_uuid", ""),
            project_user_uuid=body_data.get("project_user_uuid", ""),
            request_method=request.method,
            user_agent=request.headers.get("user-agent", ""),
            remote_ip=request.client.host if request.client else "",
            request_uri=str(request.url)
        )
    
    def get_project_uuid(self) -> str:
        return self.project_uuid
    
    def get_project_user_uuid(self) -> str:
        return self.project_user_uuid