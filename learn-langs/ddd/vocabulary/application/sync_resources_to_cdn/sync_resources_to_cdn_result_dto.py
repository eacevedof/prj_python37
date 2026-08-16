from dataclasses import dataclass, field
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class SyncResourcesToCdnResultDto:
    """DTO de resultado del sync de recursos al CDN.

    Cada entrada de `resources` es un dict de strings:
    {"kind", "id", "status", "local_path", "url", "md5", "error"}.
    """

    total_resources: int
    uploaded_count: int
    skipped_count: int
    missing_count: int
    failed_count: int
    resources: tuple[dict[str, str], ...] = field(default_factory=tuple)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        resources = tuple(
            dict(resource) for resource in primitives.get("resources", [])
        )

        return cls(
            total_resources=int(primitives.get("total_resources", 0)),
            uploaded_count=int(primitives.get("uploaded_count", 0)),
            skipped_count=int(primitives.get("skipped_count", 0)),
            missing_count=int(primitives.get("missing_count", 0)),
            failed_count=int(primitives.get("failed_count", 0)),
            resources=resources,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "total_resources": self.total_resources,
            "uploaded_count": self.uploaded_count,
            "skipped_count": self.skipped_count,
            "missing_count": self.missing_count,
            "failed_count": self.failed_count,
            "resources": [dict(resource) for resource in self.resources],
        }

    @property
    def success(self) -> bool:
        """Retorna True si no hubo fallos de subida."""
        return self.failed_count == 0
