from enum import Enum
from typing import final

@final
class HealthCheckRouteEnum(Enum):
    HEALTH_CHECK_V1 = "/health"