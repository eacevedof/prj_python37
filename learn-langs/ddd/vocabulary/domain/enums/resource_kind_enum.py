"""Enum del tipo de recurso sincronizable al CDN."""

from enum import StrEnum


class ResourceKindEnum(StrEnum):
    """Tipo de recurso local que se sube al CDN."""

    AUDIO = "audio"
    IMAGE = "image"
