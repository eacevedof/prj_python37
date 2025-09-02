from enum import Enum
from typing import final

@final
class EnvironmentEnum(Enum):
    LOCAL = "local"
    DEVELOPMENT = "development"
    TESTING = "testing"
    PRODUCTION = "production"