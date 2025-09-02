from dataclasses import dataclass
from typing import Any, final

from app.shared.infrastructure.controllers.interface_controller_base import InterfaceControllerBase


@final
@dataclass(frozen=True)
class LzRouteType:
    method: str
    pattern: str
    controller: InterfaceControllerBase