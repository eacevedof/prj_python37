from enum import Enum


class EnvironmentEnum(str, Enum):
    """Entornos posibles de APP_ENV."""

    LOCAL = "local"
    DEVELOP = "develop"
    TEST = "test"
    PRODUCTION = "production"
