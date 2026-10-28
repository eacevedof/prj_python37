from dataclasses import dataclass
from typing import Any, Self

from ddd.vocabulary.domain.enums.resource_sync_scope_enum import ResourceSyncScopeEnum


@dataclass(frozen=True, slots=True)
class SyncResourcesToCdnDto:
    """Input DTO del sync de recursos al CDN. Datos puros, sin validacion."""

    scope: str = ResourceSyncScopeEnum.ALL.value
    dry_run: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        default_scope: str = ResourceSyncScopeEnum.ALL.value
        return cls(
            scope=str(primitives.get("scope", default_scope)).strip().lower(),
            dry_run=bool(primitives.get("dry_run", False)),
        )
