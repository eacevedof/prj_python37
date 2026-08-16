from typing import final


@final
class LocalProjectConst:
    """Default values and naming literals for local project provisioning."""

    DEFAULT_PORT = 8080
    APP_NAME_PREFIX = "app-"
    SERVER_NAME_PREFIX = "local-"
    DATABASE_NAME_PREFIX = "ci_"
