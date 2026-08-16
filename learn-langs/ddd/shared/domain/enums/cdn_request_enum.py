"""Contrato HTTP del CDN de recursos (upload.theframework.es): rutas y campos."""

from enum import Enum


class CdnRequestEnum(str, Enum):
    """Endpoints y nombres de campo que espera el CDN multi-tenant."""

    LOGIN_PATH = "/security/login"
    UPLOAD_PATH = "/upload"
    UPLOAD_FIELD = "file"
    TOKEN_POST_KEY = "resource-usertoken"
    FOLDER_POST_KEY = "folderdomain"


class CdnTimeoutEnum(int, Enum):
    """Tiempos de espera (segundos) de las llamadas al CDN."""

    DEFAULT_SECONDS = 120
