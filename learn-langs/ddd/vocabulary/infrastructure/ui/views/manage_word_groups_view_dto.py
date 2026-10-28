"""DTO para ManageWordGroupsView."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ManageWordGroupsViewDto:
    """DTO para la vista de gestión de grupos."""

    groups: tuple[dict[str, Any], ...] = field(default_factory=tuple)
    is_loading: bool = False
    success_message: str | None = None
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        groups_raw = primitives.get("groups", []) or []
        return cls(
            groups=tuple(groups_raw),
            is_loading=bool(primitives.get("is_loading", False)),
            success_message=primitives.get("success_message"),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def loading(cls) -> Self:
        return cls(is_loading=True)

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @classmethod
    def success(cls, groups: list[dict], message: str | None = None) -> Self:
        return cls.from_primitives({
            "groups": groups,
            "success_message": message,
        })
