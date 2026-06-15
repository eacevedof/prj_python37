from enum import StrEnum
from typing import final


@final
class MigrationStatusEnum(StrEnum):
    """Estado del procesamiento de una migración."""

    APPLIED = "applied"
    SKIPPED = "skipped"
    FAILED = "failed"
