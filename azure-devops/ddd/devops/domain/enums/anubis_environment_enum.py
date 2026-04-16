from enum import StrEnum


class AnubisEnvironmentEnum(StrEnum):
    """Anubis API environment options."""

    PRODUCTION = "production"
    DEVELOPMENT = "development"
    LOCAL = "local"
