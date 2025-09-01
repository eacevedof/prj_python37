from dataclasses import dataclass
from typing import Any

from app.shared.infrastructure.controllers.interface_controller_base import InterfaceControllerBase


@dataclass
class LzRouteType:
    method: str
    pattern: str
    controller: InterfaceControllerBase