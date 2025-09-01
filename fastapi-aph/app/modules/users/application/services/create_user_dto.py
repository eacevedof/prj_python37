from fastapi import Request
from typing import final
from dataclasses import dataclass

@final
@dataclass(frozen=True)
class CreateUserDto:
    project_uuid: str
    project_user_uuid: str
    request_method: str = ""
    user_agent: str = ""
    remote_ip: str = ""
    request_uri: str = ""
    
    @classmethod
    def from_primitives(cls, project_uuid: str, project_user_uuid: str) -> "CreateUserDto":
        return cls(
            project_uuid=project_uuid.strip(),
            project_user_uuid=project_user_uuid.strip()
        )
    
    @classmethod
    def from_http_request(cls, request: Request, body_data: dict) -> "CreateUserDto":
        return cls(
            project_uuid=body_data.get("project_uuid", "").strip(),
            project_user_uuid=body_data.get("project_user_uuid", "").strip(),
            request_method=request.method,
            user_agent=request.headers.get("user-agent", ""),
            remote_ip=request.client.host if request.client else "",
            request_uri=str(request.url)
        )
    
    def get_project_uuid(self) -> str:
        return self.project_uuid
    
    def get_project_user_uuid(self) -> str:
        return self.project_user_uuid