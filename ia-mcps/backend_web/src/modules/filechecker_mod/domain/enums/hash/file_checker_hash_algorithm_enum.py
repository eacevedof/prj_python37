from enum import StrEnum
from typing import final


@final
class FileCheckerHashAlgorithmEnum(StrEnum):
    """Supported hash algorithms for file signature verification."""

    MD5 = "md5"
    SHA1 = "sha1"
    SHA256 = "sha256"
    SHA512 = "sha512"

"""
┌──────────┬───────────┬─────────────────────────────────────────────────────────────────┐
│  Algori. │ Hex chars │                           Uso                                   │
├──────────┼───────────┼─────────────────────────────────────────────────────────────────┤
│ md5      │    32     │ Comprobación rápida (NO usar para seguridad crítica)             │
├──────────┼───────────┼─────────────────────────────────────────────────────────────────┤
│ sha1     │    40     │ Legado, compatible con muchos distribuidores (evitar si posible) │
├──────────┼───────────┼─────────────────────────────────────────────────────────────────┤
│ sha256   │    64     │ Estándar actual, buen balance seguridad/velocidad (default)      │
├──────────┼───────────┼─────────────────────────────────────────────────────────────────┤
│ sha512   │   128     │ Máxima seguridad, más lento en archivos grandes                 │
└──────────┴───────────┴─────────────────────────────────────────────────────────────────┘
Criterio de selección:
- sha256: uso general y distribuidores modernos (Linux ISOs, Python packages, etc.)
- sha512: cuando el distribuidor lo provee y se requiere máxima seguridad
- md5/sha1: solo para compatibilidad con distribuidores que aún los publican
"""
