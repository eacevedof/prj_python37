"""DTO de resultado para GetWordGroupsService."""

from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.domain.enums import ResponseCodeEnum


@dataclass(frozen=True, slots=True)
class WordGroupDto:
    """DTO para representar un grupo de palabras."""

    id: int = 0
    title: str = ""
    description: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            title=str(primitives.get("title", "")),
            description=str(primitives.get("description", "")),
        )


@dataclass(frozen=True, slots=True)
class GetWordGroupsResultDto:
    """DTO de resultado para obtener grupos de palabras."""

    success: bool = False
    groups: tuple[WordGroupDto, ...] = ()
    error_message: str = ""
    response_code: int = ResponseCodeEnum.OK

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        groups_data = primitives.get("groups", [])
        groups = tuple(WordGroupDto.from_primitives(g) for g in groups_data)

        return cls(
            success=bool(primitives.get("success", False)),
            groups=groups,
            error_message=str(primitives.get("error_message", "")),
            response_code=int(primitives.get("response_code", ResponseCodeEnum.OK)),
        )

    @classmethod
    def ok(cls, groups: list[dict]) -> Self:
        """Crea un resultado exitoso."""
        group_dtos = tuple(WordGroupDto.from_primitives(g) for g in groups)
        return cls(
            success=True,
            groups=group_dtos,
            response_code=ResponseCodeEnum.OK,
        )

    @classmethod
    def error(cls, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> Self:
        """Crea un resultado de error."""
        return cls(
            success=False,
            error_message=message,
            response_code=code,
        )
