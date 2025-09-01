from abc import ABC, abstractmethod
from typing import Any, Dict

from app.shared.infrastructure.components.http.lz_response import LzResponse


class InterfaceControllerBase(ABC):
    @abstractmethod
    async def invoke(self, lz_request: Dict[str, Any]) -> LzResponse:
        pass