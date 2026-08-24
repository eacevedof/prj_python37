from dataclasses import dataclass, field
from typing import Any, Self

from src.modules.emt_mod.domain.enums.emt_result_key_enum import EmtResultKeyEnum


@dataclass(frozen=True, slots=True)
class GetLinesInfoResultDto:
    """Salida del caso de uso: las líneas de la EMT."""

    lines: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        lines = [cls.__get_line_primitives(raw_line) for raw_line in primitives.get("data", [])]

        return cls(
            lines=lines,
            total=len(lines),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            EmtResultKeyEnum.LINES: self.lines,
            EmtResultKeyEnum.TOTAL: self.total,
        }

    @staticmethod
    def __get_line_primitives(raw_line: dict[str, Any]) -> dict[str, Any]:
        """Una línea de la API de EMT traducida al vocabulario del módulo.

        Estático porque lo llama `from_primitives`, que es de la clase y no de
        una instancia. Devuelve un dict y no otro DTO porque un DTO solo lleva
        primitivos.
        """
        return {
            EmtResultKeyEnum.LINE: str(raw_line.get("line", "")),
            EmtResultKeyEnum.LABEL: str(raw_line.get("label", "")),
            EmtResultKeyEnum.NAME_A: str(raw_line.get("nameA", "")),
            EmtResultKeyEnum.NAME_B: str(raw_line.get("nameB", "")),
            EmtResultKeyEnum.GROUP: str(raw_line.get("group", "")),
            EmtResultKeyEnum.START_DATE: str(raw_line.get("startDate", "")),
            EmtResultKeyEnum.END_DATE: str(raw_line.get("endDate", "")),
        }
