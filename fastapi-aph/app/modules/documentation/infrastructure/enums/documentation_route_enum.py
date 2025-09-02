from enum import Enum
from typing import final

@final
class DocumentationRouteEnum(Enum):
    V1_DOCUMENTATION = "/"
    CHANGELOG = "/changelog"