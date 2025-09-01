from abc import ABC
from typing import Dict, Optional, Any
from dataclasses import dataclass


@dataclass(frozen=True)
class AbstractHttpDto(ABC):
    request_method: str = ""
    request_url: str = ""
    remote_ip: str = ""
    user_agent: str = ""
    request_uri: str = ""
    
    os_name: str = ""
    os_version: str = ""
    browser_name: str = ""
    browser_version: str = ""
    cpu_architecture: str = ""
    device_model: str = ""
    device_type: str = ""
    engine_name: str = ""
    engine_version: str = ""
    
    def _get_request_method(self) -> str:
        return self.request_method
    
    def _get_request_url(self) -> str:
        return self.request_url
    
    def _get_remote_ip(self) -> str:
        return self.remote_ip
    
    def _get_os_name(self) -> str:
        return self.os_name
    
    def _get_os_version(self) -> str:
        return self.os_version
    
    def _get_user_agent(self) -> str:
        return self.user_agent
    
    def _get_browser_name(self) -> str:
        return self.browser_name
    
    def _get_browser_version(self) -> str:
        return self.browser_version
    
    def _get_cpu_architecture(self) -> str:
        return self.cpu_architecture
    
    def _get_device_model(self) -> str:
        return self.device_model
    
    def _get_device_type(self) -> str:
        return self.device_type
    
    def _get_engine_name(self) -> str:
        return self.engine_name
    
    def _get_engine_version(self) -> str:
        return self.engine_version