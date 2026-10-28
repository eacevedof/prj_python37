"""Enum del alcance del sync de recursos al CDN."""

from enum import StrEnum


class ResourceSyncScopeEnum(StrEnum):
    """Que recursos sincronizar al CDN."""

    ALL = "all"
    AUDIOS = "audios"
    IMAGES = "images"
