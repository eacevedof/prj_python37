from enum import Enum


class AppVersionEnum(str, Enum):
    """Versión de la app que publica /health-check."""

    CURRENT = "1.0.0"
