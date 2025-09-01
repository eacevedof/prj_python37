from typing import Any, Dict, List, Optional, Protocol

from app.shared.infrastructure.components.http.lz_request_body_type_enum import LzRequestBodyTypeEnum


class InterfaceLzRequest(Protocol):
    body: Optional[Dict[str, Any]]
    has_body: bool
    body_type: LzRequestBodyTypeEnum
    headers: Dict[str, str]
    remote_ip: str
    mediators_ips: List[str]
    method: str
    secure: bool
    url: Dict[str, str]
    url_search: Dict[str, str]
    url_params: Dict[str, str]
    user_agent: Dict[str, Any]
    
    def get_header(self, key: str) -> str: ...
    def get_post_parameter(self, key: str, default: Any = None) -> Any: ...
    def get_get_parameter(self, key: str, default: str = "") -> str: ...
    def get_url_parameter(self, key: str, default: str = "") -> str: ...
    def get_url_info(self, key: str, default: str = "") -> str: ...
    def get_domain(self) -> str: ...