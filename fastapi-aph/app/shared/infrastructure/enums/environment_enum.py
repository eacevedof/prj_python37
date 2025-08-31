from enum import Enum

class EnvironmentEnum(Enum):
    LOCAL = "local"
    DEVELOPMENT = "development"
    TESTING = "testing"
    PRODUCTION = "production"