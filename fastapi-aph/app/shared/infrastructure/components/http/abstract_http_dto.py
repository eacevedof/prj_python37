from abc import ABC
from typing import Dict, Optional, Any


class AbstractHttpDto(ABC):
    def __init__(self, primitives: Dict[str, Any]):
        self.request_headers: Dict[str, str] = primitives.get("request_headers", {})
        self.request_method: str = (primitives.get("request_method") or "").strip()
        self.request_url: str = (primitives.get("request_url") or "").strip()
        self.remote_ip: str = (primitives.get("remote_ip") or "").strip()
        
        self.os_name: str = (primitives.get("os_name") or "").strip()
        self.os_version: str = (primitives.get("os_version") or "").strip()
        self.user_agent: str = (primitives.get("user_agent") or "").strip()
        
        self.browser_name: str = (primitives.get("browser_name") or "").strip()
        self.browser_version: str = (primitives.get("browser_version") or "").strip()
        
        self.cpu_architecture: str = (primitives.get("cpu_architecture") or "").strip()
        
        self.device_model: str = (primitives.get("device_model") or "").strip()
        self.device_type: str = (primitives.get("device_type") or "").strip()
        
        self.engine_name: str = (primitives.get("engine_name") or "").strip()
        self.engine_version: str = (primitives.get("engine_version") or "").strip()
    
    def _get_request_headers(self) -> Dict[str, str]:
        return self.request_headers
    
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