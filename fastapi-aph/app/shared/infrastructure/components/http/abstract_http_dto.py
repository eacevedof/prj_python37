from abc import ABC
from typing import Optional
from pydantic import BaseModel

class AbstractHttpDto(BaseModel, ABC):
    request_method: Optional[str] = None
    user_agent: Optional[str] = None
    remote_ip: Optional[str] = None
    request_uri: Optional[str] = None
    
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
    
    def get_request_method(self) -> Optional[str]:
        return self.request_method
    
    def get_user_agent(self) -> Optional[str]:
        return self.user_agent
    
    def get_remote_ip(self) -> Optional[str]:
        return self.remote_ip
    
    def get_request_uri(self) -> Optional[str]:
        return self.request_uri