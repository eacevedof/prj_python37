"""Enum del estado del sync de un recurso al CDN."""

from enum import StrEnum


class ResourceSyncStatusEnum(StrEnum):
    """Resultado del intento de sync de un recurso."""

    UPLOADED = "uploaded"  # subido/re-subido al CDN
    SKIPPED = "skipped"  # ya estaba subido y no cambio (md5 igual)
    MISSING = "missing"  # el fichero local no existe
    FAILED = "failed"  # error subiendo
    PENDING = "pending"  # dry-run: se subiria
