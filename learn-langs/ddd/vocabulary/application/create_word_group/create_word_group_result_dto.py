"""DTO de resultado para CreateWordGroupService."""

from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.domain.enums import ResponseCodeEnum


@dataclass(frozen=True, slots=True)
class CreateWordGroupResultDto:
    """DTO de resultado para crear un grupo de palabras."""

    success: bool = False
    group_id: int = 0
    title: str = ""
    description: str = ""
    source: str = ""
    error_message: str = ""
    response_code: int = ResponseCodeEnum.OK

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            success=bool(primitives.get("success", False)),
            group_id=int(primitives.get("group_id", 0)),
            title=str(primitives.get("title", "")),
            description=str(primitives.get("description", "")),
            source=str(primitives.get("source", "")),
            error_message=str(primitives.get("error_message", "")),
            response_code=int(primitives.get("response_code", ResponseCodeEnum.OK)),
        )

    @classmethod
    def ok(cls, group_id: int, title: str, description: str = "", source: str = "") -> Self:
        """Crea un resultado exitoso."""
        return cls(
            success=True,
            group_id=group_id,
            title=title,
            description=description,
            source=source,
            response_code=ResponseCodeEnum.OK,
        )

    # @deuda: el caso de uso devuelve este ResultDto de error en vez de lanzar
    # VocabularyException para que el controller la capture (migrar a raise + catch).
    @classmethod
    def error(cls, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> Self:
        """Crea un resultado de error."""
        return cls(
            success=False,
            error_message=message,
            response_code=code,
        )
